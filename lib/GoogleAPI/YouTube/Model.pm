package GoogleAPI::YouTube::Model;
use strict;
use warnings;
use namespace::autoclean;

use Moose;
use GoogleAPI::Types qw/W3CDTF/;

## YouTube URN
has 'id' => ( isa => 'Str', is => 'ro', required => 1 );

has 'updated' => (
	isa => W3CDTF
	, is => 'ro'
	, required => 1
	, coerce => 1
);

has 'title' => ( isa => 'Str', is => 'ro', required => 1 );


## Author
has 'name' => ( isa => 'Str', is => 'ro', required => 1 );
has 'uri' => ( isa => 'Str', is => 'ro', required => 1 );


__PACKAGE__->meta->make_immutable;


__END__

excluded <category> and <batch:operation>
