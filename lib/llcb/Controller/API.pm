
package llcb::Controller::API;

use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/base') : PathPart('api') : CaptureArgs(0) {
}

sub estado : Chained('base') : PathPart('') : Args(1) {
    my ( $self, $c, $estado ) = @_;

}

sub cidade : Chained('base') : PathPart('') : Args(2) {
    my ( $self, $c, $estado, $cidade ) = @_;
}

sub render : Private {
    my ( $self, $c ) = @_;

}

__PACKAGE__->meta->make_immutable;

1;
