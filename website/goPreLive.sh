#!/bin/bash
echo +++
echo +++ Validate XML
echo +++
for i in `find . | grep "xml$"`;\
do echo "++++++ Validating " $i;\
xml val $i || exit;
done

echo +++
echo +++Transferring files to temp_html
echo +++

rsync -e ssh --progress -az -L --delete --delete-excluded --exclude="**.svn**" publish/ 'djp3@calla.ics.uci.edu:/home/djp3/temp_html/'

echo +++
echo +++Changing permissions
echo +++

ssh djp3@calla.ics.uci.edu chmod -R a+r temp_html

echo +++
echo +++Shifting to calla, Authenticate to sesweb
echo +++
echo +++Execute this:
echo "+++ gsu sesweb;exit;"
echo "+++ cd;cd htdocs/LUCI;./copyContent.sh;exit;"
echo +++ 

ssh djp3@calla.ics.uci.edu


