
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::PerlTidy',
                       'DISTNAME' => 'Dist-Zilla-Plugin-PerlTidy',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Fayland Lam <fayland@gmail.com>, Mark Gardner <mjgardner@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'PerlTidy in Dist::Zilla',
                       'EXE_FILES' => [],
                       'VERSION' => '0.08_01',
                       'PREREQ_PM' => {
                                        'File::Copy' => '0',
                                        'File::Next' => '0',
                                        'Dist::Zilla' => '2.100880',
                                        'Perl::Tidy' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{BUILD_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.56) };

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



