package GoogleAPI::Auth::ClientLogin::YouTube;
use namespace::autoclean;
use strict;
use warnings;

use Moose;
extends 'GoogleAPI::Auth::ClientLogin';

sub _build_uri { URI->new('https://www.google.com/youtube/accounts/ClientLogin') };

sub _build_service { 'youtube' };

1;
