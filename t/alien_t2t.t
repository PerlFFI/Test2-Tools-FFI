use Test2::V0 -no_srand => 1;
use Alien::t2t;

subtest 'basics' => sub {

  isa_ok(Alien::t2t->new, 'Alien::t2t'); # we don't actually use this.

  ok(Alien::t2t->cflags);
  ok(Alien::t2t->libs);

  diag '';
  diag '';
  diag '';
  diag("cflags = @{[ Alien::t2t->cflags ]}");
  diag("libs   = @{[ Alien::t2t->libs   ]}");
  diag '';
  diag '';

};

done_testing;
