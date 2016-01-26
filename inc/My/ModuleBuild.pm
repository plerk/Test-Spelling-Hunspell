package My::ModuleBuild;

use strict;
use warnings;
use base qw( Module::Build );
use Module::Load qw( load );

sub new
{
  my($class, %args) = @_;
  delete $args{requires}->{eval { load('Text::Hunspell'); 1 } ? 'Text::Hunspell::FFI' : 'Text::Hunspell'};
  my $self = $class->SUPER::new(%args);
  $self;
}

1;
