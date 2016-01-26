use strict;
use warnings;
use Test::Stream qw( -V1 -Tester Subtest );
use Test::Spelling::Hunspell;
use 5.020;
use experimental qw( signatures  );

plan 7;

my $text = '';
my %miss;
my @lang;

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

subtest 'all correct' => sub {

  plan 3;
  $text = 'one two three four';
  %miss = ();

  is(
    intercept {; pod_file_spelling_ok 'corpus/empty.pod' },
    array {
      event Ok => sub {
        call pass => T();
        call name => 'POD spelling for corpus/empty.pod';
      };
      end;
    },
    'single failure',
  );

  is $lang[0], 'corpus/test.aff', 'correct affix file';
  is $lang[1], 'corpus/test.dic', 'correct word list file';
};

subtest 'single mispelling' => sub {

  plan 3;
  $text = "hello gorfdom";
  %miss = ( gorfdom => [qw( one two three )] );

  is(
    intercept {; pod_file_spelling_ok 'corpus/empty.pod' },
    array {
      event Ok => sub {
        call pass => F();
        call name => 'POD spelling for corpus/empty.pod';
      };
      event Diag => sub {
        call message => "  mispelled: 'gorfdom'";
      };
      event Diag => sub {
        call message => '    suggestion: one';
      };
      event Diag => sub {
        call message => '    suggestion: two';
      };
      event Diag => sub {
        call message => '    suggestion: three';
      };
      end;
    },
    'single failure',
  );

  is $lang[0], 'corpus/test.aff', 'correct affix file';
  is $lang[1], 'corpus/test.dic', 'correct word list file';
};

subtest 'double mispelling' => sub {

  set_language_files 'corpus/foo.aff', 'corpus/foo.dic';
  
  plan 3;
  $text = "hello forfdom of gorfdom";
  %miss = (
    forfdom => [qw( one two )],
    gorfdom => [qw( three four )],
  );

  is(
    intercept {; pod_file_spelling_ok 'corpus/empty.pod' },
    array {
      event Ok => sub {
        call pass => F();
        call name => 'POD spelling for corpus/empty.pod';
      };
      event Diag => sub {
        call message => "  mispelled: 'forfdom'";
      };
      event Diag => sub {
        call message => '    suggestion: one';
      };
      event Diag => sub {
        call message => '    suggestion: two';
      };
      event Diag => sub {
        call message => "  mispelled: 'gorfdom'";
      };
      event Diag => sub {
        call message => '    suggestion: three';
      };
      event Diag => sub {
        call message => '    suggestion: four';
      };
      end;
    },
    'double mispell',
  );

  is $lang[0], 'corpus/foo.aff', 'correct affix file';
  is $lang[1], 'corpus/foo.dic', 'correct word list file';
};

subtest 'repeated mispelling' => sub {

  plan 3;
  set_language_files 'corpus/bar.aff', 'corpus/bar.dic';
  $text = "foo foo foo";
  %miss = (
    foo => [qw( one two )],
  );
  
  is(
    intercept {; pod_file_spelling_ok 'corpus/empty.pod' },
    array {
      event Ok => sub {
        call pass => F();
        call name => 'POD spelling for corpus/empty.pod';
      };
      event Diag => sub {
        call message => "  mispelled: 'foo' [ x 3 ]";
      };
      event Diag => sub {
        call message => '    suggestion: one';
      };
      event Diag => sub {
        call message => '    suggestion: two';
      };
      end;
    },
    'repeated mispell',
  );
  
  is $lang[0], 'corpus/bar.aff', 'correct affix file';
  is $lang[1], 'corpus/bar.dic', 'correct word list file';
};

package
  Pod::Spell;

sub new ($class)
{
  bless {}, $class;
}

sub parse_from_filehandle ($self, $infh, $outfh)
{
  print $outfh $text;
}

package
  Text::Hunspell::FFI;

sub new ($class, $aff, $dic)
{
  @lang = ($aff, $dic);
  bless {}, $class;
}

sub check ($self, $word)
{
  !defined $miss{$word};
}

sub suggest ($self, $word)
{
  $miss{$word}->@*;
}
