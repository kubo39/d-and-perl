use FFI::Raw;

my $squareSum = FFI::Raw->new(
    'libfoo.so', 'squareSum',
    FFI::Raw::int,
    FFI::Raw::int,
    FFI::Raw::int,
);

print $squareSum->call(1, 5) . "\n";

my $rt_init = FFI::Raw->new(
    'libfoo.so', 'rt_init',
    FFI::Raw::void
);

my $printSum = FFI::Raw->new(
    'libfoo.so', 'printSum',
    FFI::Raw::void,
);

$rt_init->call();
$printSum->call();
