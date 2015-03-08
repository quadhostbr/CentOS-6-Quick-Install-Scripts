#!/bin/bash

clear

echo 'Preparando para instalar o LAMP em sua máquina, aqui vamos nós ...'
echo '------------------------'
read -p "Senha para o MySQL: " mysqlPassword
read -p "Repita a senha: " mysqlPasswordRetype

yum install -y httpd php mysql mysql-server

chkconfig mysql-server on
chkconfig httpd on

/etc/init.d/mysqld restart

while [[ "$mysqlPassword" = "" && "$mysqlPassword" != "$mysqlPasswordRetype" ]]; do
  echo -n "Por favor, informe uma senha para o usuário root do MySQL: "
  stty -echo
  read -r mysqlPassword
  echo
  echo -n "Repita a senha: "
  read -r mysqlPasswordRetype
  stty echo
  echo
  if [ "$mysqlPassword" != "$mysqlPasswordRetype" ]; then
    echo "As senhas não coincidem!"
  fi
done

/usr/bin/mysqladmin -u root password $mysqlPassword


clear
echo 'Ok.... apache, php e mysql está instalado, em execução.'
echo 'Senha do usuário root MySQL:' $mysqlPassword 
