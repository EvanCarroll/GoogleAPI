package GoogleAPI::Auth::ClientLogin::YouTube;
use strict;
use warnings;

use Moose::Role;
with 'GoogleAPI::Auth::ClientLogin';

sub auth_uri { URI->new('https://www.google.com/youtube/accounts/ClientLogin') };

sub auth_service { 'youtube' };

1;
