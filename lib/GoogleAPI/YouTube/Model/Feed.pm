package GoogleAPI::YouTube::Model::Feed;
use strict;
use warnings;
use namespace::autoclean;

use Moose;
use GoogleAPI::YouTube::Model::Entry;

extends 'GoogleAPI::YouTube::Model';

has 'entries' => (
	isa  => 'ArrayRef[GoogleAPI::YouTube::Model::Entry]'
	, is => 'ro'
	, default => sub { +[] }
	, traits  => ['Array']
	, handles => {
		add_entry => 'push'
	}
);

has 'generator_content' => ( isa => 'Str', is => 'ro' );
has 'generator_uri' => ( isa => 'Str', is => 'ro' );
has 'generator_version' => ( isa => 'Str', is => 'ro' );

has [qw/
	opensearch_total_results
	opensearch_start_index
	opensearch_items_per_page
/] => ( isa => 'Int' , is => 'ro' );

has '_feed' => (
	isa  => 'HashRef'
	, is => 'ro'
	, trigger => sub {
		my ( $self, $feed ) = @_;
		
		foreach my $entry ( @{$feed->{entry}} ) {
			$self->new_entry({
				name          => $entry->{author}[0]{name}{'$t'}
				, uri         => $entry->{author}[0]{uri}{'$t'}
				, title       => $entry->{title}{'$t'}
				, published   => $entry->{published}{'$t'}
				, updated     => $entry->{updated}{'$t'}
				, id          => $entry->{id}{'$t'}
				, content     => $entry->{content}{'$t'}
				
				, yt_videoid  => $entry->{'media$group'}{'yt$videoid'}
				, yt_duration => $entry->{'media$group'}{'yt$duration'}{'seconds'}
				, yt_uploaded => $entry->{'media$group'}{'yt$uploaded'}{'$t'}

				, media_title       => $entry->{'media$group'}{'media$title'}{'$t'}
				, media_credit      => $entry->{'media$group'}{'media$credit'}[0]{'$t'}
				, media_description => $entry->{'media$group'}{'media$description'}{'$t'}
				, media_keywords    => $entry->{'media$group'}{'media$keywords'}{'$t'}
				
				## XXX in author feed, this is an array, in query feed it is a single element
				## http://code.google.com/p/gdata-issues/issues/detail?id=1597
				## , media_player      => $entry->{'media$group'}{'media$player'}{'url'}
			});
		}

	}
);

sub new_entry {
	my $self = shift;
	my $e = GoogleAPI::YouTube::Model::Entry->new( @_ );
	$self->add_entry( $e );
}

sub BUILDARGS {
	my $class = shift;

	use JSON;
	
	## Sure, lets handle, json mapping here.
	if (
		@_ == 1
		&& blessed $_[0] eq 'HTTP::Response'
		&& $_[0]->header('Content-Type')
	) {
		my $resp = shift;
		
		my $json = JSON::from_json( $resp->content );
		
		my $feed = $json->{feed};
		use XXX; YYY $feed;

		return {

			_feed   => $feed
			, id    => $feed->{id}{'$t'}
			, title => $feed->{title}{'$t'}
			, name  => $feed->{author}[0]{name}{'$t'}
			, uri   => $feed->{author}[0]{uri}{'$t'}

			, updated => $feed->{updated}{'$t'}

			, generator_content => $feed->{generator}{'$t'}
			, generator_uri     => $feed->{generator}{uri}
			, generator_version => $feed->{generator}{version}
	
			, opensearch_total_results  => $feed->{'openSearch$totalResults'}{'$t'}
				,	opensearch_start_index    => $feed->{'openSearch$startIndex'}{'$t'}
				,	opensearch_items_per_page => $feed->{'openSearch$itemsPerPage'}{'$t'}

		}
	
	}
	else {
		return $class->SUPER::BUILDARGS(@_);
	}
	
}

__PACKAGE__->meta->make_immutable;
