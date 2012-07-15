#!/bin/bash
#
# Startup script used by Selenium launchd job.
# Mac OS X launchd process calls this script to customize
# the java process command line used to run Jenkins.
# 
# Customizable parameters are found in
# /Library/Preferences/au.net.fernandez.selenium.plist
#
# You can manipulate it using the "defaults" utility.
# See "man defaults" for details.

defaults="defaults read /Library/Preferences/au.net.fernandez.selenium.plist"

jar=`$defaults jar` || jar="/Applications/Selenium/selenium-server.jar"

javaArgs=""
heapSize=`$defaults heapSize` && javaArgs="$javaArgs -Xmx${heapSize}"
stackSize=`$defaults stackSize` && javaArgs="$javaArgs -Xss${stackSize}"
permGen=`$defaults permGen` && javaArgs="$javaArgs -XX:MaxPermSize=${permGen}"

home=`$defaults SELENIUM_HOME` && export SELENIUM_HOME="$home"

add_to_args() {
    val=`$defaults $1` && args="$args -${1} ${val}"
}

args=""
add_to_args port
add_to_args timeout
add_to_args browserTimeout
add_to_args interactive
add_to_args singleWindow
add_to_args profilesLocation
add_to_args forcedBrowserMode
add_to_args forcedBrowserModeRestOfLine
add_to_args userExtensions
add_to_args browserSessionReuse
add_to_args avoidProxy
add_to_args firefoxProfileTemplate
add_to_args debug
add_to_args browserSideLog
add_to_args ensureCleanSession
add_to_args trustAllSSLCertificates
add_to_args log
add_to_args htmlSuite
add_to_args proxyInjectionMode

echo "SELENIUM_HOME=$SELENIUM_HOME"
echo "Selenium command line for execution:"
echo /usr/bin/java $javaArgs -jar "$jar" $args
exec /usr/bin/java $javaArgs -jar "$jar" $args
