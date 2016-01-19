use strict;
use warnings;
use Test::Stream -V1;
use Test::Spelling::Hunspell;

plan 1;

eval { set_pod_parser('My::Pod::Parser') };
diag $@ if $@;

my $parser = eval { get_pod_parser() };
diag $@ if $@;

is ref($parser), 'My::Pod::Parser', 'got the right pod parser';

package
  My::Pod::Parser;

sub new { bless {}, __PACKAGE__ }
