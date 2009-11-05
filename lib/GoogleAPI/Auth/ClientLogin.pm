package GoogleAPI::Auth::ClientLogin;
use namespace::autoclean;
use strict;
use warnings;

use Moose;
use URI;
use LWP::UserAgent;

with 'GoogleAPI::Auth::Roles::KeyRetriever';

has [qw/email password/] => (
	isa  => 'Str'
	, is => 'ro'
	, required => 1
);

has 'uri' => (
	isa  => 'URI'
	, is => 'ro'
	, init_arg => undef
	, lazy_build => 1
);

has 'source' => (
	isa => 'Str'
	, is => 'ro'
	, default => __PACKAGE__ . ' application'
);

has 'service' => (
	isa  => 'Str'
	, is => 'ro'
	, lazy_build => 1
	, init_arg => undef
	, required => 1
);


__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME 

GoogleAPI::Auth::ClientLogin

=head1 SYNOPSIS

my $auth = GoogleAPI::Auth::ClientLogin->new({
	email => 'foo@bar.com'
	, password => 'foobar'
	, source => 'My application'
});

$auth->key;

=head1 DESCRIPTION

Basic ClientLogin Authentication

=head1 AUTHOR
