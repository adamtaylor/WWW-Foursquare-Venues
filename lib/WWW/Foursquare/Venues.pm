# ABSTRACT: Foursqure Venues API Wrapper
package WWW::Foursquare::Venues;

use Moose;
with 'WWW::Foursquare::Role::Client';
use WWW::Foursquare::Venues::Venue;
use MooseX::Method::Signatures;
use Ouch;

has 'client_secret' => (
    isa => 'Str',
    is => 'ro',
    required => 1,
);

has 'client_id' => (
    isa => 'Str',
    is => 'ro',
    required => 1,
);

has 'venues' => (
    isa => 'ArrayRef[WWW::Foursquare::Venues::Venue]',
    is => 'rw',
    default => sub { [] },
    traits  => ['Array'],
    handles => {
        all_venues    => 'elements',
        add_venue     => 'push',
        map_venues    => 'map',
        filter_venues => 'grep',
        find_venue    => 'first',
        get_venue     => 'get',
        join_venues   => 'join',
        count_venues  => 'count',
        has_venues    => 'count',
        has_no_venues => 'is_empty',
        sorted_venues => 'sort',
    },

);

my $API_URL = 'https://api.foursquare.com/v2/venues/';

method search(
    Num    :$latitude!,
    Num    :$longitude!,
    Str    :$query?,
    Int    :$limit? = 10,
    Str    :$intent? = "checkin",
    Int    :$radius?,
    Str    :$sw?,
    Str    :$ne?,
    Str    :$category_id?,
    Str    :$url?,
    Str    :$provider_id?,
    Int    :$linked_id?
) {

    my $resp = $self->request( $API_URL . "search?ll=${latitude},${longitude}" );

    my $venues = $resp->{response}->{venues};
    for my $venue ( @{$venues} ) {
        $self->add_venue(
            WWW::Foursquare::Venues::Venue->new_from_data( data => $venue )
        );
    }
}

sub trending {
    my ( $self, %args ) = @_;
}

sub explore {
    my ( $self, %args ) = @_;
}

#sub get_venue {
    #my ( $self, %args ) = @_;
#}

sub categories {
    my ( $self, %args ) = @_;
}

1;
