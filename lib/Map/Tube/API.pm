package Map::Tube::API;

$Map::Tube::API::VERSION   = '0.01';
$Map::Tube::API::AUTHORITY = 'cpan:MANWAR';

=head1 NAME

Map::Tube::API - Interface to Map::Tube REST API.

=head1 VERSION

Version 0.01

=cut

use 5.006;
use JSON;
use Data::Dumper;

use Map::Tube::API::UserAgent;

use Moo;
use namespace::clean;
extends 'Map::Tube::API::UserAgent';

our $DEFAULT_HOST    = 'manwar.mooo.info';
our $DEFAULT_VERSION = 'v1';

has 'host'    => (is => 'rw', default => sub { $DEFAULT_HOST    });
has 'version' => (is => 'rw', default => sub { $DEFAULT_VERSION });

=head1 DESCRIPTION

=head1 CONSTRUCTOR

=head1 METHODS

=head2 shortest_route($map, $start, $stop)

=cut

sub shortest_route {
    my ($self, $map, $start, $end) = @_;

    my $url      = sprintf("%s/shortest-route", $self->_base_url);
    my $response = $self->post($url, { map => $map, start => $start, end => $end });

    return from_json($response->decoded_content);
}

=head2 line_stations($map, $line)

=cut

sub line_stations {
    my ($self, $map, $line) = @_;

    my $url      = sprintf("%s/stations/%s/%s", $self->_base_url, $map, $line);
    my $response = $self->get($url);

    return from_json($response->decoded_content);
}

=head2 map_stations($map)

=cut

sub map_stations {
    my ($self, $map) = @_;

    my $url      = sprintf("%s/stations/%s", $self->_base_url, $map);
    my $response = $self->get($url);

    return from_json($response->decoded_content);
}

=head2 available_maps()

=cut

sub available_maps {
    my ($self) = @_;

    my $url      = sprintf("%s/maps", $self->_base_url);
    my $response = $self->get($url);

    return from_json($response->decoded_content);
}

#
#
# PRIVATE METHODS

sub _base_url {
    my ($self) = @_;

    return sprintf("http://%s/map-tube/%s", $self->host, $self->version);
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 REPOSITORY

L<https://github.com/manwar/Map-Tube-API>

=head1 BUGS

Please  report  any bugs  or feature requests to C<bug-map-tube-api at rt.cpan.org>,
or through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Map-Tube-API>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Map::Tube::API

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Map-Tube-API>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Map-Tube-API>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Map-Tube-API>

=item * Search CPAN

L<http://search.cpan.org/dist/Map-Tube-API/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright (C) 2017 Mohammad S Anwar.

This  program  is  free software; you can redistribute it and/or modify it under
the  terms  of the the Artistic License (2.0). You may obtain a copy of the full
license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any  use,  modification, and distribution of the Standard or Modified Versions is
governed by this Artistic License.By using, modifying or distributing the Package,
you accept this license. Do not use, modify, or distribute the Package, if you do
not accept this license.

If your Modified Version has been derived from a Modified Version made by someone
other than you,you are nevertheless required to ensure that your Modified Version
 complies with the requirements of this license.

This  license  does  not grant you the right to use any trademark,  service mark,
tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge patent license
to make,  have made, use,  offer to sell, sell, import and otherwise transfer the
Package with respect to any patent claims licensable by the Copyright Holder that
are  necessarily  infringed  by  the  Package. If you institute patent litigation
(including  a  cross-claim  or  counterclaim) against any party alleging that the
Package constitutes direct or contributory patent infringement,then this Artistic
License to you shall terminate on the date that such litigation is filed.

Disclaimer  of  Warranty:  THE  PACKAGE  IS  PROVIDED BY THE COPYRIGHT HOLDER AND
CONTRIBUTORS  "AS IS'  AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES. THE IMPLIED
WARRANTIES    OF   MERCHANTABILITY,   FITNESS   FOR   A   PARTICULAR  PURPOSE, OR
NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY YOUR LOCAL LAW. UNLESS
REQUIRED BY LAW, NO COPYRIGHT HOLDER OR CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL,  OR CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE
OF THE PACKAGE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

=cut

1; # End of Map::Tube::API
