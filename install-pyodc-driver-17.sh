#!/bin/bash -x

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

#Download appropriate package for the OS version
#Choose only ONE of the following, corresponding to your OS version
if [[ `awk -F " " '{ print $1 }' /etc/issue` == "Ubuntu" ]] ; then
	version=`awk -F " " '{ print $2 }' /etc/issue`
	curl https://packages.microsoft.com/config/ubuntu/${version:0:5}/prod.list > /etc/apt/sources.list.d/mssql-release.list
else
	echo "Operating system not ubuntu bye ..."
	exit 1
fi

apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17
# optional: for bcp and sqlcmd
ACCEPT_EULA=Y apt-get install -y mssql-tools
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
apt-get install -y unixodbc-dev
