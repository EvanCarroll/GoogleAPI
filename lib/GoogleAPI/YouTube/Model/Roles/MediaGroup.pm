package GoogleAPI::YouTube::Model::Roles::MediaGroup;
use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;
use GoogleAPI::Types qw/W3CDTF/;

has [qw/
	media_title media_description media_keywords media_category media_content
	media_credit media_player media_rating media_restriction media_thumbnail
/] => ( isa => 'Str', is => 'ro' );

has [qw/
	yt_aspectratio yt_duration yt_private yt_videoid yt_noembed
/] => ( isa => 'Str', is => 'ro' );

has 'yt_uploaded' => ( isa => W3CDTF , is => 'ro', coerce => 1 );

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::YouTube::Model::Roles::MediaGroup

=head1

Provides basic MediaGroup stuff
