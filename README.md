# Test2::Tools::FFI [![Build Status](https://secure.travis-ci.org/Perl5-FFI/Test2-Tools-FFI.png)](http://travis-ci.org/Perl5-FFI/Test2-Tools-FFI)

Tools for testing FFI

# SYNOPSIS

    use Test2::V0;
    use Test2::Tools::FFI;

    done_testing;

# DESCRIPTION

# FUNCTIONS

## ffi->runtime

    my $ffi = ffi->runtime;

Returns a [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) instance connected to the runtime for your module.

## ffi->test

    my $ffi = ffi->test;

Returns a [FFI::Platypus](https://metacpan.org/pod/FFI::Platypus) instance connected to the test for your module.

# AUTHOR

Graham Ollis <plicease@cpan.org>

# COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by Graham Ollis.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.
