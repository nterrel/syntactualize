#!/usr/local/bin/perl

# Hash symbol comments are like python
print "Hi there!\n"; print "Perl separates statements ",
    "by semicolons.\n";   # They can be used in-line as well

=begin comment
You can use POD comments as well
This whole block is ignored by the interpreter.

There are some important data types in Perl:
    * Strings
    * Numbers (do not use commas or spaces)

And some important variables:
    * Scalars (things)      -- $var
    * Arrays (lists)        -- @var
    * Hashes (dictionaries) -- %var
=end comment
=cut

# Strings can use "" or '' but usage varies
print "This string\nshows up on two lines.\n";  # "" each character is interpreted
print 'This string \n shows up on only one.';   # '' reads each character literally
print "\n"; # Also keep in mind \t is tab character and \\ is a backslash in ""

$_count = 5;
print "This variable is $_count.\n";

@_list = ("One", "Two", "Three");
print "This list contains 3 variables: $_list[0], $_list[1], and $_list[2].\n";

$another_list[0] = "element";  # Create lists implicitly by assigning elements

%_dict = ("One" => 1, "Two" => 2, "Three" => 3);
print "Call hash (dictionary) elements as with other variables.\n";
print "Here's One:$_dict{'One'}\n";

print "To see the keys in a hash, do:\n";
@hash_list = keys %_dict;
print "@hash_list \n"; # Note that these are not particularly ordered!

# Looping
for $i (1, 2, 3, 4, 5) {
    print "i is currently: $i\n";
}

for $i (keys %_dict) {
    print "$i is $_dict{$i} in this hash.\n"
}


