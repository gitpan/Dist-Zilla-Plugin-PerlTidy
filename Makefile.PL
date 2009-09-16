
use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-PerlTidy',
  NAME      => 'Dist::Zilla::Plugin::PerlTidy',
  AUTHOR    => 'Fayland\ Lam',
  ABSTRACT  => 'PerlTidy\ in\ Dist\:\:Zilla\',
  VERSION   => '0.05',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "File::Copy" => '0',
    "File::Next" => '0',
    "Dist::Zilla" => '1.092450',
    "Perl::Tidy" => '0',
  },
);
