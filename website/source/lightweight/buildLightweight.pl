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
	$deepLink =~ s/[&]/&amp;/g;
	print $OUTFILE "<html>\n";
	print $OUTFILE "<head>\n";
	print $OUTFILE "<title>Light Weight: LUCI: The Laboratory for Ubiquitous Computing and Interaction at UCI</title>\n";
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
	print $OUTFILE "<h3>Lightweight Version</h3>\n";
	print $OUTFILE "<p><a href=\"http://luci.ics.uci.edu/#".$deepLink."\">Interactive Flash Version</a></p>\n";
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
	print $OUTFILE "<script src=\"http://www.google-analytics.com/urchin.js\" type=\"text/javascript\"></script>\n";
	print $OUTFILE "<script type=\"text/javascript\">\n";
	print $OUTFILE "\tuacct = \"UA-338915-2\"\n";
	print $OUTFILE "\turchinTracker();\n";
	print $OUTFILE "</script>\n";
	print $OUTFILE "</body>\n";
	print $OUTFILE "</html>\n";
}


sub outputSidebarHeader()
{
	my $OUTFILE=$_[0];
	print $OUTFILE "<div class=\"sidebar\">\n";
	print $OUTFILE "<div class=\"content\">\n";
}

sub outputSidebarFooter()
{
	my $OUTFILE=$_[0];
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
}


sub makeSidebarSA()
{
	my $OUTFILE = $_[0];
	my $title = $_[1];
	my $url = $_[2];

	print $OUTFILE "<div class='sidebar'><div class='content'><b>LUCI Blog</b>\n";
	my $doc = $parser->parsefile($url);
	foreach my $items ($doc->getElementsByTagName('item')){
		my $linkURL = $items->getElementsByTagName('link')->item(0)->getFirstChild->getNodeValue;
		my $title = $items->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
		print $OUTFILE "<p><a href=\"".$linkURL."\">".$title."</a></p>\n";
	}
	print $OUTFILE "</div></div>\n";
}

sub makeSidebar()
{
	my $OUTFILE = $_[0];
	my $type = $_[1];
	my $title = $_[2];
	my $url = $_[3];
	if($type eq "SA"){
			&makeSidebarSA($OUTFILE,$title,$url);
	}
	else{
			&outputSidebarHeader($OUTFILE);
			print $OUTFILE "Sidebar template ".$type." not supported\n";
			&outputSidebarFooter($OUTFILE);
	}
}




sub makeTemplateAPage()
{
	my $OUTFILE = $_[0];
	my $url = $_[1];
	my $title = $_[2];
	my $sidebar = $_[3];

	if( $sidebar->hasChildNodes() != 0) {
		my $sidebarType = $sidebar->getElementsByTagName('type')->item(0)->getFirstChild->getNodeValue;
		my $sidebarTitle = $sidebar->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
		my $sidebarURL = $sidebar->getElementsByTagName('url')->item(0)->getFirstChild->getNodeValue;
		&makeSidebar($OUTFILE,$sidebarType,$sidebarTitle,$sidebarURL);
	}

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<a href=\"..\\index.html\">UP</a>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE $title."\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<div style=\"text-align:left;\">\n";

	my $TEMPLATE;
	open ($TEMPLATE,"< ../".$url) || die;
	while(<$TEMPLATE>){
			s/asfunction:_root.jumpToURLNewWindow,//g;
			print $OUTFILE $_;
	}
	close($TEMPLATE);

	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

}
sub makeTemplateBPage()
{
	my $OUTFILE = $_[0];
	my $url = $_[1];
	my $title = $_[2];
	my $filepath = $_[3];
	my $previousDeeplink = $_[4];
	my $sidebar = $_[5];

	if( ($sidebar) && ($sidebar->hasChildNodes() != 0)) {
		my $sidebarType = $sidebar->getElementsByTagName('type')->item(0)->getFirstChild->getNodeValue;
		my $sidebarTitle = $sidebar->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
		my $sidebarURL = $sidebar->getElementsByTagName('url')->item(0)->getFirstChild->getNodeValue;
		&makeSidebar($OUTFILE,$sidebarType,$sidebarTitle,$sidebarURL);
	}

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<a href=\"..\\index.html\">UP</a>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE $title."\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

	print $OUTFILE "<div class=\"container\">\n";
	print $OUTFILE "<div class=\"content\">\n";
	print $OUTFILE "<div style=\"text-align:left;\">\n";

	my $doc = $parser->parsefile("../".$url);
	foreach my $projects ($doc->getElementsByTagName('project')){
		my $subtitle = $projects->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue;
		my $textURL = $projects->getElementsByTagName('textURL')->item(0)->getFirstChild->getNodeValue;
		my $indent = $projects->getElementsByTagName('indent')->item(0)->getFirstChild->getNodeValue;
		my $deepLink = $projects->getElementsByTagName('deepLink')->item(0)->getFirstChild->getNodeValue;

		for( my $i = 0; $i<$indent;$i ++){
			print $OUTFILE "<div style=\"margin-left:20px;\">\n";
		}

		print $OUTFILE "<p><a href=\"./".$deepLink."/index.html\">".$subtitle."</a></p>\n";
		makeTemplateBSubpage($title.":".$subtitle,$previousDeeplink."&".$deepLink,$textURL,$filepath);

		for( my $i = 0; $i<$indent;$i ++){
			print $OUTFILE "</div>\n";
		}
	}

	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";
	print $OUTFILE "</div>\n";

}

