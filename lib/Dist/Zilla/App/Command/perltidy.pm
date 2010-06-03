package Dist::Zilla::App::Command::perltidy;

BEGIN {
    $Dist::Zilla::App::Command::perltidy::VERSION = '0.09';
}

use strict;
use warnings;

# ABSTRACT: perltidy your dist
use Dist::Zilla::App -command;

sub abstract {'perltidy your dist'}

sub execute {
    my ( $self, $opt, $arg ) = @_;

    # use perltidyrc from command line or from config
    my $perltidyrc;
    if ( scalar @$arg and -r $arg->[0] ) {
        $perltidyrc = $arg->[0];
    } else {
        my $plugin = $self->zilla->plugin_named('PerlTidy');
        if ( defined $plugin->perltidyrc ) {
            $perltidyrc = $plugin->perltidyrc;
        }
    }

    # Verify that file specified is readable
    unless ( $perltidyrc and -r $perltidyrc ) {
        $self->zilla->log_fatal(
            [ "specified perltidyrc is not readable: %s", $perltidyrc ] );
    }

    # make Perl::Tidy happy
    local @ARGV = ();

    require Perl::Tidy;
    require File::Copy;
    require File::Next;

    my $files = File::Next::files('.');
    while ( defined( my $file = $files->() ) ) {
        next unless ( $file =~ /\.(t|p[ml])$/ );    # perl file
        my $tidyfile = $file . '.tdy';
        Perl::Tidy::perltidy(
            source      => $file,
            destination => $tidyfile,
            ( $perltidyrc ? ( perltidyrc => $perltidyrc ) : () ),
        );
        File::Copy::move( $tidyfile, $file );
    }

    return 1;
}

1;

__END__

=pod

=head1 NAME

Dist::Zilla::App::Command::perltidy - perltidy your dist

=head1 VERSION

version 0.09

=head2 SYNOPSIS

    $ dzil perltidy
    # OR
    $ dzil perltidy .myperltidyrc

=head2 CONFIGURATION

In your global dzil setting (which is '~/.dzil' or '~/.dzil/config.ini'),
you can config the perltidyrc like:

    [PerlTidy]
    perltidyrc = /home/fayland/somewhere/.perltidyrc

=head2 DEFAULTS

If you do not specify a specific perltidyrc in dist.ini it will try to use
the same defaults as Perl::Tidy.

=head2 SEE ALSO

L<Perl::Tidy>

=head1 AUTHORS

  Fayland Lam <fayland@gmail.com>
  Mark Gardner <mjgardner@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Fayland Lam.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
