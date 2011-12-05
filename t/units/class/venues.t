#!perl

use Test::More tests => 4;
use Test::Exception;

use WWW::Foursquare::Venues;

my $fs = new_ok(
    WWW::Foursquare::Venues => [{ client_secret => 'foo', client_id => 'bar' }]
);

dies_ok { $fs->search } 'search() dies without valid params';
lives_ok { $fs->search( latitude => 1, longitude => 1 ) }
    'search() lives with valid params';
