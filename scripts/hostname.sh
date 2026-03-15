#!/bin/sh
set -e

echo "narsil" > /etc/hostname

if grep -q "127.0.1.1" /etc/hosts; then
    grep -q "127.0.1.1.*narsil" /etc/hosts || \
        sed -i 's/127.0.1.1.*/127.0.1.1\tnarsil/' /etc/hosts
else
    echo "127.0.1.1	narsil" >> /etc/hosts
fi

[ "$(cat /etc/hostname)" = "narsil" ] || exit 1
