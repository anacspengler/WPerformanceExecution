#!/bin/bash

run_caliper(){
    npm init -y
    npm install --only=prod @hyperledger/caliper-cli@0.3.2
    npx caliper bind --caliper-bind-sut fabric:1.4.1
}
solo_config(){
    rm -rf networks/fabric/config_solo/mychannel.tx
    tar -zxvf networks/fabric/config_solo/hyperledger-fabric-linux-amd64-1.4.1.tar.gz
    sh networks/fabric/config_solo/generate.sh
}
#atualizar imagens do docker
image_update(){
    docker pull hyperledger/fabric-ccenv:1.4.1
    docker tag hyperledger/fabric-ccenv:1.4.1 hyperledger/fabric-ccenv:latest
}

#menu
clear
while true; do
echo "#========================================================#
       Digite o número do componente a ser instalado:
        1 - Caliper
	2 - Config Solo
	3 - Docker Images Update
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

    1) run_caliper ;;

    2) solo_config ;; 
    
    0)
        echo "Saindo Do Script de Instalação Caliper"
        exit;;
    *)
        echo
        echo "ERRO: opção inválida"
        echo ;;
esac
done
