#! /usr/local/bin perl
# Chen Ling
# CISC 882 Natural Language Processing
# 09/05/2018

use strict;
use warnings;

# Define all the variables
my $user = "[User]: ";
my $eliza = "[Eliza]: ";
my $source = "Source: ";
my $index_name = "";
my $exitWords = "bye|goodbye|quit|exit|see you";

# Define key words for indicating if the item would rise or fall
my $future_tense = "future|would|will"; 
my $down = "closed|decrease|drop(ped)?|plunge(d)?|decline|
f[e|a]ll|lower|[stop|stopped] trading|w[as|ere] down|closed down|
surrendered|loss|down about|down|final|were off|bottom-down";
my $up = "rise(d)?|jumped|up";

my @variable_names = (
			"dow|dow jones|industrial average|dow jones industrials", 
			"s&p|Standard & Poor|s&p-500|the s&p", 
			"ibm|international business machine",
			"ual|united airlines",
			"usair|usair group|us airlines",
			"delta air lines|delta|delta airline",
			"walt disney|disney");

# Remove blank space before and after a string
sub  trim { my $s = shift; $s =~ s/^\s+|\s+$//g; return $s };

# Handle the input file and store it into an array
my @document;
open(my $fh, "<:encoding(UTF-8)", $ARGV[0])
    or die "Failed to open file: $!\n";
while(my $row = <$fh>) { 
    push @document, lc($row);
} 
close $fh;

# Welcome
print $eliza; print "Hi, how can I assist you today?\n";
print "$user";

my $input = "";

# Ask user to prompt input
while(<stdin>) {
	chomp $_;
	if ($_ =~ m/[.!?]$/) { chop $_; }
    $input = lc($_); # set the input to all lowercase strings

    # Set the result array
    my @results;

    # If user's input contains exit words, we terminate the loop
    if ($input =~ /($exitWords)/i) {
        print $eliza; print "Goodbye\n";
        exit 1;
    } # determine if the question is about rise or fall
    elsif ($input =~ m/^did\s(.+)\s(rise or fall|fall or rise|go up or down|go down or up)$/){
    	$index_name = trim($1);
    	# Loop the array to find the alternative variable names
    	foreach my $i (0 .. $#variable_names) {
    		if ($index_name =~ m/\b($variable_names[$i])\b/){
    			$index_name = $variable_names[$i];
    		}
    	}
    	print $eliza;
    	# Loop the article to find the match string
    	foreach my $i (0 .. $#document) {
  			if ($document[$i] =~ m/(.*)\b($index_name)\b(.*)\b($down)\b/&& $document[$i] =~ /^(?:(?!($future_tense)).)*$/){
  				print "it fell\n";
    			print $source; print "$document[$i]"; print "(line: $i)\n";
    			push(@results, "it fell");
    		}
    		elsif ($document[$i] =~ m/(.*)\b($index_name)\b(.*)\b($up)\b/&& $document[$i] =~ /^(?:(?!($future_tense)).)*$/){
  				print "it rose\n";
    			print $source; print "$document[$i]"; print "(line: $i)\n";
    			push(@results, "it rose");
  			}
  			else{
  				push(@results, "There are no information available");
  			}
  		}
  		# Print the correct output if there's no information available
  		if (@results == grep { $_ eq "There are no information available" } @results) {
  			print "$results[-1]\n";
		}
  	}
  	# determine if the article is about how much ... close/open at.
  	elsif ($input =~ m/^(what|how much)\sdid\s(.+)\s((open|close) at)$/){
  		$index_name = trim($2);
  		foreach my $i (0 .. $#variable_names) {
    		if ($index_name =~ m/$variable_names[$i]/){
    			$index_name = $variable_names[$i];
    		}
    	}
     	print $eliza;
     	# Close at situation
     	if ($input =~ m/^(what|how much)\sdid\s(.+)\s(close at)$/){
     		foreach my $i (0 .. $#document) {
  				if ($document[$i] =~ m/(.*)\b($index_name)\b(.*)\bclose(.*)at\s([\d\.]+)\b/){
  					print "$5\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$5");
    			}
    			elsif ($document[$i] =~ m/($index_name)(, which)?\s($down)\s((\d)+\s(\d)+\/(\d)+)\sto\s((\d)+\s(\d)+\/(\d)+)/) {		    
    		    	print "$10\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$10");
    			}
  				else{
  					push(@results, "There are no information available");
  				}
     		}
  		}
  		# Open at situation
  		elsif($input =~ m/^(what|how much)\sdid\s(.+)\s(open at)$/){
  			foreach my $i (0 .. $#document) {
  				if ($document[$i] =~ m/(.*)\b($index_name)\b(.*)\bopen(.*)at\s([\d\.]+)\b/){
  					print "$5\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$5");
    			}
  				else{
  					push(@results, "There are no information available");
  				}
     		}
  		}
  		if (@results == grep { $_ eq "There are no information available" } @results) {
  			print "$results[-1]\n";
		}
  	}
  	# Determine if the question is about how much did the ... drop/rise?
  	elsif ($input =~ m/^how much\sdid\s(.+)\s(drop|rise|fall|(go up)|(go down))$/){
		$index_name = trim($1);
  		foreach my $i (0 .. $#variable_names) {
    		if ($index_name =~ m/$variable_names[$i]/){
    			$index_name = $variable_names[$i];
    		}
    	}
    	print $eliza;
    	if ($input =~ m/^how much\sdid\s(.+)\s(drop|fall|(go down))$/){
    		foreach my $i (0 .. $#document) {
    			if ($document[$i] =~ m/($index_name)(, which)?\s($down)\s((\d)+\s(\d)+\/(\d)+)\sto\s((\d)+\s(\d)+\/(\d)+)/) {		    
    		    	print "$6\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");
    			}
    			elsif ($document[$i] =~ m/($index_name)\s(closed)\s((\d)+ (\d)+\/(\d+))/){
    				print "$3\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$3");
    			}
    			elsif ($document[$i] =~ m/\b($index_name)\b(.*)($down)\s((\d)+((\.(\d)+)?)(%)?)/){
    				print "$6\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");
    			}
    			elsif ($document[$i] =~ m/($index_name)(.*)(of\s((\d)+((\.(\d)+)?)(%)?)\spoints\s($down))/){
					print "$4\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");    			}
    			else{
  					push(@results, "There are no information available");
  				}
    		}
    	}
    	elsif ($input =~ m/^how much\sdid\s(.+)\s(rise|(go up))$/){
    		foreach my $i (0 .. $#document) {
    			if ($document[$i] =~ m/($index_name)(, which)?\s($up)\s((\d)+\s(\d)+\/(\d)+)\sto\s((\d)+\s(\d)+\/(\d)+)/) {		    
    		    	print "$6\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");
    			}
    			elsif ($document[$i] =~ m/($index_name)\s(closed)\s((\d)+ (\d)+\/(\d+))/){
    				print "$3\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$3");
    			}
    			elsif ($document[$i] =~ m/\b($index_name)\b(.*)($up)\s((\d)+((\.(\d)+)?)(%)?)/){
    				print "$5\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");
    			}
    			elsif ($document[$i] =~ m/($index_name)(.*)(of\s((\d)+((\.(\d)+)?)(%)?)\spoints\s($up))/){
					print "$4\n";
    				print $source; print "$document[$i]"; print "(line: $i)\n";
    				push(@results, "$6");    			}
    			else{
  					push(@results, "There are no information available");
  				}
    		}
    	}
     	if (@results == grep { $_ eq "There are no information available" } @results) {
  			print "$results[-1]\n";
		}
    }
  	else{
  		print "Please try different way.\n";
  	}
	print "$user";
}


