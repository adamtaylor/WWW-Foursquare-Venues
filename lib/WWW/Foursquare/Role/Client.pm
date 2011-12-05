package WWW::Foursquare::Role::Client;

use Moose::Role;
use LWP::UserAgent;
use JSON;
use DateTime;
use Ouch;

# The point at which this library was last verified to work with the API
my $CLIENT_VERIFIED = DateTime->new( year => 2011, month => 11, day => 23 );

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

    ouch 'missing_param', 'URL required', 'url' unless $url;

    my $resp = $self->ua->get( $self->_api_url( $url ) );

    if ( $resp->is_success ) {
        return decode_json $resp->content;
    }
    else {
        ouch $resp->code, 'There was an API request error', $resp->content;
    }
}

sub _api_url {
    my $self = shift;
    my $url  = shift;

    return $url . "&client_id=" . $self->client_id
        . "&client_secret=" . $self->client_secret
        . "&v=" . $CLIENT_VERIFIED->ymd('');
}

1;
