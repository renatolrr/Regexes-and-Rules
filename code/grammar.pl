#!/usr/bin/perl6
use v6;
grammar URL {
        token TOP {
            <schema> '://' 
            [<ip> | <hostname> ]
            [ ':' <port>]?
            '/' <path>?
        }
        token byte {
            (\d**1..3) <?{ $0 < 256 }>
        }
        token ip {
            <byte> [\. <byte> ] ** 3
        }
        rule schema {
            \w+
        }
        token hostname {
            (\w+) ( \. \w+ )*
        }
        token port {
            \d+
        }
        token path {
            <[ a..z A..Z 0..9 \-_.!~*'():@&=+$,/ ]>+
        }
    }

    my $match = URL.parse('http://perl6.org/documentation/');
    say $match<schema>;       # perl6.org
    
    


