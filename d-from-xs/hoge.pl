use lib './lib';
use lib './blib/arch/auto/Hello';
use Hello;

Hello::hello();

print "\n";

Hello::initializeD();
Hello::createCounterFromXS();
Hello::incrementFromXS();
print Hello::getCountFromXS() . "\n";
Hello::finalizeD();
