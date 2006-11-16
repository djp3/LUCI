#!/usr/bin/perl -w
use strict;
use XML::DOM;

$| = 1;

my $parser = XML::DOM::Parser->new();
my $file = '../websiteContent/menuItems.xml';
my $doc = $parser->parsefile($file);

open(OUTFILE, "> index.html")||die;
print OUTFILE "<html>\n";
print OUTFILE "<head>\n";
print OUTFILE "<title>LUCI Light Weight</title>\n";
print OUTFILE "</head>\n";
print OUTFILE "<body>\n";
print OUTFILE "<p><a href=\"http://luci.ics.uci.edu/\">Flash Interactive Version</a></p>\n";

foreach my $menuItems ($doc->getElementsByTagName('menuItem')){
	print OUTFILE $menuItems->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
	print OUTFILE "<br/>\n";
}

print OUTFILE "</body>\n";
print OUTFILE "</html>\n";
close(OUTFILE);





