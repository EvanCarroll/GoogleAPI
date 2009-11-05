package GoogleAPI::YouTube::Query;
use strict;
use warnings;
use namespace::autoclean;

use Moose;
use Moose::Util::TypeConstraints;
use URI;


enum 'FEED' => qw( atom rss json json-in-script );
enum 'ORDERBY' => qw( relevance published viewCount rating );
enum 'SAFE_SEARCH' => qw( none moderate strict );

## For all API Requests
	has 'key' => (
		isa => 'Str'
		, is => 'ro'
		, required => 1
	);
	has 'client' => (
		isa => 'Str'
		, is => 'ro'
	); 

## Search Parameters
	has 'format_feed' => ( isa => 'Maybe[FEED]', is => 'ro', required => 1, documentation => 'alt', default => 'json');

	has 'author' => ( isa => 'Str', is => 'ro' );

	has 'callback' => (
		isa => 'Str'
		, is => 'ro'
		, trigger => sub {
			my $self = shift;
			die 'callback requires $obj->alt to be set to json-in-script'
				unless $self->alt eq 'json-in-script'
			;
		}
	);

	has 'max_results' => ( isa => 'Str', is => 'ro' );

	has 'start_index' => ( isa => 'Str', is => 'ro' );

	has 'strict' => ( isa => 'Bool', is => 'ro', default => 1 );

	has 'version' => ( isa => 'Int', is => 'ro', default => 2, documentation => 'v' );

	has 'category' => ( isa => 'Str', is => 'ro' );

	has 'format_video' => ( isa => 'Int', is => 'ro', documentation => 'format' );

	has 'language' => ( isa => 'Str', is => 'ro', documentation => 'lr' );

	has 'orderby' => ( isa => 'ORDERBY', is => 'ro' );

	has 'query' => ( isa => 'Str', is => 'ro', documentation => 'q' );

	has 'uploader' => ( isa => 'Str', is => 'ro' );

	has 'safe_search' => ( isa => 'SAFE_SEARCH', is => 'ro', documentation => 'safeSearch' );

## Additional parameters for all video feeds:
	has 'restriction' => ( isa => 'Str', is => 'ro' );

has 'uri' => (
	isa  => 'URI'
	, is => 'ro'
	, init_arg => undef
	, lazy => 1
	, default => sub {
		my $self = shift;

		my %query;
		for my $attr ( $self->meta->get_all_attributes ) {
		
			my $v;	
			## IF there is a predicate and it is set
			## or it is there is no predicate, but there is a defined value
			if (
				$attr->has_predicate && $attr->predicate 
				or !$attr->has_predicate && defined $attr->get_raw_value($self)
			) {
				$v = $attr->get_raw_value($self);
			}
			## Else undefined, no predicate, assume not set and skip
			else {
				next;
			}
			
			my $k = $attr->has_documentation ? $attr->documentation : $attr->name;

			$query{ $k } = $v;
		}

		my $uri = URI->new('http://gdata.youtube.com/feeds/api/videos');
		$uri->query_form( \%query );

		$uri;
		
	}
);

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::Youtube::Query

=head1 DESCRIPTION

A list of methods that correspond to a YouTube query. If the method deviates from the official name that the Google Data API uses refer to the name stored in documentation attribute for the link.

=head1 TODO

Impliment Geo-portions

=head1 REFERENCS

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_api_query_parameters.html> 
