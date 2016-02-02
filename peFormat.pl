#!/usr/bin/perl
use strict;
use warnings;

open IN,  "<$ARGV[0]";    #the fasta FILE
my $filename=(split/\./,$ARGV[0])[0];
open OUT1, ">$filename".'_1.fastq';
open OUT2, ">$filename".'_2.fastq';
open OUT3, ">$filename.single.fastq";
my ( %hash, $key,@arry);

while (<IN>) {
   $arry[0]=$_;
   $arry[1]=<IN>;
   $arry[2]=<IN>;
   $arry[3]=<IN>;
   $key=$arry[0];
   $hash{$key}.=$arry[0].$arry[1].$arry[2].$arry[3];
}
foreach(keys %hash){
	my $name=$_;
    $name=~s/@//;
    chomp($name);
    my $fqname1=$name.'/1';
    my $fqname2=$name.'/2';
    my @string=split/\n/,$hash{$_};
    if(@string>6){
        print OUT1 '@'."$fqname1\n$string[1]\n".'+'."$fqname1\n$string[3]\n";
        print OUT2 '@'."$fqname2\n$string[5]\n".'+'."$fqname2\n$string[7]\n";
    }else{
        print OUT3 '@'."$name\n$string[1]\n".'+'."$name\n$string[3]\n";
    }    
}

close IN;
close OUT1;
close OUT2;
close OUT3;
