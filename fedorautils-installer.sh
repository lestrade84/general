#!/bin/bash
# Script to install Fedy <http://satya164.github.io/fedy/>.
# Copyright (C) 2014  Satyajit sahoo

if [[ ! $(whoami) = "root" ]]; then
    echo "Please run the script as root."
    exit 1
fi

# Add the repo
echo "Adding repository..."
cat <<EOF | tee /etc/yum.repos.d/fedy.repo > /dev/null 2>&1
[fedy]
name=Fedy
type=rpm-md
baseurl=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/
gpgkey=http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_\$releasever/repodata/repomd.xml.key
gpgcheck=1
enabled=1
metadata_expire=1d
skip_if_unavailable=1
EOF

# Test if the repo is available for current Fedora version and install the package
echo "Installing fedy..."
fver="$(rpm -E %fedora)"
curl -s -f -L "http://download.opensuse.org/repositories/home:/satya164:/fedorautils/Fedora_${fver}/repodata/repomd.xml" -o /dev/null
if [[ $? -eq 0 ]]; then
    yum -y install --nogpgcheck --skip-broken fedy
else
    yum -y install --nogpgcheck --skip-broken coreutils curl sed tar unzip wget yad
    yum -y install --nogpgcheck --skip-broken --releasever="$((fver-1))" fedy
fi

# Please report bugs at <http://github.com/satya164/fedy/issues>
# End of the Script
