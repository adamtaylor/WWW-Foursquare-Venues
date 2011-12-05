package WWW::Foursquare::Venues::Category;

use Moose;
use MooseX::Method::Signatures;

has 'id' => (
    isa => 'Str',
    is => 'ro',
);

has 'name' => (
    isa => 'Str',
    is => 'ro',
);

has 'plural_name' => (
    isa => 'Str',
    is => 'ro',
);

has 'primary' => (
    isa => 'Bool',
    is => 'ro',
);

has 'short_name' => (
    isa => 'Str',
    is => 'ro',
);

method new_from_data($class: :$data!) {
    return $class->new({
        id => ${data}->{id},
        name => ${data}->{name},
        plural_name => ${data}->{pluralName},
        primary => JSON::is_bool(${data}->{primary}) ? 1 : 0,
        short_name => ${data}->{shortName},
    });
}

1;
