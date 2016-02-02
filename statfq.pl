#!/usr/bin/perl

my $filenamein1 = $ARGV[0];
my $out=$ARGV[1];
my @line1;
my $id1;
my $reads=0;
my $sum=0;

open $FILEA, "< $filenamein1";

while(<$FILEA>) {
        $line1[0]=$_;
        $_ = <$FILEA>;
        $line1[1]=$_;
	chomp($line1[1]); 
        $_ = <$FILEA>;
        $line1[2]=$_; 
        $_ = <$FILEA>;
        $line1[3]=$_;
        $reads+=1;
        $sum+=length($line1[1]);
        $sum-=1;

}

my $str='';
$str="the number of reads is $reads\nthe sum length is $sum bp\n";
open(OUT,'>',$out);
print OUT $str;
close(OUT);
