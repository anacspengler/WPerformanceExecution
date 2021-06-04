#!/bin/bash

# verifica se o usuário tem privilégio de root
if [ ${USER} != "root" ]; then
   echo "[ERROR] Voce não tem os privilegios necessarios para executar esse script!" &&
    exit
fi

install_curl(){
	apt install curl
}

install_golang(){
   apt add-apt-repository ppa:longsleep/golang-backports
   apt update
   apt install golang-go
}

install_node(){
   curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
   apt install nodejs
}

install_python(){
   apt install python
}

install_docker(){
   apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   add-apt-repository \
      "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) \
      stable"
   apt-get update
   apt-get install docker-ce docker-ce-cli containerd.io
}

install_dockercompose(){
   curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   chmod +x /usr/local/bin/docker-compose
}

group_add_docker(){
   groupadd docker
   usermod -aG docker $USER
}

#menu
clear
while true; do
echo "#========================================================#
       Digite o número do componente a ser instalado:
        1 - Curl
	2 - Go lang
        3 - Nodejs
        4 - Python
        5 - Docker
        6 - Docker Compose
	7 - Docker groupadd
        0 - Sair
#=========================================================#"
echo -n "->OPÇÃO:  "

read opcao

#Verificar se foi digitada uma opcao
if [ -z $opcao ]; then
    echo "ERRO: Digite uma opcao"
    exit
fi

case $opcao in

    1) install_curl ;;

    2) install_golang ;; 
        
    3) install_node ;;
        
    4) install_python ;;      
    
    5) install_docker ;;
        
    6) install_dockercompose ;;
    
    7) group_add_docker ;;
    
    0)
        echo "Saindo Do Script de Instalação"
        exit;;
    *)
        echo
        echo "ERRO: opção inválida"
        echo ;;
esac
done

