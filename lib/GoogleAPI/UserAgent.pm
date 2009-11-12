package GoogleAPI::UserAgent;
use strict;
use warnings;
use namespace::autoclean;

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

			## Look, no one wants to deal with XML... rly dudes.
			$request->push_header( 'Accept' => 'application/json,text/plain;q=0.9' );

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

__END__

=head1 NAME

GoogleAPI::UserAgent - A request-prepairing Google API user agent

=head1 DESCRIPTION

A subclass of L<LWP::UserAgent> for the purpose of interfacing with the Google Data REST API. GoogleAPI::UserAgent adds the HTTP headers I<X-GData-Client>, I<X-GData-Key>, and I<Authorization> to each request made.

In addition, it I<currently> defaults the format to JSON, if not specified elsewhere.

=head2 CONSTRUCTOR ARGUMENTS

=over 12

=item

devkey - your Google DATA developer key

=back

authkey - your Google Authorization key (currently obtained from ClientLogin)

=back

=head1 SEE ALSO

L<GoogleAPI::Auth::ClientLogin::YouTube> - a role we include until we need to support more than just YouTube
