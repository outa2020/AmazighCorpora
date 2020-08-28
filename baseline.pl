#!/usr/bin/perl -w
###########script description##########################################################################
# baseline: compute a baseline classification pos tagging (after changing name entity baseline program)
# usage:    baseline train test
# this is script was done by Mohamed Outahajala 23 August 2011
#######################################################################################################


my (
   @classes,@words, @test,
   %hash,    # hash table for words and their categories frequencicies
 );

%hash = ();
%hashclasses=();#--- hash table to contain all the classes
%hashwords=();#--- hash table to contain all the words

$debug = 0;
if (defined $ARGV[0] and $ARGV[0] eq "-d") { 
   $debug = 1;
   shift(@ARGV);
}

if ($#ARGV != 1) { die "usage: baseline.pl train test\n"; }
$train = shift(@ARGV); # the train file first
$test = shift(@ARGV);

# read train file

open(INFILE,$train);
while (<INFILE>) {
	$line = $_;
	chomp($line);
	if ($line ne "") {
		@words = split(/\s+/,$line);
		$word = shift(@words); # word is first item on line
		if (not defined $hashwords{$word}){ $hashwords{$word} = 1;}
	 	$tag = pop(@words);    # tag is last item on line
		#print "$word---$tag \n"; ---just for the test
		if (not defined $hashclasses{$tag}){ $hashclasses{$tag} = 1;}  
	   
		if (not defined $hash{$word}{$tag}) { 
		   	$hash{$word}{$tag} = 1; 
		} else {$hash{$word}{$tag}++; }
	}	  
}
close(INFILE);

# read test file
@test = ();
open(INFILE,$test) or die "cannot open $test\n";
while (<INFILE>) {
   $line = $_;
   chomp($line);
   push(@test,$line);
}
close(INFILE);

# assign POS tags to test file
$i = 0;

LOOP: while ($i<=$#test) {
		
	if (not $test[$i]) { print "\n"; $i++; next LOOP; }
	@words = split(/\s+/,$test[$i]);
	$word = $words[0];
	#---$cat = $words[$#words]; was not used
	$NbrBestCat = 0;
	if( defined $hashwords{$word}){
		foreach $t (keys %{$hash{$word}}){
				if (defined $hash{$word}{$t}){
					if ($hash{$word}{$t} > $NbrBestCat){ $NbrBestCat = $hash{$word}{$t}; $bestcat = $t; };
				}	
		}
	print $test[$i]."\t".$bestcat."\n";
	}else{
		print $test[$i]."\t"."NN"."\n";  
	}
	$i++;
}

exit(0);


