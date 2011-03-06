
package llcb::Controller::API;

use Moose;
use namespace::autoclean;
use llcb::API;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/base') : PathPart('api') : CaptureArgs(0) {
}

sub uf : Chained('base') : PathPart('') : Args(1) {
    my ( $self, $c, $value ) = @_;

    my $api;
    
    if ($value =~ /^[0-9]*$/) {
        $api = llcb::API->new( codigo => $value );
    } else {
        $api = llcb::API->new( uf => $value );
        $c->stash->{llcb} = undef and $c->forward('View::JSON') and $c->detach
            unless uc($value) =~ /[A-Z]/;
    }
    my @data;

    map {
        push(
            @data,
            {
                uf        => $_->{uf},
                cidade    => $_->{cidade},
                latitude  => $_->{latitude},
                longitude => $_->{longitude},
                codigo    => $_->{codigo}
            }
          )
    } $api->buscar->all;

    $c->stash->{llcb} = \@data;
    $c->forward('View::JSON');
}

__PACKAGE__->meta->make_immutable;

1;
