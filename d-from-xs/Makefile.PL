use 5.014001;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'Hello',
    VERSION_FROM      => 'lib/Hello.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/Hello.pm', # retrieve abstract from module
       AUTHOR         => 'kubo39') : ()),
    LIBS              => ['-L/usr/lib/x86_64-linux-gnu -lphobos2'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '-I.', # e.g., '-I. -I/usr/include/other'
    # Un-comment this if you add C files to link with later:
    OBJECT            => 'Hello.o dhello.o', # link all the C files too
    );
