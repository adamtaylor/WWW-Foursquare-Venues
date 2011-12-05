# ABSTRACT: Foursquare Venue Class
package WWW::Foursquare::Venues::Venue;

use Moose;
use MooseX::Method::Signatures;
use WWW::Foursquare::Venues::Category;

has 'categories' => (
    isa => 'ArrayRef[WWW::Foursquare::Venues::Category]',
    is => 'rw',
    default => sub { [] },
    traits  => ['Array'],
    handles => {
        all_categories    => 'elements',
        add_category     => 'push',
        map_categories    => 'map',
        filter_categories => 'grep',
        find_category    => 'first',
        get_category     => 'get',
        join_categories   => 'join',
        count_categories  => 'count',
        has_categories    => 'count',
        has_no_categories => 'is_empty',
        sorted_categories => 'sort',
    },

);

has 'here_now_count' => (
    isa => 'Num|Undef',
    is => 'ro',
);

has 'id' => (
    isa => 'Str',
    is => 'ro',
);

has 'address' => (
    isa => 'Str|Undef',
    is => 'ro',
);

has 'city' => (
    isa => 'Str|Undef',
    is => 'ro',
);

has 'distance' => (
    isa => 'Num|Undef',
    is => 'ro',
);

has 'latitude' => (
    isa => 'Num|Undef',
    is => 'ro',
);

has 'longitude' => (
    isa => 'Num|Undef',
    is => 'ro',
);

has 'postcode' => (
    isa => 'Str|Undef',
    is => 'ro',
);

has 'state' => (
    isa => 'Str|Undef',
    is => 'ro',
);

has 'users_count' => (
    isa => 'Num|Undef',
    is => 'ro',
    default => 0,
);

has 'tips_count' => (
    isa => 'Num|Undef',
    is => 'ro',
    default => 0,
);

has 'checkins_count' => (
    isa => 'Num|Undef',
    is => 'ro',
    default => 0,
);

has 'verified' => (
    isa => 'Bool',
    is => 'ro',
);

method new_from_data($class: :$data!) {

    my $instance = $class->new({
        id => ${data}->{id},
        address => ${data}->{location}->{address},
        city => ${data}->{location}->{city},
        distance => ${data}->{location}->{distance},
        latitude => ${data}->{location}->{lat},
        longitude => ${data}->{location}->{lng},
        postcode => ${data}->{location}->{postcode},
        state => ${data}->{location}->{state},
        users_count => ${data}->{stats}->{usersCount},
        tips_count => ${data}->{stats}->{tipsCount},
        checkins_count => ${data}->{stats}->{checkinsCount},
        verified => JSON::is_bool(${data}->{verified}) ? 1 : 0,
    });

    foreach ( @{${data}->{categories}} ) {
        $instance->add_category(
            WWW::Foursquare::Venues::Category->new_from_data( data => $_ )
        );
    }

    return $instance;

}

1;
