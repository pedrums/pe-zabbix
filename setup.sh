

BASE=/srv/zabbix


build_zbx () {

cd /srv/zabbix/src

./configure --enable-server --with-postgresql --with-net-snmp
}

select PB in init_postgres init_zabbix.yml  no
  do
	  break
done


[ "$PB" != "no" ] && ansible-playbook $HOME/github/pe-init/local/${PB}.yml

#### main

$1
##grep peweb /etc/php-fpm.d/www.conf
#user = peweb
#group = peweb

#find /var -user apache -exec chown peweb:peweb {} \;
