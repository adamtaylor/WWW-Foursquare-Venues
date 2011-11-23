package WWW::Foursquare::Role::Client;

use Moose::Role;
use LWP::UserAgent;
use JSON;
use Carp qw/ croak /;

requires 'client_secret';
requires 'client_id';

has 'ua' => (
    isa => 'LWP::UserAgent',
    is => 'ro',
    lazy_build => 1,
);

sub _build_ua {
    my ( $self ) = @_;

    return LWP::UserAgent->new;
}

sub request {
    my ( $self, $url ) = @_;

    croak "URL required" unless $url;

    my $resp = $self->ua->request( $self->_api_url( $url ) );

    if ( $resp->is_success ) {
        return json_decode $resp->content;
    }
    else {
        croak "Request failed: " . $resp->content;
    }
}

sub _api_url {
    my $self = shift;
    my $url  = shift;

    return $url . "client_id=" . $self->client_id
        . "&client_secret=" . $self->client_secret;
}

1;