sub makeTemplateBSubpage()
{
	my $title = $_[0];
	my $deepLink = $_[1];
	my $textURL = $_[2];
	my $filepath = $_[3];
	my $SUBPAGE;


	my $filepathDeepLink = $deepLink;
	$filepathDeepLink =~ s/[&]/\//g;
	mkdir $filepathDeepLink || die;
	open($SUBPAGE, "> $filepathDeepLink/index.html")||die;

	&outputHTMLHeader($SUBPAGE,$filepath,$deepLink);

	print $SUBPAGE "<div class=\"container\">\n";
	print $SUBPAGE "<div class=\"content\">\n";
	print $SUBPAGE "<a href=\"..\\index.html\">UP</a>\n";
	print $SUBPAGE "</div>\n";
	print $SUBPAGE "</div>\n";

	print $SUBPAGE "<div class=\"container\">\n";
	print $SUBPAGE "<div class=\"content\">\n";
	print $SUBPAGE $title."\n";
	print $SUBPAGE "</div>\n";
	print $SUBPAGE "</div>\n";

	print $SUBPAGE "<div class=\"container\">\n";
	print $SUBPAGE "<div class=\"content\">\n";
	print $SUBPAGE "<div style=\"text-align:left;\">\n";
	my $PROJECT;
	open ($PROJECT,"< ../".$textURL) || die;
	while(<$PROJECT>){
		s/asfunction:_root.jumpToURLNewWindow,//g;
		print $SUBPAGE $_;
	}
	close($PROJECT);
	print $SUBPAGE "</div>\n";
	print $SUBPAGE "</div>\n";
	print $SUBPAGE "</div>\n";
	&outputHTMLFooter($SUBPAGE);
	close($SUBPAGE);
}

sub makeSubpage()
{
	my $title = $_[0];
	my $root = $_[1];
	my $deepLink = ($root->getElementsByTagName('deepLink')->item(0)->getFirstChild->getNodeValue);
	my $template = ($root->getElementsByTagName('template')->item(0));
	my $templateTitle = ($template->getElementsByTagName('title')->item(0)->getFirstChild->getNodeValue);

	mkdir $deepLink;
	my $OUTFILE;
	open($OUTFILE, "> $deepLink/index.html")||die;

	if($template->getElementsByTagName('type')->item(0)->getFirstChild->getNodeValue eq "A"){
		&outputHTMLHeader($OUTFILE,"../",$deepLink);
		&makeTemplateAPage($OUTFILE,$root->getElementsByTagName('template')->item(0)->getElementsByTagName('url')->item(0)->getFirstChild->getNodeValue,$title.":".$templateTitle,$root->getElementsByTagName('sidebar'));
		&outputHTMLFooter($OUTFILE);
	}
	elsif($template->getElementsByTagName('type')->item(0)->getFirstChild->getNodeValue eq "B"){
		&outputHTMLHeader($OUTFILE,"../",$deepLink);
		&makeTemplateBPage($OUTFILE,$root->getElementsByTagName('template')->item(0)->getElementsByTagName('url')->item(0)->getFirstChild->getNodeValue,$title.":".$templateTitle,"../../",$deepLink,$root->getElementsByTagName('sidebar'));
		&outputHTMLFooter($OUTFILE);
	}
	else{

		&outputHTMLHeader($OUTFILE,"../",$deepLink);

		print $OUTFILE "<div class=\"container\">\n";
		print $OUTFILE "<div class=\"content\">\n";
		print $OUTFILE "<a href=\"..\\index.html\">UP</a>\n";
		print $OUTFILE "</div>\n";
		print $OUTFILE "<div class=\"content\">\n";
		print $OUTFILE "<p>This template is not coded for lightweight page yet: ".$template->getElementsByTagName('type')->item(0)->getFirstChild->getNodeValue."</p>\n";
		print $OUTFILE "</div>\n";
		print $OUTFILE "<div class=\"content\">\n";
		print $OUTFILE "<p>$deepLink</p>\n";
		print $OUTFILE "<p>$templateTitle</p>\n";
		print $OUTFILE "</div>\n";
		print $OUTFILE "</div>\n";
		&outputHTMLFooter($OUTFILE);
		close($OUTFILE);
	}
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
		&makeSubpage($title,$clickable[0]);

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






