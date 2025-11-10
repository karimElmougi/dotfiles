#! /usr/bin/env bash


if [[ `uname` == "Darwin" ]]; then
    PKGSRC=https://pkgsrc.smartos.org/packages/Darwin
    LATEST_VERSION=$(curl -fsSL $PKGSRC | sed -En 's/.*href="([0-9]+\.[0-9]+)\/".*/\1/p' | tail -n 1)
    if command -v pkgin; then
        CURRENT_VERSION=$(cat /opt/pkg/etc/pkgin/repositories.conf | tail -n 1 | awk -F / '{print $6}')

        if [[ "$CURRENT_VERSION" == "$LATEST_VERSION" ]]; then
            exit 0
        fi

        echo Updating pkgin
        UPGRADE_TAR=$(curl -fsSL $PKGSRC/bootstrap-upgrade | grep -Eo "bootstrap-macos$LATEST_VERSION-trunk-arm64-[0-9]+-upgrade\.tar\.gz" | tail -n 1)

        echo Selected version $UPGRADE_TAR

        # Download the upgrade kit to the current directory.
        curl -O $PKGSRC/bootstrap-upgrade/${UPGRADE_TAR}

        # Unpack upgrade kit to /opt/pkg
        sudo tar -zxpf ${UPGRADE_TAR} -C /

        # Ensure you are running the latest package tools.
        sudo pkg_add -U pkg_install pkgin

        # Clean out any old packages signed with the previous key.
        sudo pkgin clean

        # Upgrade all packages.
        sudo pkgin -y upgrade

        rm $UPGRADE_TAR
    else
        echo Installing pkgin
        BOOTSTRAP_TAR=$(curl -fsSL $PKGSRC/bootstrap | grep -Eo "bootstrap-macos$LATEST_VERSION-trunk-arm64-[0-9]+\.tar\.gz" | tail -n 1)

        echo Selected version $BOOTSTRAP_TAR

        # Download the bootstrap kit to the current directory.
        curl -O $PKG_URL/${BOOTSTRAP_TAR}

        # Install bootstrap kit to /opt/pkg
        sudo tar -zxpf ${BOOTSTRAP_TAR} -C /

        # Reload PATH/MANPATH (pkgsrc installs /etc/paths.d/10-pkgsrc for new sessions)
        eval $(/usr/libexec/path_helper)

        rm $BOOTSTRAP_TAR
    fi
fi
