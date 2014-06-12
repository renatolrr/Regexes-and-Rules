#!/usr/bin/perl6

use v6;

if 'properly' ~~ m/perl/ {
	say "Encontrada";
}

if 'abcdef' ~~ / de / {
    say ~$/;            # de
    say $/.prematch;    # abc
    say $/.postmatch;   # f
    say $/.from;        # 3
    say $/.to;          # 5
};

my $spacey = 'with   many    spaces';
say $spacey.subst(rx/ \s+/, ' ' , :g);  
# output: with many superfluous spaces
