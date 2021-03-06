use Test::More tests => 1;

my $client = ClientTest->new;
isa_ok( $client->ua, 'LWP::UserAgent', 'Client successfully built' );

# Quick class to test the role, built before the rest of the runtime code
BEGIN {
    package ClientTest;
    use Moose;
    with 'WWW::Foursquare::Role::Client';

    sub client_secret { }
    sub client_id { }
    1;
}
