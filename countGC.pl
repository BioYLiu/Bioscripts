#!usr/bin/perl 
#write by lyuan513@gmail.com 2011-5-20
#Useage : perl countGC.pl inputfile outputfile
use strict;
use warnings;

foreach my $inputfile(@ARGV){
	open INPUTFILE,"< $inputfile" or die "can't open file!please check you file name!";
	open OUTFILE,">> thePercentageOfGC.txt";
	my @File=<INPUTFILE>;
	close INPUTFILE;
	#combain the data
	my $DNA=join "",@File;
	$DNA =~ s/\s//g;
	my @DNA=split//,$DNA;
	my $CountA=0;
	my $CountG=0;
	my $CountC=0;
	my $CountT=0;
	my $error=0;
	#compute percentage
	foreach (@DNA){
		if (/A/){$CountA++}
		elsif(/G/){$CountG++}
		elsif(/C/){$CountC++}
		elsif(/T/){$CountT++}
		else{$error++}
		}

	#compute the GC count
	my $GC=(($CountG+$CountC)*100)/($CountA+$CountC+$CountG+$CountT);
	#sprinf
	printf OUTFILE  "The $inputfile file's GC%%\=%.4f%%,Attention!!!!I can't recognize bases total are $error\n",$GC;
	}

close OUTFILE;
close INPUTFILE;
exit;
