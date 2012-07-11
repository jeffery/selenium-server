# Synopsis

This project is a container for implementing 'Selenium standalone server' on a
Debian OS. It contains necessary scripts to build a debian package.

Upon installation an init script is setup to start a 'Selenium Server'
listening on port 4444. Read the Dependency section prior to installing the
Selenium server.

# Dependency

This package also depends on the xvfb-daemon debian package which is available
at https://github.com/jeffery/xvfb-daemon

# Building

To build the debian package, you require the debian packages 'ant' and
'dpkg-dev' installed. Once installed, simply execute the following in the root
of the project.

	ant

# Running

The Selenium server should start up automatically on system boot. It can also
be manually started/stopped/re-started by executing the following command.

	sudo /etc/init.d/selenium-server start

# Environment Setup & Logging

* The server runs as the 'selenium' user with the home directory set to /var/lib/selenium. 
* Logging for the server is available under /var/log/selenium-server/
* The server is setup to run with an 'X Virtual Frame Buffer' on DISPLAY port 99.0
* Any non-default configuration changes can be made in /etc/defaults/selenium-server

If you are using Selenium RC protocol ( aka Selenium 1 ), then you can instruct
the Selenium server to save the screenshots taken via the server to be saved
into /var/lib/selenium/screenshots. If the Apache2 web-server is installed on
the Server, an Apache2 alias '/selenium' is created to get access to the
screenshots.

	eg. request for screenshot http://<server ip-address>/selenium/screenshots/

# Pre-built Binaries

The lastest debian release of this software is available from the following URL:
http://www.jefferyfernandez.id.au/downloads/selenium-server_<selenium release>-<debian release>_all.deb

	eg. http://www.jefferyfernandez.id.au/downloads/selenium-server_2.24.1-16_all.deb

# Project Maintenance

TODO
