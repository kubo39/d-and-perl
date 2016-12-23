use FFI::Raw;

my $addOne = FFI::Raw->new(
    'libsharedobj.so', 'addOne',
    FFI::Raw::int,
    FFI::Raw::int
);

print $addOne->call(1) . "\n";
