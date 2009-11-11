package GoogleAPI::YouTube::Model::Entry;
use strict;
use warnings;
use namespace::autoclean;

use Moose;
use GoogleAPI::Types qw/W3CDTF/;

extends 'GoogleAPI::YouTube::Model';

has 'published' => ( isa => W3CDTF , is => 'ro', coerce => 1 );

has 'content' => ( isa => 'Maybe[Str]', is => 'ro' );

__PACKAGE__->meta->make_immutable;

__END__

Retrieving a video entry or entries in a video or playlist feed: id, published?, updated, category*, title, content?, link*, author?, summary? (this tag only appears in a playlist entry), media:group?, yt:position? (this tag only appears in a playlist entry), yt:statistics?, gd:comments?, gd:rating?, yt:location?, yt:recorded?, georss:where?, app:control?
