package GoogleAPI::UserAgent;
use strict;
use warnings;

use Moose;
use LWP::UserAgent;

with 'GoogleAPI::Auth::ClientLogin::YouTube';

has 'devkey' => ( isa => 'Str', is => 'ro', predicate => 'has_devkey' );

has '_ua' => (
	isa => 'LWP::UserAgent'
	, is => 'ro'
	, default => sub { LWP::UserAgent->new }
	, handles => qr/.*/
	, initializer => sub {
		my ( $self, $value, $writerSub, $attributeMeta ) = @_;
		
		$value->add_handler( 'request_preprepare' => sub {
			my ( $request, $ua, $h ) = @_;

			$request->push_header( 'X-GData-Client' => 'Perl GoogleAPI v1' );

			$request->push_header( 'X-GData-Key' => "key=".$self->devkey )
				if $self->has_devkey
			;

			$request->push_header( 'Authorization' => "GoogleLogin auth=".$self->authkey )
				if $self->meta->does_role('GoogleAPI::Auth::ClientLogin::YouTube')
			;

		} );
		
		$value->add_handler( 'request_prepare' => sub {
			my ( $request, $ua, $h ) = @_;
			my %query_form = $request->uri->query_form;
			$query_form{alt} //= 'json';
			$request->uri->query_form( \%query_form );
		} );
		
		$writerSub->( $value );
	}
);

1;
