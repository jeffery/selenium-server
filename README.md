# Synopsis

This project is container for implementing 'Selenium standalone server' on a
Debian OS. It contains necessary scripts to build a debian package.

Upon installation an init.d script is setup to start an 'X Virtual Frame
Buffer' prior to launching the Selenium server.

# Building

To build the debian package, simply execute the following in the root of the
project.

	debuild -i -uc -us

# Running

The Selenium server should start up automatically on system boot. It can also be manually started/stopped/re-started by executing the following command.

	sudo /etc/init.d/selenium-server start
