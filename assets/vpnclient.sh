#/bin/bash
spath=/usr/local/softether/vpnclient

vpnclient=$spath/vpnclient
vpncmd=$spath/vpncmd

LOCK=/var/lock/subsys/vpnclient

function vpnstart {
  echo "$vpnclient $vpncmd"
  $vpnclient start
  touch $LOCK
  conn=`$vpncmd localhost /CLIENT /CMD AccountList | grep "Setting Name" | sed "s/.*|//" | head -n 1`
  adapt=`$vpncmd localhost /CLIENT /CMD AccountList | grep "Adapter Name" | sed "s/.*|//" | head -n 1`
  
  if [[ "$conn" == "" || "$adapt" == "" ]]
  then
    echo "VPN Account not created or isn't correct"
    exit 2
  fi
  $vpncmd localhost /CLIENT /CMD AccountConnect $conn
  dhclient vpn_$adapt
}

function vpnstop {
  $vpnclient stop
  rm $LOCK
}

case "$1" in
start)
  vpnstart
;;
stop)
  vpnstop
;;
restart)
  vpnstop
  sleep 3
  vpnstart
;;
*)
  echo "Usage: $0 {start|stop|restart}"
  exit 1
esac
