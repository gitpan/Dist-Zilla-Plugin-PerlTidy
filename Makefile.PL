
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-Perltidy',
  NAME      => 'Dist::Zilla::Plugin::Perltidy',
  AUTHOR    => 'Fayland\ Lam',
  ABSTRACT  => 'PerlTidy in Dist::Zilla',
  VERSION   => '0.02',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.21) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "File::Copy" => '0',
    "File::Next" => '0',
    "Dist::Zilla" => '1.004',
    "Perl::Tidy" => '0',
  },
);
