package GoogleAPI::YouTube::Query;
use strict;
use warnings;
use namespace::autoclean;

use Moose;

## Parameters for all API requests
has [qw/client key/] => (
	isa  => 'Str'
	, is => 'ro'
);

## Additional parameters for all video feeds:
has 'restriction' => ( isa => 'Str', is => 'ro' );

has 'uri' => (
	isa  => 'URI'
	, is => 'ro'
	, init_arg => undef
	, lazy => 1
	, builder => '_build_uri'
	, initializer => sub {
		my ( $self, $value, $writerSubRef, $attributeMeta ) = @_;

		my %query;
		for my $attr ( $self->meta->get_all_attributes ) {
		
			my $v;
			## IF there is a predicate and it is set
			## or it is there is no predicate, but there is a defined value
			if (
				$attr->has_predicate && $attr->predicate
				or !$attr->has_predicate && defined $attr->get_raw_value($self)
			) {
				$v = $attr->get_raw_value($self);
			}
			## Else undefined, no predicate, assume not set and skip
			else {
				next;
			}
			
			my $k = $attr->has_documentation ? $attr->documentation : $attr->name;

			$query{ $k } = $v;
		}

		my $uri = URI->new($value);

		$uri->query_form( \%query );

		$writerSubRef->($uri);
		
	}
);

__PACKAGE__->meta->make_immutable;

__END__

=head1 NAME

GoogleAPI::YouTube::Query - Base class for queries

=head1 DESCRIPTION

A base class for all youtube queries. Impliments C<client>, and C<key>, attributes, and a basic initilizer for a C<uri> attribute which is loaded in subclasses through a C<_build_uri> method.

=head1 REFERENCS

L<http://code.google.com/apis/youtube/2.0/developers_guide_protocol_api_query_parameters.html>
