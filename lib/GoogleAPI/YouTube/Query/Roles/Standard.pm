package GoogleAPI::YouTube::Query::Roles::Standard;
use strict;
use warnings;
use namespace::autoclean;

use Moose::Role;
use Moose::Util::TypeConstraints;

enum 'FEED' => qw( atom rss json json-in-script );

has 'format_feed' => (
	isa  => 'Maybe[FEED]'
	, is => 'ro'
	, required => 1
	, default  => 'json'
	, documentation => 'alt'
);

has 'author' => ( isa => 'Str', is => 'ro' );

has 'max_results' => ( isa => 'Str', is => 'ro' );

has 'pretty_print' => ( isa => 'Bool', is => 'ro' );

has 'start_index' => ( isa => 'Str', is => 'ro' );

has 'strict' => ( isa => 'Bool', is => 'ro', default => 1 );

has 'version' => (
	isa  => 'Int'
	, is => 'ro'
	, default => 2
	, documentation => 'v'
);

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

no Moose;
no Moose::Util::TypeConstraints;

1;

__END__

=head1 NAME

GoogleAPI::YouTube::Query::Roles::Standard

=head1 DESCRIPTION

Impliments standard YouTube query paramaters as described

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_api_query_parameters.html#Standard_parameters>

=head2 ATTRIBUTES

=over 4

=item

format_feed - documented as I<alt>, defaults to JSON.

=item

author

=item

max_results

=item

pretty_print

=item

start_index

=item

strict - defaults to I<true>.

=item

version - documented as I<v>, defaults to 2.

=back
