use Test2::V0 -no_srand => 1;
use Test2::Plugin::FFI::Package;
use Test2::Tools::FFI;

subtest 'ffi->runtime' => sub {

  my $ffi = ffi->runtime;
  isa_ok $ffi, 'FFI::Platypus';
  eval { $ffi->function(t2t_init => [] => 'void') };
  is $@, '';

};

subtest 'ffi->test' => sub {

  my $ffi = ffi->test;
  isa_ok $ffi, 'FFI::Platypus';
  is(
    $ffi->function(myanswer => [] => 'int')->call,
    42,
  );

};

subtest 'ffi->combined' => sub {

  my $ffi = ffi->combined;
  isa_ok $ffi, 'FFI::Platypus';

  eval { $ffi->function(t2t_init => [] => 'void') };
  is $@, '';

  is(
    $ffi->function(myanswer => [] => 'int')->call,
    42,
  );

};

done_testing
