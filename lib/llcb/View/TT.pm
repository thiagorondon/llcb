package llcb::View::TT;

use Moose;
BEGIN { extends 'Catalyst::View::TT' }

__PACKAGE__->config(
    INCLUDE_PATH => [
        llcb->path_to( 'root', 'src' ),
        llcb->path_to( 'root', 'lib' )
    ],
    TEMPLATE_EXTENSION => '.tt',
    ENCODING           => 'utf-8',
    WRAPPER            => 'site/wrapper.tt',
    TIMER              => 0,
);

=head1 NAME

CMD::View::TT - TT View for CMD.

=head1 DESCRIPTION

TT View for CMD.

=head1 SEE ALSO

L<CMD>

=head1 AUTHOR

Thiago Rondon,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
