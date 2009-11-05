package GoogleAPI::Auth::Roles::KeyRetriever;
use namespace::autoclean;
use strict;
use warnings;

use Moose::Role;
use URI;
use LWP::UserAgent;

#requires qw( email password source service );

has 'ua' => (
	isa  => 'LWP::UserAgent'
	, is => 'ro'
	, lazy => 1
	, default => sub { LWP::UserAgent->new }
);

has 'key' => (
	isa  => 'Str'
	, is => 'ro'
	, lazy => 1
	, default => sub {
		my $self = shift;
		my $resp = $self->ua->post(
			$self->uri
			, [
				Email => $self->email
				, Passwd  => $self->password
				, service => $self->service
				, source  => $self->source
			]
		);

		my $line = $resp->content;
		chomp $line;
		
		$line =~ m/Auth=(\S*)/;

		$1;
	
	}
);

1;
