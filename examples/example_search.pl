#!/usr/bin/perl

use strict;
use warnings;
use FindBin::libs;
use DDP;
use WWW::Foursquare::Venues;

my $fs = WWW::Foursquare::Venues->new({
    # Replace with real values, see: https://developer.foursquare.com/
    client_secret => 'xxxxxxx',
    client_id => 'xxxxxx'
});

# Perform a serach for anything near Durham, UK.
$fs->search( latitude => 54.775586, longitude => -1.586721 );

foreach ( @{$fs->venues} ) {
    warn p $_;
}
