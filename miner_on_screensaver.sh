#!/usr/bin/env bash

wallet="3NXuqEF8s8F72xWRriyQfHRHgY4oTRaZpu"

dbus-monitor --session "type='signal',interface='org.gnome.ScreenSaver',member='ActiveChanged'" | while read line ; do
    if [ x"$(echo "$line" | grep 'boolean true')" != x ] ; then
        # runs once when screensaver comes on...
        /home/wf/ccminer/ccminer -a cryptonight -o stratum+tcp://cryptonight.eu.nicehash.com:3355 -u $wallet -p x &
        cd ~/xmr-stak/bin
        sudo /home/wf/xmr-stak/bin/xmr-stak --currency monero -o stratum+tcp://cryptonight.eu.nicehash.com:3355 -u $wallet -p x --noAMD &
    fi
    if [ x"$(echo "$line" | grep 'boolean false')" != x ] ; then
        # runs once when screensaver goes off...
        /usr/bin/pkill -9 ccminer
        sudo /usr/bin/pkill -9 xmr-stak
    fi
done