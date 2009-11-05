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
