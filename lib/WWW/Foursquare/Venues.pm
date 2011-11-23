# ABSTRACT: Foursqure Venues API Wrapper
package WWW::Foursquare::Venues;

use Moose;
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
);

method search(
    Int    :$latitude!,
    Int    :$longitude!,
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

    #ouch 'missing_param', 'You need to at least specify a latlon', %args
        #unless $args{latlon};

}

sub trending {
    my ( $self, %args ) = @_;
}

sub explore {
    my ( $self, %args ) = @_;
}

sub get_venue {
    my ( $self, %args ) = @_;
}

sub categories {
    my ( $self, %args ) = @_;
}

1;
