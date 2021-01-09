

BASE=/srv/zabbix

init_user () {
groupadd --system zabbix
useradd --system -g zabbix -d $BASE -s /sbin/nologin -c "Zabbix Monitoring System" zabbix

for D in lib etc var bin  db
 do
  mkdir -p $BASE/$D
done

chown -R zabbix:zabbix  $BASE

}

download () {

mkdir $BASE/src
cd $BASE/src
wget -O zabbix.zip https://git.zabbix.com/rest/api/latest/projects/ZBX/repos/zabbix/archive?format=zip
unzip zabbix.zip

}

init_db () {
install -y postgresql
dnf module reset postgresql
dnf module enable postgresql:12
dnf install postgresql-server
postgresql-setup --initdb
systemctl enable postgresql
systemctl start postgresql

}



#### main

$1
