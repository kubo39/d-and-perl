import std.range : iota;
import std.algorithm : fold, map;

extern(C)
{
    void rt_init();

    void printSum(int start, int end)
    {
        import std.stdio;
        start.iota(end).fold!((a, b) => a + b).writeln;
    }

    int squareSum(int start, int end) pure
    {
        return start.iota(end).map!(a => a * a).fold!((a, b) => a + b);
    }
}
