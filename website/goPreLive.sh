#!/bin/bash

echo +++
echo +++ Build Light Weight Site 
echo +++
pushd .
cd source/lightweight
./buildLightweight.pl
popd

echo +++
echo +++ Validate XML
echo +++
for i in `find . | grep "xml$" | grep -v svn`;\
do echo "++++++ Validating XML" $i;\
xml val -b $i || exit;
done
for i in `find . | grep "^.*source.*html$" | grep -v svn`;\
do echo "++++++ Validating HTML" $i;\
xml val -b $i || exit;
done

echo +++
echo +++Transferring files to temp_html
echo +++

rsync -e ssh --progress -az -L --delete --delete-excluded --exclude="**.svn**" publish/ 'djp3@luci.ics.uci.edu:/home/djp3/temp_html/'
#rsync -e ssh --progress -az -L --delete --delete-excluded --exclude="**.svn**" publish/ /Users/djp3/Sites

echo +++
echo +++Changing permissions
echo +++

ssh djp3@luci.ics.uci.edu chmod -R a+r temp_html

#echo +++
#echo +++Shifting to calla, Authenticate to sesweb
#echo +++ This is all wrong
#echo +++
#echo +++Execute this:
#echo "+++ gsu sesweb;exit;"
#echo "+++ cd;cd htdocs/LUCI;./copyContent.sh;exit;"
#echo +++ 
echo +++Execute this:
echo "+++ goLive.sh;"
echo +++ 

#echo "Commented out"
ssh djp3@djp3-pc8.ics.uci.edu

echo "+++"
echo "+++Check validity of links"
echo "+++"
#echo "Commented out"
open "http://validator.w3.org/checklink?uri=http%3A%2F%2Fluci.ics.uci.edu%2Flightweight&hide_type=all&recursive=on&depth=4&check=Check"
