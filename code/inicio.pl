
# cadena repetida
    my $s = 'the quick brown fox jumped over the the lazy dog';

    if $s ~~ m/ « (\w+) \W+ $0 » / {
        say "Found '$0' twice in a row";
    }

# literal
    if 'properly' ~~ m/ perl / {
        say "'properly' contains 'perl'";
    }

# uso de escape
    my $str = "I'm *very* happy";

    # quoting
    if $str ~~ m/ '*very*' /   { say '\o/' }

    # escaping
    if $str ~~ m/ \* very \* / { say '\o/' }

# uso de . (metasyntactic)
    my @words = <spell superlative openly stuff>;

    for @words -> $w {
        if $w ~~ m/ pe.l / {
            say "$w contains $/";
        } else {
            say "no match for $w";
        }
    }

# nuestra clase de caracteres
    if $str ~~ / <[aeiou]> / {
        say "'$str' contains a vowel";
    }

    # negation with a -
    if $str ~~ / <-[aeiou]> / {
        say "'$str' contains something that's not a vowel";
    }

# rango
    # match a, b, c, d, ..., y, z
    if $str ~~ / <[a..z]> / {
        say "'$str' contains a lower case Latin letter";
    }

# operadores suma y resta
    if $str ~~ / <[a..z]+[0..9]> / {
        say "'$str' contains a letter or number";
    }

    if $str ~~ / <[a..z]-[aeiou]> / {
        say "'$str' contains a consonant";
    }

# usando escape
    my $str = 'A character [b] inside brackets';
    if $str ~~ /'[' <-[ \[ \] ]> ']'/ ) {
        say "Found a non-bracket character inside square brackets";
    }

# cuantificador **
    # match a date of the form 2009-10-24:
    m/ \d**4 '-' \d\d '-' \d\d /

    # match at least three 'a's in a row:
    m/ a ** 3..* /

# ejemplo html
    my $html = '<p>A paragraph</p> <p>And a second one</p>';

    if $html ~~ m/ '<p>' .* '</p>' / {
        say 'Matches the complete string!';
    }

    if $html ~~ m/ '<p>' .*? '</p>' / {
        say 'Matches only <p>A paragraph</p>!';
    }

# aplicando modificadores
    my $ingredients = 'milk, flour, eggs and sugar';
    # prints "milk, flour, eggs"
    $ingredients ~~ m/ [\w+]+ % [\,\s*] / && say $/;

# fechas
    $string ~~ m/ \d**4 '-' \d\d '-' \d\d | 'today' | 'yesterday' /

# captura
    my $str = 'Germany was reunited on 1990-10-03, peacefully';

    if $str ~~ m/ (\d**4) \- (\d\d) \- (\d\d) / {
        say 'Year:  ', $/[0];
        say 'Month: ', $/[1];
        say 'Day:   ', $/[2];
        # usage as an array:
        say $/.join('-');       # prints 1990-10-03
    }

# varias capturas
    my $ingredients = 'eggs, milk, sugar and flour';

    if $ingredients ~~ m/(\w+)% % [\,\s*] \s* 'and' \s* (\w+)/ {
        say 'list: ', $/[0].join(' | ');
        say 'end:  ', $/[1];
    }

# captura repetida
    my $s = 'the quick brown fox jumped over the the lazy dog';

    if $s ~~ m/ « (\w+) \W+ $0 » / {
        say "Found '$0' twice in a row";
    }

# nombrando regexes
    my regex word { \w+ [ \ \w+]? } #  \w+ [ \' \w+]?  falta el ' 
    my regex dup  { « <word=&word> \W+ $<word> » }

    if $s ~~ m/ <dup=&dup> / {
        say "Found '{$<dup><word>}' twice in a row";
    }

# lista de palabras
    m/(\w+)+ % [\,\s*] \s* 'and' \s* (\w+)/

# usando el modificador :sigspace
    my $ingredients = 'eggs, milk, sugar and flour';

    if $ingredients ~~ m/:s ( \w+ )%  % \,'and' (\w+)/ {
        say 'list: ', $/[0].join(' | ');
        say 'end:  ', $/[1];
    }

#utilizando :ratchet
    # XXX: does actually match, because m/<&dup>/
    # searches for a starting position where the
    # whole regex matches. Find an example that
    # doesn't match

    my regex word { :ratchet \w+ [ \' \w+]? }
    my regex dup  { <word=&word> \W+ $<word> }

    # no match, doesn't match the 'and'
    # in 'strand' without backtracking
    'strand and beach' ~~ m/<&dup>/

# usando token
    my <token> word { \w+ [ \ \w+]? }#  \w+ [ \' \w+]?  falta el ' 
    my regex dup   { <word> \W+ $<word> }

# usando rule
    # TODO: check if it works
    my rule wordlist { <word>+ % \, 'and' <word> }

######################################################

# sustitucion
    my $spacey = 'with    many  superfluous   spaces';

    say $spacey.subst(rx/ \s+ /, ' ', :g);
    # output : with many superfluous spaces

# añadiendo espacios
    my $str = 'milk,flour,sugar and eggs';
    say $str.subst(/',' <?before \w>/, ', ',  :g);
    # output: milk, flour, sugar and eggs

# y de otra manera
    say $str.subst(/',' <?alpha>/, ', ',  :g);

# y otra variante
    say $str.subst(/',' <!space>/, ', ',  :g);

# buscando objetos
    sub line-and-column(Match $m) {
        my $line   = ($m.orig.substr(0, $m.from).split("\n")).elems;
        # RAKUDO workaround for RT #70003, $m.orig.rindex(...) directly fails
        my $column = $m.from - ('' ~ $m.orig).rindex("\n", $m.from);
        $line, $column;
    }

    my $s = "the quick\nbrown fox jumped\nover the the lazy dog";

    my token word { \w+ [ \' \w+]? }
    my regex dup { <word> \W+ $<word> }

    if $s ~~ m/ <dup> / {
        my ($line, $column) = line-and-column($/);
        say "Found '{$<dup><word>}' twice in a row";
        say "at line $line, column $column";
    }

    # output:
    # Found 'the' twice in a row
    # at line 3, column 6

# otro ejemplo

    if 'abc' ~~ m/(.) <alpha> (.) / {
        for $/.caps {
            say .key, ' => ', .value;

        }
    }

    # Output:
    # 0 => a
    # alpha => b
    # 1 => c


