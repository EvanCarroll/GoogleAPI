package GoogleAPI::YouTube::Query::Feeds::User;
use strict;
use warnings;
use namespace::autoclean;

use URI;

use Moose;

extends 'GoogleAPI::YouTube::Query';

with 'GoogleAPI::YouTube::Query::Roles::Standard';

has '_username' => (
	isa  => 'Str'
	, is => 'ro'
	, init_arg => 'user_name'
	, default  => 'default'
);

sub _build_uri {
	my $self = shift;
	URI->new (
		sprintf ( "http://gdata.youtube.com/feeds/api/users/%s/uploads", $self->_username )
	);
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::YouTube::Query::Feeds::User

=head1 SYNOPSIS

	my $query = GoogleAPI::YouTube::Query::Feeds::User->new({ user => 'EvanCarroll' });
	$query->uri;
	$query->_username


=head1 DESCRIPTION

A YouTube user information object. If no username is supplied it defaults to "default", which will read from the authorization token.

This class also composes in the L<GoogleAPI::YouTube::Query::Roles::Standard>, and is a subclass of L<GoogleAPI::YouTube::Query>.

=head2 ATTRIBUTES

=over 4

=item

username - reads from the authorization token if not supplied, this is not a query param so you can read from it after instantiation with L<$query-E<gt>_username>

=back

=head1 REFERENCS

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_video_feeds.html#User_Uploaded_Videos>
