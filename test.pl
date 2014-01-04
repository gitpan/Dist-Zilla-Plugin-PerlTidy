
use Path::Iterator::Rule;

my $rule = Path::Iterator::Rule->new();
$rule->skip_vcs;
$rule->skip(
    sub {
        return if not -d $_;
        if ( $_[1] =~ qr/^\.build$/ ) {
            print('Ignoring .build');
            return 1;
        }
        if ( $_[1] =~ qr/^[A-Za-z].*-[0-9.]+(-TRIAL)?$/ ) {
            print('Ignoring dzil build tree');
            return 1;
        }
        return;
    }
);
$rule->file->nonempty;
$rule->file->not_binary;

# $rule->file->line_match(qr/\s\n/);

my $next = $rule->iter(
    '.' => {
        follow_symlinks => 0,
        sorted          => 0,
    }
);

while ( my $file = $next->() ) {
    print "$file\n";
}
