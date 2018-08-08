package Alien::t2t;

use strict;
use warnings;
use 5.008001;
use File::ShareDir::Dist ();

sub new
{
  my($class) = @_;
  bless {}, $class;
}

sub dist_dir
{
  File::ShareDir::Dist::dist_share('Test2-Tools-FFI');
}

sub cflags
{
  my($class) = @_;
  my $dist = $class->dist_dir;
  "-I$dist/include ";
}

sub libs
{
  my($class) = @_;
  my $dist = $class->dist_dir;
  "-Wl,-rpath,$dist/lib -L$dist/lib -lt2t ";
}

1;
