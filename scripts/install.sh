#!/bin/bash


# Install script to provision server

curUser=$(whoami)
if [[ $curUser=="vagrant" ]]
then
    # The next two lines set up vagrant to always log you in to the shared
    # directory so that your work is easily visible/accessible from the host.
    cd /vagrant
    echo "cd /vagrant" | sudo tee -a ~vagrant/.profile
else
    # If you are actually deploying this on a server somewhere, then here is
    # where you should set up the server directories
    echo "Not implemented"
fi

# OS
sudo apt-get update

# Tools
sudo apt-get -y install build-essential # g++, make, etc.
sudo apt-get -y install git curl

# MySQL
mysqlTempPass="foo"
sudo DEBIAN_FRONTEND=noninteractive apt-get -q -y install mysql-server
mysqladmin -u root password $mysqlTempPass
sudo mysql -u root --password=$mysqlTempPass < ./scripts/mysql/schema.sql

# Python, Bottle, and PyMySQL
sudo apt-get -y install python3-setuptools
sudo apt-get -y install python3-dev
wget http://bottlepy.org/bottle.py
mv bottle.py src/
curl -L https://github.com/PyMySQL/PyMySQL/tarball/pymysql-0.6 | tar xz
cd PyMy*
sudo python3 setup.py install
if [ -e $(python3 -c "import pymysql")]
then
    echo "running PyMySQL tests"
    cp ../scripts/testpymysql.json pymysql/tests/databases.json
    python3 runtests.py
    cd ..
    rm -rf PyMy*
fi


