use lib './lib';
use lib './blib/arch/auto/Hello';
use Hello;

print Hello::xs_fibonacci(20) . "\n";
