package GoogleAPI;

use warnings;
use strict;

our $VERSION = '0.01';

=head1 NAME

GoogleAPI - An API into some google services

=head1 VERSION

Version 0.01

=head1 SYNOPSIS

Has a basic (currently read-only) API into Google services (currently YouTube). I'm not sure if I like this API at all yet. This is very pre-release.

	my $ua = GoogleAPI::UserAgent->new({
		devkey     => $developerKey
		, auth_email    => $username || $googleAccountEmail
		, auth_password => $password
	});

	use GoogleAPI::YouTube::Query::Feeds::User;
	my $uri = GoogleAPI::YouTube::Query::Feeds::User->new({ username => 'default' })->uri;

	use GoogleAPI::YouTube::Query::Custom;
	my $uri = GoogleAPI::YouTube::Query::Custom->new({ author => 'EvanCarroll' })->uri;

	my $f = GoogleAPI::YouTube::Model::Feed->new( $ua->get(YYY $uri) );

=head1 AUTHOR

Evan Carroll, C<< <me at evancarroll.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-googleapi at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=GoogleAPI>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc GoogleAPI

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=GoogleAPI>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/GoogleAPI>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/GoogleAPI>

=item * Search CPAN

L<http://search.cpan.org/dist/GoogleAPI/>

=back

=head1 ACKNOWLEDGEMENTS

=head1 COPYRIGHT & LICENSE

Copyright 2009 Evan Carroll.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.
