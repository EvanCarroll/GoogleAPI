package GoogleAPI::Auth::ClientLogin;
use strict;
use warnings;

use Moose::Role;
use URI;
use LWP::UserAgent;

with 'GoogleAPI::Auth::Roles::KeyRetriever';

has [qw/auth_email auth_password/] => (
	isa  => 'Str'
	, is => 'ro'
	, required => 1
);

has 'auth_source' => (
	isa  => 'Str'
	, is => 'ro'
	, default => __PACKAGE__ . ' application'
);

1;

__END__

=head1 NAME 

GoogleAPI::Auth::ClientLogin

=head1 DESCRIPTION

A role that currently composed into the GoogleAPI::UserAgent, requiring email, and password for authentication. It does this by adding requried attributes.

=head2 ATTRIBUTES

=over4

=item auth_email (Not always an email address)

=item auth_password

=item auth_source  (NOT REQUIRED, defaults to 'GoogleAPI::Auth::ClientLogin application')

=back
