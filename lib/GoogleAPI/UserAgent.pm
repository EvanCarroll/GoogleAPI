package GoogleAPI::UserAgent;
use strict;
use warnings;

use Moose;
use LWP::UserAgent;

has 'ua' => (
	isa => 'LWP::UserAgent'
	, is => 'ro'
	, default => sub { LWP::UserAgent->new }
	, handles => qr/.*/
	, initializer => sub {
		my ( $self, $value, $writerSub, $attributeMeta ) = @_;
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
