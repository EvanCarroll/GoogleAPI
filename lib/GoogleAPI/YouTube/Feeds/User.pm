package GoogleAPI::YouTube::Feeds::User;
use strict;
use warnings;
use namespace::autoclean;

use Moose;

use URI;

has 'username' => (
	isa  => 'Str'
	, is => 'ro'
	, default => 'default'
);

has 'uri' => (
	isa  => 'URI'
	, is => 'ro'
	, default => sub {
		my $self = shift;
		URI->new (
			sprintf ( "http://gdata.youtube.com/feeds/api/users/%s/uploads", $self->username )
		);
	}
);

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::YouTube::Feeds::User

=head1 SYNOPSIS

Google::API::YouTube::Feeds->new({ user => 'EvanCarroll' })->uri;

=head1 DESCRIPTION

A YouTube user information object.

=head2 ATTRIBUTES

=over 4

=item

username

=back

=head1 REFERENCS

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_video_feeds.html#User_Uploaded_Videos>
