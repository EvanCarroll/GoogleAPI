package GoogleAPI::YouTube::Query::Custom;
use strict;
use warnings;
use namespace::autoclean;

use Moose;
use Moose::Util::TypeConstraints;
use URI;

extends 'GoogleAPI::YouTube::Query';

with 'GoogleAPI::YouTube::Query::Roles::Standard';

enum 'ORDERBY' => qw( relevance published viewCount rating );
enum 'SAFE_SEARCH' => qw( none moderate strict );

## Search Parameters
	has 'category' => ( isa => 'Str', is => 'ro' );

	has 'language' => ( isa => 'Str', is => 'ro', documentation => 'lr' );

	has 'orderby' => ( isa => 'ORDERBY', is => 'ro' );

	has 'query' => ( isa => 'Str', is => 'ro', documentation => 'q' );

	has 'uploader' => ( isa => 'Str', is => 'ro' );

	has 'safe_search' => ( isa => 'SAFE_SEARCH', is => 'ro', documentation => 'safeSearch' );

sub _build_uri {
	URI->new('http://gdata.youtube.com/feeds/api/videos');
}

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::Youtube::Query::Custom

=head1 DESCRIPTION

A list of methods that correspond to a custom YouTube query. If the method deviates from the official name that the Google Data API uses the attributes documentation to store the name for the link (as per the Google API documentation).

=head1 TODO

Impliment Geo-portions

=head1 REFERENCS

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_api_query_parameters.html> 
