#!/usr/bin/perl -w
if ($#ARGV != 1) { die "usage: lexicon_script.pl  entry_file outputfile errors_file \n"; }
$file_dictio= "dictio"; # this file contains the correct writen words

# to put dictio words in a hash

%hashwords = ();
open(IN,'<:utf8',"$file_dictio");
@words ="";

open(FILE,$ARGV[0]) or die "can't open  the file dictio : $!";
	
while (<IN>) {
	$line = $_;
	chomp($line);
	if ($line ne "") {
		@words = split(/\s+/,$line);
		$word = shift(@words); # word is first item on line
		#print "$word-----$tag\n"; #---just for the test
		if (not defined $hashwords{$word}){ 
			#print "$word\t$tag\n";
			$hashwords{$word} = 1;		   	
			} 
		} else {
			$hashwords{$word}++; 
			
		}
	}  
}
# close IN file
close(IN);


open(IN1,'<:utf8',$ARGV[0

open(OUT,'>:utf8',$ARGV[1]);
open(OUT_err,'>:utf8',$ARGV[2]);

while (<IN1>) {
	$line = $_;
	chomp($line);
	if ($line ne "") {
		@words = split(/\s+/, $line);
		$word = $words[0]; # word is first item on line
		if (defined $hashwords{$word}){
			print OUT "$word\n";			
		}else { print OUT_err "line $word--->line: $.;\n";}
		
	}else { print OUT "\n" ;}
}

close(IN1);
close(OUT);
close(OUT_err);





