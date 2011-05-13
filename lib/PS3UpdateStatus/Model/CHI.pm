package PS3UpdateStatus::Model::CHI;
use strict;
use warnings;
use base 'Catalyst::Model::Adaptor';

# CHI->new expects the arguments as a list, so we overdrive this
# method from C::M::Adaptor to flatten it. By default the args are
# passed as a hashref.
#
sub mangle_arguments {
    my ($self, $args) = @_;
    return %$args;
}

1;
