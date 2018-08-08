package Test2::Tools::FFI;

use strict;
use warnings;
use 5.010;
use base qw( Exporter );
use FFI::Platypus;
use FFI::CheckLib 0.11 ();

# ABSTRACT: Tools for testing FFI
# VERSION

our @EXPORT = qw( ffi );

=head1 SYNOPSIS

 use Test2::V0;
 use Test2::Tools::FFI;

 done_testing;

=head1 DESCRIPTION

=cut

sub ffi
{
  state $singleton;

  unless($singleton)
  {
    $singleton = bless {}, 'Test2::Tools::FFI::Single';
  }

  $singleton;
}

my $ffi = FFI::Platypus->new;
$ffi->package;
$ffi->function(t2t_init => [] => 'void')->call;

package Test2::Tools::FFI::Single;

=head1 FUNCTIONS

=head2 ffi->runtime

 my $ffi = ffi->runtime;

Returns a L<FFI::Platypus> instance connected to the runtime for your module.

=cut

sub runtime
{
  die 'todo';
}

=head2 ffi->test

 my $ffi = ffi->test;

Returns a L<FFI::Platypus> instance connected to the test for your module.

=cut

sub test
{
  my($self) = @_;

  $self->{test} ||= do {
    my $ffi = FFI::Platypus->new;
    my @lib = FFI::CheckLib::find_lib(
      lib => '*',
      libpath => 't/ffi/_build',
      systempath => [],
    );
    Carp::croak("unable to find test lib in t/ffi/_build")
      unless @lib;
    $ffi->lib(@lib);
    $ffi;
  };
}

1;
