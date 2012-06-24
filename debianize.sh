#!/bin/bash
:<<'README'
This is a helper script to trigger the build of a debian package for a project
which is in Git SCM.

The Changelog is parsed to obtain the release version and then the repository
is exported for package building.

TODO: If a newer version of the jar package is available for download, the jar
is downloaded, the package release version is incremented and a new release
build is made.

Author: Jeffery Fernandez <jeffery@fernandez.net.au>
README

# Set Error reporting on
set -e

# Get the Path of this script
getScriptPath()
{
	MY_PATH=`dirname $BASH_SOURCE`
	echo `readlink -e $MY_PATH`
}

# Get the Package Last release Version from the Debian Changelog file
getPackageLastVersion()
{
	local DEBIAN_CHANGELOG_PATH=$1
	dpkg-parsechangelog -l$DEBIAN_CHANGELOG_PATH | awk '/^Version/ {print $2}'
}

# Get the Package name from the Debian changelog
getPackageName()
{
	local DEBIAN_CHANGELOG_PATH=$1
	dpkg-parsechangelog -l$DEBIAN_CHANGELOG_PATH | awk '/^Source/ {print $2}'
}


# Make sure the Workspace variable is available
if [ -z "$WORKSPACE" ]; then
	WORKSPACE=$(getScriptPath)
fi

# Setup the Build path variable
PROJECT_BUILD_PATH="$WORKSPACE/build"

# If the changelog file exists
DEBIAN_CHANGELOG="$WORKSPACE/debian/changelog"


if [ -f "$DEBIAN_CHANGELOG" ]; then

	PACKAGE_VERSION=$(getPackageLastVersion "$DEBIAN_CHANGELOG")
	PACKAGE_NAME=$(getPackageName "$DEBIAN_CHANGELOG")
	
	# Set the Package name with version
	PACKAGE_NAME_VERSION="${PACKAGE_NAME}-${PACKAGE_VERSION}"
	
	# Set the Package build path
	PACKAGE_BUILD_PATH="${PROJECT_BUILD_PATH}/${PACKAGE_NAME_VERSION}"

	echo "Packaging: ${PACKAGE_NAME_VERSION}"
else
	echo "Could not detect Debian changelog" && exit 1
fi

# Clean up old Build path, if it exists
echo "Cleaning Up old builds"
if [ -d "${PACKAGE_BUILD_PATH}" ]; then
	rm -fR "${PACKAGE_BUILD_PATH}" && mkdir -p "${PACKAGE_BUILD_PATH}" || {
		echo "Could not execute cleanup operations" && exit 1
	}
else
	#  Make sure the Exporting directory exists
	mkdir -p "${PACKAGE_BUILD_PATH}" || {
		echo "Could not create package build workspace" && exit 1
	}
fi

# Export from the repository the debian and src folders and Unarchive it into the build folder
echo "Exporting for Package Build"
git archive HEAD debian src | ( cd "${PACKAGE_BUILD_PATH}" && tar -xf - ) || { 
	echo "Exporting Git Repository Failed"; exit 1; 
}

# Build the debian package
echo "Building package: ${PACKAGE_NAME_VERSION}"
cd "${PACKAGE_BUILD_PATH}" && debuild -i -us -uc || {
	echo "Build package failed with ${?}" && exit 1 
}

