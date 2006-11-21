#!/usr/bin/perl -w
use strict;
use XML::DOM;

$| = 1;

my $parser = XML::DOM::Parser->new();
my $file = '../websiteContent/menuItems.xml';
my $doc = $parser->parsefile($file);

sub outputHTMLHeader()
{
	my $OUTFILE=$_[0];
	my $filepath=$_[1];
	my $deepLink=$_[2];
	print $OUTFILE "<html>\n";
	print $OUTFILE "<head>\n";
	print $OUTFILE "<title>LUCI Light Weight</title>\n";
	print $OUTFILE "<link rel=\"stylesheet\" href=\"http://luci.ics.uci.edu/blog/styles-site.css\" type=\"text/css\" />\n";
	print $OUTFILE "</head>\n";
	print $OUTFILE "<body>\n";
	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"banner\">\n";
	print $OUTFILE "<div class=\"bannerblock\">\n";
	print $OUTFILE "<table>\n";
	print $OUTFILE "<tr>\n";
	print $OUTFILE "<td style=\"padding:20px;margins:20px\">\n";
	print $OUTFILE "<img src=\"".$filepath."LUCIhorzTight.jpg\" alt=\"LUCI logo\"/>\n";
	print $OUTFILE "</td>\n";
	print $OUTFILE "<td>\n";
	print $OUTFILE "<p><a href=\"http://luci.ics.uci.edu/#".$deepLink."\">Click Here to Switch to Interactive FlashVersion</a></p>\n";
	print $OUTFILE "</td>\n";
	print $OUTFILE "</tr>\n";
	print $OUTFILE "</table>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
}

sub outputHTMLFooter()
{
	my $OUTFILE=$_[0];
	print $OUTFILE "</body>\n";
	print $OUTFILE "</html>\n";
}

sub makeSubpage()
{
	my $root = $_[0];
	my $deepLink = ($root->getElementsByTagName('deepLink')->item(0)->getFirstChild->getNodeValue);
	my $template = ($root->getElementsByTagName('template')->item(0));
	my $templateTitle = ($template->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue);

	mkdir $deepLink;
	my $OUTFILE;
	open($OUTFILE, "> $deepLink/index.html")||die;

	&outputHTMLHeader($OUTFILE,"../",$deepLink);

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<a href=\"..\\index.html\">UP</a>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<p>$deepLink</p>\n";
	print $OUTFILE "<p>$templateTitle</p>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
	&outputHTMLFooter($OUTFILE);
	close($OUTFILE);
}


my $OUTFILE;
open($OUTFILE, "> index.html")||die;
&outputHTMLHeader($OUTFILE,"","");

print $OUTFILE "<div class=\"container\">\n";
print $OUTFILE "<div class=\"content\">\n";
foreach my $menuItems ($doc->getElementsByTagName('menuItem')){
	my @indent = $menuItems->getElementsByTagName('indent');
	my $indent=0;
	if($#indent != -1){
		$indent= $menuItems->getElementsByTagName('indent')->item(0)->getFirstChild->getNodeValue;
	}
	my @title = $menuItems->getElementsByTagName('title');
	my $title=0;
	if($#title != -1){
		$title= $menuItems->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
	}

	for (my $i = 0; $i< $indent; $i++){
		print $OUTFILE "+++++";
	}

	#Check to see about making a subpage
	my @clickable = $menuItems->getElementsByTagName('clickable');
	if($#clickable != -1){
		&makeSubpage($clickable[0]);

		foreach my $deepLinks ($clickable[0]->getElementsByTagName('deepLink')){
			print $OUTFILE "<a href=\"".$deepLinks->getFirstChild->getNodeValue."/index.html\">$title</a>\n";
		}
	}
	else{
		print $OUTFILE $title."\n";
	}
	print $OUTFILE "<br/>\n";
}
print $OUTFILE "</div>\n";
print $OUTFILE "</div>\n";
&outputHTMLFooter($OUTFILE);

close($OUTFILE);






