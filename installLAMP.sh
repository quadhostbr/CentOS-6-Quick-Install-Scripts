#!/bin/bash

clear

echo 'Preparando para instalar o LAMP em sua maquina, aqui vamos nos ...'
echo '------------------------'
read -p "Senha para o MySQL: " mysqlPassword
read -p "Repita a senha: " mysqlPasswordRetype

yum install -y httpd php mysql mysql-server

chkconfig mysqld on
chkconfig httpd on

/etc/init.d/mysqld restart

while [[ "$mysqlPassword" = "" && "$mysqlPassword" != "$mysqlPasswordRetype" ]]; do
  echo -n "Por favor, informe uma senha para o usuario root do MySQL: "
  stty -echo
  read -r mysqlPassword
  echo
  echo -n "Repita a senha: "
  read -r mysqlPasswordRetype
  stty echo
  echo
  if [ "$mysqlPassword" != "$mysqlPasswordRetype" ]; then
    echo "As senhas nao coincidem!"
  fi
done

/usr/bin/mysqladmin -u root password $mysqlPassword


clear
echo 'Ok.... apache, php e mysql esta instalado e em execucao.'
echo 'Senha do usuario root MySQL:' $mysqlPassword 
