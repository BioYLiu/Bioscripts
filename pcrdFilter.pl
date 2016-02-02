#!/usr/bin/perl

#writed by zhao 2010/5/20
#filter the PCR duplication reads
use strict;
use warnings;

#get input information
use Getopt::Long;
my %opts ;
GetOptions(\%opts,"a:s","b:s","w:i","o:s","help");

if((!$opts{a}) or (!$opts{b}) or (!$opts{w}) or (!$opts{o}) ){
    Usage(),exit(1);
}

my $fq1=$opts{a};
my $fq2=$opts{b};
my $alen=$opts{w};
my $outname=$opts{o};
my $seq;
my %stra;
my %strb;
my %qu;
my $rqu;
my $outstr1='';
my $outstr2='';
my $temp1;
my $temp2;

open(IN1,'<',$fq1) or die("not open the $fq1 file\n");
open(IN2,'<',$fq2) or die("not open the $fq2 file\n");
while($_=<IN1>){
	$temp1=$_;
	$_=<IN1>;
	$temp1.=$_;
	$seq=substr($_,0,$alen);

	$_=<IN2>;    	
        $temp2=$_;
        $_=<IN2>;
        $temp2.=$_;
        $seq.='-'.substr($_,0,$alen);

        $_=<IN1>;
        $temp1.=$_;
        $_=<IN1>;
        $temp1.=$_;
	$rqu=qu($_);
	
        $_=<IN2>;
        $temp2.=$_;
        $_=<IN2>;
        $temp2.=$_;
	$rqu+=qu($_);

	#print "$temp1$rqu\n";	
	if(!$qu{$seq}){
		$qu{$seq}=$rqu;
                $stra{$seq}=$temp1;
                $strb{$seq}=$temp2;
		#print "$temp1$rqu\n";
	}else{
		if($rqu>=$qu{$seq}){
			$qu{$seq}=$rqu;
			$stra{$seq}=$temp1;
			$strb{$seq}=$temp2;
	#		print "$seq\n".$stra{$seq}.$strb{$seq}.$qu{$seq}."\n";
		}
	}
#	print "$seq\n".$stra{$seq}.$strb{$seq}.$qu{$seq}."\n";
	
}
close(IN1);
close(IN2);

open(OUT1,'>',$outname."_1.fq");
open(OUT2,'>',$outname."_2.fq");
foreach $seq (keys(%stra)){
	#print "$seq\n".$stra{$seq}. $strb{$seq};
	print OUT1 $stra{$seq};
        print OUT2 $strb{$seq}; 
} 
close(OUT1);
close(OUT2);

sub qu{
	my ($str)=@_;
	my $qusum=0;
	my $i;
	for($i=0;$i<length($str);$i++){
		$qusum+=ord(substr($str,$i,1))-64;
	}
	return $qusum;
}

sub Usage{
    print qq(
        Usage:
            perl $0 [options]  ...
        Options:
            -a <str>  the 1th fastq file;
            -b  <int>  the 2nd fastq file;
            -w   <int>  the alignmengt length of reads;
            -o    <str>  the outfile name;     
            -help   < - >  show this help information
    \n);
}
