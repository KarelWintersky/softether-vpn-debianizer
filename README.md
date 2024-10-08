# Build

Download TAR.GZ archive with prebuild code from https://www.softether-download.com/en.aspx
for example:

```
wget https://www.softether-download.com/files/softether/v4.43-9799-beta-2023.08.31-tree/Linux/SoftEther_VPN_Client/64bit_-_Intel_x64_or_AMD64/softether-vpnclient-v4.43-9799-beta-2023.08.31-linux-x64-64bit.tar.gz -O client.tar.gz
```

Unpack it:
```
tar -xzf client.tar.gz
```


Be sure that the software required for assembly is installed.
... for this you can run:

```
sudo make prepare
```

If you need update version of target package, run:

```
make dchv
```

Set new version, update chagelog:

```
make dchr
```

Set version from unreleased to (un)stable.

Then, run:
```
make build
```
Package will be placed at `../` directory

Done! you are great!

# Pre-reqs

```
apt-get -y install isc-dhcp-client openssl ncurses-base
```

# Other

## Download links:

https://www.softether-download.com/en.aspx

## Alternatives:

https://launchpad.net/~paskal-07
https://launchpad.net/~paskal-07/+archive/ubuntu/softethervpn-nightly
https://launchpad.net/~paskal-07/+archive/ubuntu/softethervpn
https://github.com/paskal


## Статик или динамик билд?

https://github.com/SoftEtherVPN/SoftEtherVPN/pull/757

https://github.com/SoftEtherVPN/SoftEtherVPN/issues/760
