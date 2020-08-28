#!/usr/bin/perl

#####################################################################
# By: Mona Diab
# Date: March 12 2004
# Description: This script takes in a tokenized corpus as input and outputs it in a format ready for the Yamcha POS tagging
# Purpose: to prepare the files for running SVM POS tagging
# 
#################################################################


# Check program arguments, and other initializations
#

$argc = @ARGV;
if ($argc != 2) { die("Usage: convRaw2Yam4POS.pl infile outfile\n");}

# This is the tokenised Arabic Transliterated into the BUck form non vocalised
open(IN,"< $ARGV[0]") || die("Unable to open 1 $ARGV[0]\n");

# the output file with dummy POS tags and features ready for POS tagging 
open(OUT,"> $ARGV[1]") || die("Unable to open 2 $ARGV[1]\n");

while ($line=<IN>)
{
	if ($line =~ m/^\n$/ ){
		print OUT "\n";
	}else{
	
	    	chomp $line;
	    	@sent="";
		@sent=split(/\s+/,$line);
		$sc=0;
	    	print OUT "$sent[$sc]\t";
		@wordarr="";
		@wordarr=split(//,$sent[$sc]);
		@rwordarr=reverse(@wordarr);
		if ($#wordarr<4)
		{
		    #insert nils
		    if ($#wordarr==3)
		    {
			print OUT "$wordarr[0]\t$wordarr[0]$wordarr[1]\t$wordarr[0]$wordarr[1]$wordarr[2]\t-\t";
			print OUT "$rwordarr[0]\t$rwordarr[1]$rwordarr[0]\t$rwordarr[2]$rwordarr[1]$rwordarr[0]\t-\t";
		    }
		    elsif ($#wordarr==2)
		    {
			print OUT "$wordarr[0]\t$wordarr[0]$wordarr[1]\t-\t-\t";
			print OUT "$rwordarr[0]\t$rwordarr[1]$rwordarr[0]\t-\t-\t";
		    }
		    elsif($#wordarr==1)
		    {
			print OUT "$wordarr[0]\t-\t-\t-\t";
			print OUT "$rwordarr[0]\t-\t-\t-\t";
		    }
		    else
		    {
			print OUT "-\t-\t-\t-\t";
			print OUT "-\t-\t-\t-\t";
		    }
		}
		else
		{
		    print OUT "$wordarr[0]\t$wordarr[0]$wordarr[1]\t$wordarr[0]$wordarr[1]$wordarr[2]\t$wordarr[0]$wordarr[1]$wordarr[2]$wordarr[3]\t";
		    print OUT "$rwordarr[0]\t$rwordarr[1]$rwordarr[0]\t$rwordarr[2]$rwordarr[1]$rwordarr[0]\t$rwordarr[3]$rwordarr[2]$rwordarr[1]$rwordarr[0]\t";
		}
		#print OUT "$feature\tNP\n";
		$sc++;
		# to print the POS  + \n -------Outahajala
		print OUT "$sent[$sc]\n";
	    #} dial second while!!
	    #print OUT "\n";
	
	}	
}
