use 5.020;
use Test2::V0;
use Test::Spelling::Hunspell;

eval { set_pod_parser('My::Pod::Parser') };
diag $@ if $@;

my $parser = eval { Test::Spelling::Hunspell::_get_pod_parser() };
diag $@ if $@;

is ref($parser), 'My::Pod::Parser', 'got the right pod parser';

done_testing;

package
  My::Pod::Parser;

sub new { bless {}, __PACKAGE__ }
