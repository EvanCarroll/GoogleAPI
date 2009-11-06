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

=head1 SYNOPSIS

A role that gets composed into the GoogleAPI::UserAgent

=head1 DESCRIPTION

Basic ClientLogin Authentication

=head1 AUTHOR
