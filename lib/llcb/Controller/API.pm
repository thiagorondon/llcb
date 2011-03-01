
package llcb::Controller::API;

use Moose;
use namespace::autoclean;
use llcb::API;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/base') : PathPart('api') : CaptureArgs(0) {
}

sub uf : Chained('base') : PathPart('') : Args(1) {
    my ( $self, $c, $uf ) = @_;

    my $api = llcb::API->new( uf => $uf );

    $c->stash->{llcb} = undef and $c->forward('View::JSON') and $c->detach
      unless uc($uf) =~ /[A-Z]/;

    my @data;

    map {
        push(
            @data,
            {
                uf        => $_->{uf},
                cidade    => $_->{cidade},
                latitude  => $_->{latitude},
                longitude => $_->{longitude}
            }
          )
    } $api->buscar->all;

    $c->stash->{llcb} = \@data;
    $c->forward('View::JSON');
}

__PACKAGE__->meta->make_immutable;

1;
