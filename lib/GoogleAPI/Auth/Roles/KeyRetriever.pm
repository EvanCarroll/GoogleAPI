package GoogleAPI::Auth::Roles::KeyRetriever;
use namespace::autoclean;
use strict;
use warnings;

use Moose::Role;
use URI;
use LWP::UserAgent;

#requires qw( email password source service );

has 'authkey' => (
	isa  => 'Str'
	, is => 'ro'
	, lazy => 1
	, default => sub {
		my $self = shift;
		my $ua = LWP::UserAgent->new;
		my $resp = $ua->post(
			$self->auth_uri
			, [
				Email => $self->auth_email
				, Passwd  => $self->auth_password
				, service => $self->auth_service
				, source  => $self->auth_source
			]
		);

		my $line = $resp->content;
		chomp $line;
		
		$line =~ m/Auth=(\S*)/;

		$1;
	
	}
);

1;
