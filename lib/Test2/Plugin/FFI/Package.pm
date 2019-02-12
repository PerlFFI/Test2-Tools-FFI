package Test2::Plugin::FFI::Package;

use strict;
use warnings;
use 5.008001;
use FFI::CheckLib 0.11 qw( find_lib );
use Cwd qw( getcwd );
use File::Basename qw( basename );

# ABSTRACT: Plugin to test bundled FFI code without EUMM
# VERSION

=head1 SYNOPSIS

 use Test2::Plugin::FFI::Package;

=head1 DESCRIPTION

=cut

sub import
{
  require FFI::Platypus;

  my $old = \&FFI::Platypus::package;
  my $new = sub {
    my($ffi, $module, $modlibname) = @_;
    ($module, $modlibname) = caller() unless defined $modlibname;
    my $dist = $module;
    $dist =~ s/::/-/g;
    if(basename(getcwd()) eq $dist)
    {
      my @lib = find_lib(
        lib        => '*',
        libpath    => 'share/lib',
        systempath => [],
      );
      if(@lib)
      {
        $ffi->lib(@lib);
        return;
      }
    }
    $old->($ffi, $module, $modlibname);
  };

  no warnings 'redefine';
  *FFI::Platypus::package = $new;
}

1;
