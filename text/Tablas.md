Table 1. Rules Syntax

| Syntax | Meaning |
|---------------|--------------|
|m/ . . . /     | Match a pattern (immediate execution).       |
|s/ . . . / . . . /  | Perform a substitution (immediate execution).       |
|rx/ . . . / |Define an anonymous rule (deferred execution). |
|/ . . . /|Immediately match or define an anonymous rule, depending on the context |
|rule { . . . } |Define an anonymous rule. |
|rule name { . . . } |Define a named rule. |

Table 2. Metacharacters
Symbol

| Symbol | Meaning |
|--------|--------|
|.        | Match any single character, including a newlin       |
|^       | Match the beginning of a string.       |
|$       |Match the end of a string.        |
|^^       |Match the beginning of a line.        |
|$$        | Match the end of a line.       |
| \|         |Match alternate patterns (OR).        |
|&       |Match multiple patterns (AND).        |
|\       |Escape a metacharacter to get a literal character, or escape a literal character to get a metacharacter.        |
|#       |Mark a comment (to the end of the line).        |
|:=        | Bind the result of a match to a hypothetical variable.       |
|( . . . )       |Group patterns and capture the result.        |
|[ . . . ]       | Group patterns without capturing.       |
|{ . . . }       | Execute a closure (Perl 6 code) within a rule.       |
|< . . . >        | Match an assertion.       |
Table 3. Escape sequences

|Escape|Meaning |
|--------|--------|
|\0[ . . . ]       |Match a character given in octal (brackets optional).        |
|\b       |Match a word boundary.        |
|\B       | Match when not on a word boundary.       |
|\c[ . . . ]       | Match a named character or control character.       |
|\C[ . . . ]       |Match any character except the bracketed named or control character        |
|\d       | Match a digit.       |
|\D       | Match a nondigit.       |
|\e       | Match an escape character.       |
|\E        | Match anything but an escape character.       |
|\f       | Match the form feed character.       |
|\F       |Match anything but a form feed.        |
|\n        |Match a (logical) newline.        |
|\N       |Match anything but a (logical) newline.        |
|\h        | Match horizontal whitespace.
|\H       | Match anything but horizontal whitespace.       |
|\L[ . . . ]       |Everything within the brackets is lowercase        |
|\Q[ . . . ]        |All metacharacters within the brackets match as literal characters.        |
|\r        |Match a return        |
|\R        |Match anything but a return.        |
|\s        |Match any whitespace character.        |
|\S        |Match anything but whitespace.        |
|\t        |Match a tab.        |
|\T        |Match anything but a tab.        |
|\U[ . . . ]        |Everything within the brackets is uppercase.        |
|\v        |Match vertical whitespace.        |
|\V        |Match anything but vertical whitespace        |
|\w        |Match a word character (Unicode alphanumeric plus "_").        |
|\W        | Match anything but a word character.       |
|\x[ . . . ]        |Match a character given in hexadecimal (brackets optional).        |
|\X[ . . . ]        |Match anything but the character given in hexadecimal (brackets optional).        |

Table 4. Quantifiers

|Maximal |Minimal  |Meaning|
|--------|--------|--------|
|*        |*?        |Match 0 or more times.|
|+        |+?        |Match 1 or more times.|
|?        |??        |Match 0 or 1 times.|
|\<n>       |\<n>?        |Match exactly n times.|
|\<n..m>        |\<n..m>?        |Match at least n and no more than m times.|
|\<n . . . >        |\<n . . . >?        |Match at least n times.|

Table 5. Assertions
Syntax

| Syntax | Meaning |
|--------|--------|
|< . . . >        |Generic assertion delimiter.        |
|<! . . . >        |Negate any assertion.        |
|\<name>        |Match a named rule or character class.        |
|<[ . . . ]>        |Match an enumerated character class.        |
|\<- . . . >        |Complement a character class (named or enumerated).        |
|<" . . . ">        |Match a literal string (interpolated at match time).        |
|<' . . . '>        |Match a literal string (not interpolated).        |
|<( . . . )>        |Boolean assertion. Execute a closure and match if it returns a true result.        |
|<$scalar>        |Match an anonymous rule.        |
|<@array>        |Match a series of anonymous rules as alternates.        |
|<%hash>        |Match a key from the hash, then its value (which is an anonymous rule)        |
|<&sub( )>        |Match an anonymous rule returned by a sub        |
|<{code}>        |Match an anonymous rule returned by a closure.        |
|<.>        |Match any logical grapheme, including combining character sequences.        |

Table 6. Modifiers

|Short |Long |Meaning  |
|--------|--------|--------|
|:i       |:ignorecase        |Case-insensitive match.        |
|:I        |        |Case-sensitive match (on by default).        |
|:c        |:cont        |Continue where the previous match on the string left off.        |
|:w        |:words        |Literal whitespace in the pattern matches as \s+ or \s*.        |
|:W        |        |Turn off intelligent whitespace matching (return to default).        |
|        |:Nx/:x(N)        |Match the pattern N times.        |
|        |:Nth/:nth(N)        |Match the Nth occurrence of a pattern.        |
|        |:once        |Match the pattern only once.        |
|:g        |:globally        |Match the pattern as many times as possible, but only possibilities that don't overlap        |
|:e        |:exhaustive        |Match every possible occurrence of a patter        |
|        |:u0        |. is a byte.        |
|        |:u1        |. is a Unicode codepoint.        |
|        |:u2        |. is a Unicode grapheme.        |
|        |:u3        |. is language dependent.        |
|        |:p5        |The pattern uses Perl 5 regex syntax.        |

Table 7. Built-in rules

|Rule |Meaning  |
|--------|--------|
|\<alpha>        |Match a Unicode alphabetic character.        |
|\<digit>        |Match a Unicode digit.        |
|\<sp>        |Match a single-space character (the same as \s).        |
|\<ws>        |Match any whitespace (the same as \s+).        |
|\<null>        |Match the null string.        |
|\<prior>        |Match the same thing as the previous match.        |
|\<before . . . >        |Zero-width lookahead. Assert that you're before a pattern.        |
|\<after . . . >        |Zero-width lookbehind. Assert that you're after a pattern.        |
|\<prop . . . >        |Match any character with the named property.        |
|\<replace( . . . )>        |Replace everything matched so far in the rule or subrule with the given string (under consideration).        |

Table 8. Backtracking controls

|Operator  |Meaning  |
|--------|--------|
|:        |Don't retry the previous atom; fail to the next earlier atom.        |
|::        |Don't backtrack over this point; fail out of the closest enclosing group (( . . . ), [ . . . ], or the rule delimiters).        |
|:::        |Don't backtrack over this point; fail out of the current rule or        |
|\<commit>        |Don't backtrack over this point; fail out of the entire match (even from within a subrule).        |
|\<cut>        |Like \<commit>, but also cuts the string matched. The current matching position at this point becomes the new beginning of the string.        |

Fuente: "Perl 6 and Parrot Essentials, 2nd Edition": http://shop.oreilly.com/product/9780596007379.do














