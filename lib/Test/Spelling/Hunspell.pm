package Test::Spelling::Hunspell;

use strict;
use warnings;

# ABSTRACT: Check for spelling errors in POD files using hunspell
# VERSION

=head1 DESCRIPTION

Test POD Files for spelling errors using Hunspell (either via
L<Text::Hunspell> or L<Text::Hunspell::FFI>).

There are already a few spell checking modules on CPAN, but most
either look for very spcific sort of spelling errors, or use a
variety of different checkers depending on what is available.
This module is intended to be a little more repeatable, by
requiring a specific dictionary / word list be specified, and
by only working with a recent version of Hunspell.

This module should still only be used as a developer test, but
hopes to be a little less annoying for a developer like me who
switches between many different platforms and configurations
and wants a test that is a little more consistent.

=head1 SEE ALSO

=over 4

=item L<Test::Spelling>

=item L<Test::Pod::Spelling>

=item L<Text::Hunspell>

=item L<Text::Hunspell::FFI>

=back

=cut

1;
