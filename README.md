# D言語とPerl 5

さて、いまどきCなんか書きたくないわけです。

なのでC言語以外で拡張を書く道を模索していきます。ただし、環境はPerl 5.14.4で。やむにやまれぬ事情というものがあり。。perl-xs crateなんかで使ってるOuroborusを使った手法は使えません。Perlの内部APIを叩く道はいったん諦めます。

となるとFFI::Rawか、一部XSで書いてオブジェクトファイルとリンクして呼び出すことを思いつきます。

ランタイムが邪魔になる言語を避けたいとなるとC++, D言語, Rust, Nimあたりが候補になってきます。ここではその他すべてのオプションを忘れてD言語を使っていきましょう。

# D言語

D言語はコンパイラ実装がいくつかありますが、ここではメジャーなDMDとLDCを使っていきます。

## FFI::Raw

### DMD

D言語側こういうコードを用意します。

```d
extern(C):
nothrow:
@nogc:
@system:

int addOne(int x)
{
  return x + 1;
}
```

これで `dmd -shared -betterC -fPIC -oflibsharedobj.so sharedobj.d` とかしてやります。なんか libsharedobj.so とかいうのができるはずです。

Perlコードをこういう感じで用意してやります。

```pl
use FFI::Raw;

my $addOne = FFI::Raw->new(
    'libsharedobj.so', 'addOne',
    FFI::Raw::int,
    FFI::Raw::int
);

print $addOne->call(1) . "\n";
```

なんかよくわかんないけどできました。

```
$ perl sharedobj.pl
2
```

勝ったなガハハ！w

### LDC

LDCにはldc2コマンド -betterCオプションはないですが、`pragma(LDC_no_moduleinfo)` というものがあります。これは後々解説します。dmdと互換なコマンドラインオプションを渡せるldmd2コマンドから-betterCオプションを渡すとたぶん同じかんじになります。

```d
extern(C):
nothrow:
@nogc:
@system:

version(LDC)
pragma(LDC_no_moduleinfo);

int addOne(int x)
{
  return x + 1;
}
```

コマンドは `ldc2 -shared -relocation-model=pic sharedobj.d` となります、少々指定が違うことに注意してください。-relocation-model=picは意味は-fPICと同じです。

同様に

```console
$ perl sharedobj.pl
2
```

いけました。

## XSから

### dmd

こういうD言語コードを書いてみます。

```d
extern(C):
nothrow:
@nogc:
@system:

int fibonacci(int n) pure
{
    return n < 2 ? n : fibonacci(n-1) + fibonacci(n-2);
}
```

オブジェクトファイルの生成まではいけましたが、 `Can't load './blib/arch/auto/Hello/Hello.so' for module Hello: ./blib/arch/auto/Hello/Hello.so: undefined symbol: __dmd_personality_v0` こんな怒られ方をしてしまいました。

` __dmd_personality_v0` というのはいったいなんでしょうか。これはDWARF形式の例外情報を参照するためにD runtimeがもっている関数です。詳しくは [Unwind Library Interfaceの仕様](http://www.ucw.cz/~hubicka/papers/abi/node25.html) を読んでね。

というわけでStubを差し込んでやります。

```
version(DigitalMars)
{
    __gshared void _d_dso_registry() {}
    __gshared void* __dmd_personality_v0;
}
```

エレガントとは言い難いですが、これで問題解決しました。

### ldc

LDCは上述の `pragma(LDC_no_moduleinfo)` を定義してやればいいです。

## Conditional Compile

コンパイラごとにソースを書くのは手間なので、`version` による分岐でよしなにします。

```d
extern(C):
nothrow:
@nogc:
@system:

version(DigitalMars)
{
    __gshared void _d_dso_registry() {}
    __gshared void* __dmd_personality_v0;
}
version(LDC)
pragma(LDC_no_moduleinfo);

int fibonacci(int n) pure
{
    return n < 2 ? n : fibonacci(n-1) + fibonacci(n-2);
}
```

## おまけ

D言語は強力な最適化と便利な標準ライブラリがあるので、慣れてくるとどんどん使いたくなっていきます。

```d
import std.range : iota;
import std.algorithm : fold, map;

extern(C)
{
    void printSum(int start, int end)
    {
        import std.stdio;
        start.iota(end).map!(a => a * a).fold!((a, b) => a + b).writeln;
    }
}
```

```pl
use FFI::Raw;

my $squareSum = FFI::Raw->new(
    'libfoo.so', 'squareSum',
    FFI::Raw::int,
    FFI::Raw::int,
    FFI::Raw::int,
);

print $squareSum->call(1, 5) . "\n";
```

さてこういうのはどうでしょうか。

```d
import std.range : iota;
import std.algorithm : fold, map;

extern(C)
{
    void printSum(int start, int end)
    {
        import std.stdio;
        start.iota(end).fold!((a, b) => a + b).writeln;
    }
}
```

```pl
my $printSum = FFI::Raw->new(
    'libfoo.so', 'printSum',
    FFI::Raw::void,
);

$printSum->call();
```

これは実行してみるとSEGVになったりバッファがデッドロックしてしまったりします。

```console
$ perl foo.pl
Segmentation fault
```

D言語は `rt_init` という関数でruntimeの初期化(GCヒープの割当など)をするのですが、それをスキップした状態で動かしているので予期しない状態になりました。

それでは `rt_init` を事前に呼ぶようにしてみましょう。

```console
$ perl foo.pl
30
uncaught exception
dwarfeh(224) fatal error
中止
```

....はい、ちゃんとruntime側が補足するようになりましたね！！これはタイミング問題でうまくいたりいかなかったりします。大抵だめです。なんにせよ２つのランタイムが動作すると予期しない挙動をするので、両方のランタイムを詳細に理解しない限りはD言語側のランタイムを呼び出すのはやめたほうがよさそうです。
