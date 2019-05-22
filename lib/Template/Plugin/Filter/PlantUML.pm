package Template::Plugin::Filter::PlantUML;

use 5.006;
use strict;
use warnings;

require Template::Plugin::Filter;
use base qw(Template::Plugin::Filter);
use vars qw($VERSION $DYNAMIC $FILTER_NAME);

use Lingua::PlantUML::Encode qw(encode_p);
use WWW::PlantUML;

=head1 NAME

Template::Plugin::Filter::PlantUML - A template toolkit plugin filter for encoding and processing PlantUML Diagrams using any PlantUML Server.

=head1 VERSION

Version 0.01

=cut

our $VERSION     = 0.01;
our $DYNAMIC     = 1;
our $FILTER_NAME = 'plantuml';


=head1 SYNOPSIS

To use this plugin, you have to make sure that the Template Toolkit knows about its namespace.

    my $tt2 = Template->new({
        PLUGIN_BASE => 'Template::Plugin::Filter::PlantUML',
    });

Then you b<USE> your plugin like below.

    [% USE Filter.PlantUML 'http://www.plantuml.com/plantuml' 'svg' -%]
    
    [% url = FILTER plantuml %]
      Bob -> Alice : hello
    [% END %]
    
    <img src="[% url %]" alt="[% url %]" />

=head1 DESCRIPTION

This is a trivial Template::Toolkit plugin filter to allow any template writer to embed PlantUML Diagram Syntax in Templates and have them encoded and processed via any PlantUML Server in any supported formats.

It uses WWW:PlantUML remote client under the hood.

=head1 SUBROUTINES/METHODS

=head2 init

defines init() method.

=cut

sub init {
    my $self = shift;
    $self->install_filter($FILTER_NAME);
    return $self;
}


=head2 filter

defines filter() method.

=cut

sub filter {
    my($self, $code, $args, $conf) = @_;

    $args = $self->merge_args($args); 
    $conf = $self->merge_config($conf);

    my $puml = WWW::PlantUML->new(@$args[0]);
    return $puml->fetch_url($code, @$args[1] || 'png');
}

=head1 AUTHOR

Rangana Sudesha Withanage, C<< <rwi at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-template-plugin-filter-plantuml at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Template-Plugin-Filter-PlantUML>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Template::Plugin::Filter::PlantUML


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Template-Plugin-Filter-PlantUML>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Template-Plugin-Filter-PlantUML>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Template-Plugin-Filter-PlantUML>

=item * Search CPAN

L<https://metacpan.org/release/Template-Plugin-Filter-PlantUML>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is copyright (c) 2019 by Rangana Sudesha Withanage.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

1; # End of Template::Plugin::Filter::PlantUML
