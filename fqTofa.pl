#!/usr/bin/perl

$filenameA = $ARGV[0];
$filenameOut = $ARGV[1];

open $FILEA, "< $filenameA";
open $OUTFILE, "> $filenameOut";


while(<$FILEA>) {
	$_=~tr/@/>/;
	print $OUTFILE $_;
	$_ = <$FILEA>;
	$_=~tr/@/>/;
	print $OUTFILE $_; 

	$_ = <$FILEA>; 
	$_ = <$FILEA>;
}
