#!perl

use Test::More tests => 3;
use Test::Exception;

use WWW::Foursquare::Venues;
# Don't make real API requests in tests
local *WWW::Foursquare::Venues::request = sub { return { venues => [] } };

my $fs = new_ok(
    WWW::Foursquare::Venues => [{ client_secret => 'foo', client_id => 'bar' }]
);

dies_ok { $fs->search } 'search() dies without valid params';
lives_ok { $fs->search( latitude => 1, longitude => 1 ) }
    'search() lives with valid params';
