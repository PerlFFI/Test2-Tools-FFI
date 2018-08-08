use Test2::V0 -no_srand => 1;
use Test2::Plugin::FFI::Package;
use Test2::Tools::FFI;

subtest 'ffi->runtime' => sub {

  my $ffi = ffi->runtime;
  isa_ok $ffi, 'FFI::Platypus';
  eval { $ffi->function(t2t_init => [] => 'void') };
  is $@, '';

  ffi->runtime->symbol_ok('t2t_init');

  is(
    intercept { ffi->runtime->symbol_ok('xxx') },
    array {
      event Fail => sub {
        call name => 'Library has symbol: xxx';
        call facet_data => hash {
          field info => array {
            item {details => match qr{looked in .*/.*t2t}, debug => 1, tag => 'DIAG' };
          };
          etc;
        };
      };
      end;
    },
  );
};

subtest 'ffi->test' => sub {

  my $ffi = ffi->test;
  isa_ok $ffi, 'FFI::Platypus';
  is(
    $ffi->function(myanswer => [] => 'int')->call,
    42,
  );

  ffi->test->symbol_ok('myanswer');

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

  ffi->combined->symbol_ok('t2t_init');
  ffi->combined->symbol_ok('myanswer');
};

done_testing
