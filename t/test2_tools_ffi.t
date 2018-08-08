use Test2::V0 -no_srand => 1;
use Test2::Tools::FFI;

subtest 'ffi->test' => sub {

  my $ffi = ffi->test;
  isa_ok $ffi, 'FFI::Platypus';
  is(
    $ffi->function(myanswer => [] => 'int')->call,
    42,
  );

};

done_testing
