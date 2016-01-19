package My::ModuleBuild;

use strict;
use warnings;
use base qw( Module::Build );
use Module::Load qw( load );

sub new
{
  my($class, %args) = @_;
  $args{eval { load('Text::Hunspell'); 1 } ? 'Text::Hunspell' : 'Text::Hunspell::FFI'} = 0;
  my $self = $class->SUPER::new(%args);
  $self;
}

1;
