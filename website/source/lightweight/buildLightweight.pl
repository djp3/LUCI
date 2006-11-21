#!/usr/bin/perl -w
use strict;
use XML::DOM;

$| = 1;

my $parser = XML::DOM::Parser->new();
my $file = '../websiteContent/menuItems.xml';
my $doc = $parser->parsefile($file);

sub outputHTMLHeader()
{
	my $filepath=$_[0];
	my $deepLink=$_[1];
	print OUTFILE "<html>\n";
	print OUTFILE "<head>\n";
	print OUTFILE "<title>LUCI Light Weight</title>\n";
	print OUTFILE "<link rel=\"stylesheet\" href=\"http://luci.ics.uci.edu/blog/styles-site.css\" type=\"text/css\" />\n";
	print OUTFILE "</head>\n";
	print OUTFILE "<body>\n";
	print OUTFILE "<div class=\"container\">\n";
	print OUTFILE "<div class=\"banner\">\n";
	print OUTFILE "<div class=\"bannerblock\">\n";
	print OUTFILE "<table>\n";
	print OUTFILE "<tr>\n";
	print OUTFILE "<td style=\"padding:20px;margins:20px\">\n";
	print OUTFILE "<img src=\"".$filepath."LUCIhorzTight.jpg\" alt=\"LUCI logo\"/>\n";
	print OUTFILE "</td>\n";
	print OUTFILE "<td>\n";
	print OUTFILE "<p><a href=\"http://luci.ics.uci.edu/#".$deepLink."\">Click Here to Switch to Interactive FlashVersion</a></p>\n";
	print OUTFILE "</td>\n";
	print OUTFILE "</tr>\n";
	print OUTFILE "</table>\n";
	print OUTFILE "</div>\n";
	print OUTFILE "</div>\n";
	print OUTFILE "</div>\n";
}

sub outputHTMLFooter()
{
	print OUTFILE "</body>\n";
	print OUTFILE "</html>\n";
}

my @deepLinkList;

open(OUTFILE, "> index.html")||die;
&outputHTMLHeader("","");

print OUTFILE "<div class=\"container\">\n";
print OUTFILE "<div class=\"content\">\n";
foreach my $menuItems ($doc->getElementsByTagName('menuItem')){
	my $text = $menuItems->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;

	my @indent = $menuItems->getElementsByTagName('indent');
	my $indent=0;
	if($#indent != -1){
		$indent= $menuItems->getElementsByTagName('indent')->item(0)->getFirstChild->getNodeValue;
	}
	for (my $i = 0; $i< $indent; $i++){
		print OUTFILE "+++++";
	}

	my $deepLinked = 0;
	foreach my $deepLinks ($menuItems->getElementsByTagName('deepLink')){
		push @deepLinkList, $deepLinks->getFirstChild->getNodeValue;
		print OUTFILE "<a href=\"".$deepLinks->getFirstChild->getNodeValue."/index.html\">$text</a>\n";
		$deepLinked = 1;
	}
	if ($deepLinked == 0){
		print OUTFILE $text."\n";
	}
	print OUTFILE "<br/>\n";
}
print OUTFILE "</div>\n";
print OUTFILE "</div>\n";
&outputHTMLFooter();

close(OUTFILE);

foreach my $deepLinks (@deepLinkList){
	mkdir $deepLinks;
	open(OUTFILE, "> $deepLinks/index.html")||die;
	&outputHTMLHeader("../",$deepLinks);
	print OUTFILE "<div class=\"container\">\n";
	print OUTFILE "<div class=\"content\">\n";
	print OUTFILE "<a href=\"..\\index.html\">UP</a>\n";
	print OUTFILE "</div>\n";
	print OUTFILE "<div class=\"content\">\n";
	print OUTFILE "<p>$deepLinks</p>\n";
	print OUTFILE "</div>\n";
	print OUTFILE "</div>\n";
	&outputHTMLFooter();
	close(OUTFILE);
}






