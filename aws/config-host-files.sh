#/bin/bash

# while getopts :newname:pub:priv: option
OPTS=`getopt -o npqh --long newname:,pub:,priv:,hostfile: -n 'config-host-files'  -- "$@"`

if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

echo
echo "These are the options being passed: ${OPTS}"
echo

eval set -- "${OPTS}"

while true; do
    case "$1"
    in
        --newname ) NEWNAME=$2 ; shift 2 ;;
        --pub ) PUBIP=$2 ; shift 2 ;;
        --priv ) PRIVIP=$2 ; shift 2 ;;
        --hostfile ) HOSTFILE=$2 ; shift 2 ;;
	-- ) shift; break ;; 
    esac
done

echo
echo "New internal hostname is: ${NEWNAME}"
echo "New public IP is: ${PUBIP}"
echo "New private IP is: ${PRIVIP}"
echo

# sub out the new internal hostname for the old one.
sed "s/ip-.*/${NEWNAME}/" ${HOSTFILE}
