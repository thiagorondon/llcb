
use warnings;
use strict;

use Test::More;
use llcb::API;

my $obj = llcb::API->new( csv => 'csv/test.csv' );

my $collection = $obj->update;

is( $collection->count, 1 );

$obj = llcb::API->new( uf => 'SP' );

my @values = $obj->buscar->all;
is( scalar @values,   1 );
is( $values[0]->{uf}, 'SP' );

