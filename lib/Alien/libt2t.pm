package Alien::libt2t;

use strict;
use warnings;
use 5.008001;
use File::ShareDir::Dist ();

# ABSTRACT: Alien::libt2t
# VERSION

=head1 SYNOPSIS

=head1 DESCRIPTION

=head1 CONSTRUCTOR

=head2 new

 my $alien = Alien::libt2t->new;

It is not necessary, but you can create an instance for compatibility
with L<Alien::Base>.

=cut

sub new
{
  my($class) = @_;
  bless {}, $class;
}

=head1 METHODS

=head2 dist_dir

 my $dir = Alien::libt2t->dist_dir;

Returns the directory where the libt2t library is installed.

=cut

sub dist_dir
{
  File::ShareDir::Dist::dist_share('Test2-Tools-FFI');
}

=head2 cflags

 my $flags = Alien::libt2t->cflags;

Returns the compiler flags.

=cut

sub cflags
{
  my($class) = @_;
  my $dist = $class->dist_dir;
  "-I$dist/include ";
}

=head2 libs

 my $libs = Alien::libt2t->libs;

Returns the library flags.

=cut

sub libs
{
  my($class) = @_;
  my $dist = $class->dist_dir;
  "-Wl,-rpath,$dist/lib -L$dist/lib -lt2t ";
}

1;
