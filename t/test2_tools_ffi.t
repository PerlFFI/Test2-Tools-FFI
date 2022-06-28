use Test2::V0 -no_srand => 1;
use Test2::Plugin::FFI::Package;
use Test2::Tools::FFI;

subtest 'ffi->runtime' => sub {

  my $ffi = ffi->runtime;

  is
    $ffi,
    object {
      call [ isa => 'FFI::Platypus' ] => T();
      call api => 0;
      call [ symbol_ok => 't2t_simple_init' ] => T();
    },
  ;

  try_ok { $ffi->function(t2t_simple_init => [] => 'void') };

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

  is
    $ffi,
    object {
      call [ isa => 'FFI::Platypus' ] => T();
      call api => 0;
      call [ function => myanswer => [] => 'int' ] => object {
        call call => 42;
      };
      call [ symbol_ok => 'myanswer' ] => T();
    },
  ;

};

subtest 'ffi->combined' => sub {

  my $ffi = ffi->combined;

  is
    $ffi,
    object {
      call [ isa => 'FFI::Platypus' ] => T();
      call api => 0;
      call [ function => 'myanswer' => [] => 'int' ] => object {
        call call => 42;
      };
      call [ symbol_ok => 't2t_simple_init' ] => T();
      call [ symbol_ok => 'myanswer' ] => T();
    }
  ;

  try_ok { $ffi->function(t2t_simple_init => [] => 'void') };
};

subtest 'call diagnostics from c' => sub {
  is(
    intercept {
      ffi->test->function(test_simple_diagnostics => [] => 'void')->call;
    },
    array {
      event Note => sub {
        call message => 'this is debug information, may not be critical';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 12 test_simple_diagnostics )];
            etc;
          };
          etc;
        };
      };
      event Diag => sub {
        call message => 'this is IMPORTANT, make sure we see it';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 14 test_simple_diagnostics )];
            etc;
          };
          etc;
        };
      };
      end;
    },
  );

  is(
    intercept {
      ffi->test->function(test_format_diagnostics => [] => 'void')->call;
    },
    array {
      event Note => sub {
        call message => 'note number = 42';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 20 test_format_diagnostics )];
            etc;
          };
          etc;
        };
      };
      event Diag => sub {
        call message => 'diag number = 47';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 21 test_format_diagnostics )];
            etc;
          };
          etc;
        };
      };
    },
  );
};

subtest 'call pass/fail from c' => sub {

  is(
    intercept {
      ffi->test->function(test_simple_passfail => [] => 'void')->call;
    },
    array {
      event Pass => sub {
        call name => 'this is a passing test';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 26 test_simple_passfail )];
            etc;
          };
          etc;
        };
      };
      event Fail => sub {
        call name => 'this is a failing test';
        call facet_data => hash {
          field trace => hash {
            field frame => [qw( c t/ffi/test.c 27 test_simple_passfail )];
            etc;
          };
          etc;
        };
      };
      end;
    },
  );

};

done_testing
