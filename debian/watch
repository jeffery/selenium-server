# Example watch control file for uscan
# Rename this file to "watch" and then you can run the "uscan" command
# to check for upstream updates and more.
# See uscan(1) for format

# Compulsory line, this is a version 3 file
version=3

# Download selenium-standalone-server from google code
# Example shown @ http://wiki.debian.org/debian/watch/ does not work
#http://code.google.com/p/selenium/downloads/list?can=1 .*/selenium-server-standalone-(\d[\d.]*)\.(?:zip|jar|tgz|tbz2|txz|tar\.gz|tar\.bz2|tar\.xz)

# This works as well
#opts=\
#downloadurlmangle=s#.*(selenium-server-standalone-([\d.]+)\.jar).*#http://selenium.googlecode.com/files/$1#,\
#filenamemangle=s#.*(selenium-server-standalone-([\d.]+)\.jar).*#$1# \
#http://code.google.com/p/selenium/downloads/list ^.*detail\?name=selenium-server-standalone-([\d.]+)\.jar.*

# See example @ http://anonscm.debian.org/viewvc/python-apps/packages/sinntp/trunk/debian/
opts=\
downloadurlmangle=s|.*[?]name=(.*?)&.*|http://selenium.googlecode.com/files/$1|,\
filenamemangle=s|[^/]+[?]name=(.*?)&.*|$1| \
http://code.google.com/p/selenium/downloads/detail[?]name=selenium-server-standalone-([0-9.]+).jar&.*

