#!/bin/sh
#https://www.ibm.com/support/knowledgecenter/en/linuxonibm/liabo/liaboconcept.htm
#in current directory to replace all foo with bar
#sed -i -- 's/foo/bar/g' *
#recursive incl hidden files
#find . -type f -exec sed -i 's/foo/bar/g' {} +