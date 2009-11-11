package GoogleAPI::Types;
use MooseX::Types -declare => ['W3CDTF'];
use MooseX::Types::DateTime::ButMaintained qw/DateTime/;
use MooseX::Types::Moose qw/Str/;

use DateTime::Format::W3CDTF;

subtype W3CDTF
	, as DateTime
	, where { ref $_ eq 'DateTime' }
	, message { "invalid datetime supplied" }
;

my $w3c = DateTime::Format::W3CDTF->new;
coerce W3CDTF, from Str, via { s/\.\d+Z$//; $w3c->parse_datetime( $_ ) };

1;

__END__

=head1 NAME

GoogleAPI::Types

=head1 DESCRIPTION

=head2 Types

=over 4

=item

W3CDTF

A datetime that coercing from a I<W3C Date Time Format> string by using L<DateTime::Format::W3CDTF>.

=back

=cut
