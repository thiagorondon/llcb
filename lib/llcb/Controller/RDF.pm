package llcb::Controller::RDF;

use Moose;
use namespace::autoclean;
use llcb::API;
use RDF::Simple::Serialiser;

use utf8;

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
        rdfs    => 'http://www.w3.org/2000/01/rdf-schema#',
        owl     => 'http://www.w3.org/2002/07/owl#',
        foaf    => 'http://xmlns.com/foaf/0.1/',
        rdf     => 'http://www.w3.org/1999/02/22-rdf-syntax-ns#',
        geo     => 'http://www.w3.org/2003/01/geo/wgs84_pos#'
    );

    my $loop = 1;
    map {
        my $node = '#entry' . $loop; #$ser->genid;
        $loop++;

        push(
            @data,
            [$node, 'rdf:uf', $_->{uf} ],
            [$node, 'rdf:cidade', $_->{cidade} ],
            [$node, 'geo:lat', $_->{latitude} ],
            [$node, 'geo:long', $_->{longitude} ]
          )
    } $api->buscar->all;

    my $rdf = "<?xml version=\"1.0\"?>\n" . $ser->serialise(@data);

    $c->res->content_type('text/xml; charset=utf-8');
    $c->res->body($rdf);
}

__PACKAGE__->meta->make_immutable;

1;
