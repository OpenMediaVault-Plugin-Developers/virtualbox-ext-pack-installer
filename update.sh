#!/bin/bash

export DEBEMAIL="plugins@omv-extras.org"
export DEBFULLNAME="OpenMediaVault Plugin Developers"

SUBSTVARS_FILE="debian/substvars"
PACKAGE_VIRTUALBOX_VERSION="$(cat ${SUBSTVARS_FILE} | grep virtualbox:version= | cut -c 20-)"
VIRTUALBOX_VERSION="$(wget -qO- http://download.virtualbox.org/virtualbox/LATEST.TXT)"

if [ "${PACKAGE_VIRTUALBOX_VERSION}" != "${VIRTUALBOX_VERSION}" ]; then

    # Set the latest version in substvars
    echo "virtualbox:version=${VIRTUALBOX_VERSION}" > ${SUBSTVARS_FILE}

    # Update the changelog and set the latest version
    dch -U --no-auto-nmu --newversion ${VIRTUALBOX_VERSION} "Update to ${VIRTUALBOX_VERSION}"
    dch -U --no-auto-nmu --release ""

else
    echo "Already at latest version, nothing to do."
fi

exit 0
