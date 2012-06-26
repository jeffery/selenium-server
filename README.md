# Synopsis

This project is a container for implementing 'Selenium standalone server' on a
Debian OS. It contains necessary scripts to build a debian package.

Upon installation an init.d script is setup to start an 'X Virtual Frame
Buffer' prior to launching the Selenium server.

# Building

To build the debian package, you require the debian packages 'ant' and
'dpkg-dev' installed. Once installed, simply execute the following in the root
of the project.

	ant

# Dependency

This package also depends on the xvfb-daemon debian package which is available
at https://github.com/jeffery/xvfb-daemon

# Running

The Selenium server should start up automatically on system boot. It can also
be manually started/stopped/re-started by executing the following command.

	sudo /etc/init.d/selenium-server start

# Environment & Logging

The server runs as the 'selenium' user with the home directory set to
/var/lib/selenium. Logging for the server is available under
/var/log/selenium-server/

# Project Maintenance

TODO
