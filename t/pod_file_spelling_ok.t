use strict;
use warnings;
use Test::Stream qw( -V1 -Tester );
use Test::Spelling::Hunspell;

plan 3;

set_language_files 'corpus/test.aff', 'corpus/test.dic';

is(
  intercept {; pod_file_spelling_ok 'corpus/bogus.pod' },
  array {
    event Ok => sub {
      call pass => F();
      call name => 'POD spelling for corpus/bogus.pod';
    };
    event Diag => sub {
      call message => 'corpus/bogus.pod does not exist or is unreadable';
    };
    end;
  },
  'missing file',
);

is(
  intercept {; pod_file_spelling_ok 'corpus/empty.pod' },
  array {
    event Ok => sub {
      call pass => T();
      call name => 'POD spelling for corpus/empty.pod';
    };
    end;
  },
  'good file',
);

is(
  intercept {; pod_file_spelling_ok 'corpus/empty.pod', 'custom test name' },
  array {
    event Ok => sub {
      call pass => T();
      call name => 'custom test name';
    };
    end;
  },
  'custom test name',
);
