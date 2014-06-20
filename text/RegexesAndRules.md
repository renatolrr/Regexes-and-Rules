## Historia

"    En Perl 6, decidimos que sería mejor arreglar el lenguaje que arreglar al usuario
    Larry Wall

El proceso de diseño de Perl 6 fue anunciado por primera vez el 19 de julio de 2000, en el cuarto día de la Conferencia Perl anual, por Larry Wall, en su charla State of the Onion 2000. En ese momento, los objetivos primarios eran eliminar las "verrugas históricas" del lenguaje; "las cosas sencillas deberían continuar siendo sencillas, las cosas difíciles deberían ser más fáciles, y las cosas imposibles deberían ser difíciles"; una limpieza general del diseño interno y de los API. El proceso comenzó con una serie de peticiones de comentarios o "RFC". Este proceso estuvo abierto a todos los contribuyentes, y no dejó ningún aspecto del lenguaje cerrado al cambio.

Una vez que el proceso de las RFC se completó, Wall revisó y clasificó cada petición. Empezó entonces el proceso de escribir los "Apocalipsis", un término que se refiere a la "revelación".10 Mientras que el objetivo original era escribir un Apocalipsis por cada capítulo de Programming Perl, a medida que se iba escribiendo cada uno, se hizo obvio que los previos iban siendo invalidados por los cambios posteriores. Por esta razón, se publicaron un conjunto de Sinopsis, cada una relacionada con los contenidos de un Apocalipsis, pero reflejando los cambios posteriores. Hoy, la especificación de Perl 6 continua casi de forma completa dentro de las Sinopsis.

Existen también una serie de Exégesis escritas por Damian Conway que explican los contenidos de cada Apocalipsis en términos de uso práctico. Cada Exégesis contiene ejemplos de código junto con la discusión del uso y las implicaciones de los ejemplos."

Fuente: http://es.wikipedia.org/wiki/Perl_6

##Sinopsis S05

Título:  
"Synopsis 5: Regexes and Rules"

Autores:  
    Damian Conway <damian@conway.org>  
    Allison Randal <al@shadowed.net>  
    Patrick Michaud <pmichaud@pobox.com>  
    Larry Wall <larry@wall.org>  
    Moritz Lenz <moritz@faui2k3.org>  
    Tobias Leich <email@froggs.de>  

Versión:  
    Created: 24 Jun 2002
    Last Modified: 27 Feb 2014
    Version: 175

## Un poco más.

Perl 5 y perl6 son dos lenguajes diferentes, con una sintasis y semantica diferente, pero es que Perl:

Filosofía: "hay más de un camino para hacerlo", " las cosas faciles..."  
Custom: Test  
Un edificio: Cpan  
Una comunidad:   

Distintas implementaciones de perl


## Una parada.

### Espacios.

Funciones

### ~ Como operador.
El operador ~ se utiliza para concatenar cadenas, ya no se usa . que se deja para las clases. Y tambien se utiliza ~= para concatenar a la derecha de la cadena:

```
$line = "The quick brown " ~ $fox ~ jumps_over( ) ~ " the lazy " ~ $dog; 
$line ~= "Belgium"; # appends to the string
```
###  ~ Como operador binario.

El operador binario ~~, hace busquedas en los dos terminos, y nos devuelve "true" si se ha encontrado.

##Regexes, en vez de regex.

### Diferencia.



### Explicación, buscando patrones.  
Síntasis más clara.  
Necesidad de capturar y encontrar objetos.  
Nombrando "regexes" y "grammars"

Tablas.  

Modificadores.  


Sustitución:

```
my $spacey = 'with   many spaces';` 
say $spacey.subst(rx/ \s+/, '',:g);  
\# output: with many superfluous spaces  
```


##Grammars.
### Introducción.

This behavior is quite different from Perl 5 semantics: 
      # Perl 5...
      #
      # $1---------------------  $4---------  $5------------------
      # |   $2---------------  | |          | | $6----  $7------  |
      # |   |         $3--   | | |          | | |     | |       | |
      # |   |         |   |  | | |          | | |     | |       | |
     m/ ( A (guy|gal|g(\S+)  ) ) (sees|calls) ( (the|a) (gal|guy) ) /x;
In Perl 6, nested parens produce properly nested captures: 
      # Perl 6...
      #
      # $0---------------------  $1---------  $2------------------
      # |   $0[0]------------  | |          | | $2[0]-  $2[1]---  |
      # |   |       $0[0][0] | | |          | | |     | |       | |
      # |   |         |   |  | | |          | | |     | |       | |
     m/ ( A (guy|gal|g(\S+)  ) ) (sees|calls) ( (the|a) (gal|guy) ) /;

### Ejemplo.
```
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
        token schema {
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
    say $match<path>;       # perl6.org
```

Rules  
Token  

### Modulos y utilización de grammars.



## Perl6::Rules

Deficiencias.



##Enlaces.

"Apocalypse 5: Pattern Matchin": http://www.perl6.org/archive/doc/design/apo/A05.html

"Exegesis 5: Pattern Matching": http://www.perl6.org/archive/doc/design/exe/E05.html

"Synopsis 5: Regexes and Rules":  http://perlcabal.org/syn/S05.html

"Introduction to Perl 6 Regex":  https://github.com/perlpilot/perl6-docs/blob/master/intro/p6-regex-intro.pod

"Regexes -- Pattern matching against strings": http://doc.perl6.org/language/regexes

"Perl 5 to Perl 6": http://perlgeek.de/en/article/5-to-6

"Perl 6 and Parrot Essentials, 2nd Edition": http://shop.oreilly.com/product/9780596007379.do
 
 
