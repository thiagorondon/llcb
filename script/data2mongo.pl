#!/usr/bin/env perl

use warnings;
use strict;

use FindBin qw($Bin);
use lib "$Bin/../lib";

use llcb::API;

my $obj = llcb::API->new( csv => $ARGV[0] );
my $collection = $obj->update;

