package llcb::Controller::RDF;

use Moose;
use namespace::autoclean;
use llcb::API;
use RDF::Simple::Serialiser;

BEGIN { extends 'Catalyst::Controller' }

sub base : Chained('/base') : PathPart('rdf') : CaptureArgs(0) {
}

sub uf : Chained('base') : PathPart('') : Args(1) {
    my ( $self, $c, $uf ) = @_;

    my $api = llcb::API->new( uf => $uf );

    $c->stash->{llcb} = undef and $c->forward('View::JSON') and $c->detach
      unless uc($uf) =~ /[A-Z]/;

    my @data;
    my $ser = RDF::Simple::Serialiser->new;
    $ser->addns(
        geo     => 'http://www.w3.org/2003/01/geo/wgs84_pos#'
    );

    map {
        my $node = $ser->genid;
        push(
            @data,
            [$node, 'uf', $_->{uf} ],
            [$node, 'city', $_->{cidade} ],
            [$node, 'geo:lat', $_->{latitude} ],
            [$node, 'geo:long', $_->{longitude} ]
          )
    } $api->buscar->all;

    my $rdf = $ser->serialise(@data);
    $c->res->content_type('text/xml');
    $c->res->body($rdf);
}

__PACKAGE__->meta->make_immutable;

1;
