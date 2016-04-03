use FFI::Raw;

my $addOne = FFI::Raw->new(
    'sharedobj.so', 'addOne',
    FFI::Raw::int,
    FFI::Raw::int
);

print $addOne->call(1) . "\n";
