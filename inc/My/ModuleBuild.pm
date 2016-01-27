use strict;
use warnings;
use 5.020;
use experimental qw( signatures );

package My::ModuleBuild {

  use base qw( Module::Build );
  use Module::Load qw( load );

  sub new ($class, %args)
  {
    delete $args{requires}->{eval { load('Text::Hunspell'); 1 } ? 'Text::Hunspell::FFI' : 'Text::Hunspell'};
    my $self = $class->SUPER::new(%args);
    $self;
  }

}

1;
