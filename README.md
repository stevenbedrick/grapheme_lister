# Grapheme Lister

When debugging complex Unicode strings (with grapheme clusters of combining characters, etc.), I often need to quickly "dissect" clusters to see what's going on. `grapheme_lister` is a _very_ quick and dirty tool to help.

Consider the following input string:

> ٩◔̯◔۶

This is a sequence of five code points, but four grapheme clusters (the second grapheme is made up of a base and combining character). `grapheme_lister` makes this apparent:

    % ruby grapheme_lister.rb -f graphemes.txt
    0	٩	669	ARABIC-INDIC DIGIT NINE
    1	◔̯	CLUSTER
    	◔	25d4	CIRCLE WITH UPPER RIGHT QUADRANT BLACK
       	̯	32f	COMBINING INVERTED BREVE BELOW
    2	◔	25d4	CIRCLE WITH UPPER RIGHT QUADRANT BLACK
    3	۶	6f6	EXTENDED ARABIC-INDIC DIGIT SIX
    
(`graphemes.txt`) is a simple UTF-8-encoded text file containing the example string.
    
Use `-e` if you want an extra line break after a cluster that contains more than one code point.

Dependencies:

- The excellent [unicode_utils](https://github.com/lang/unicode_utils) gem

This _should_ work in both Ruby 1.9 and 2.x. It is _intended_ for use on relatively small chunks of text, of the sort that one encounters when debugging irritating Unicode situations. While it will certainly run on larger files, it will not be particularly useful. The code contains some very minimal sanity checks, but I make no promises about its robustness, security, etc. 

Also, please do not treat this as an example of how to write good Ruby code...

Comments, questions, etc. can be sent to [Steven Bedrick](mailto:bedricks@ohsu.edu).

