package Hello;

our $VERSION = '0.01';

require XSLoader;
XSLoader::load('Hello', $VERSION);

1;
