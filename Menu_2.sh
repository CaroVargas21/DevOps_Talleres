#!/bin/bash
while :
do
    # Limpiar pantalla
        clear    
    # Limpieaza de variab�es        
        unset choice
    # display menu
        echo "- --------------------------------- -"
        echo "-  Server Name: [$(hostname)]       -"
        echo "- --------------------------------- -"
        echo "-  1.Cambiar nombre Servidor       -"
        echo "- --------------------------------- -"       
        echo "-  2.Cambiar Particion Discos       -"               
        echo "- --------------------------------- -"
        echo "-  3.Cambiar IP Servidor            -"               
        echo "- --------------------------------- -"
        echo "-  4.Cambiar tabla de Host          -"               
        echo "- --------------------------------- -"
        echo "-  5.Agregar Permisos de Firewall   -"               
        echo "- --------------------------------- -"
        echo "-  6.Editar DNS Server              -"               
        echo "- --------------------------------- -"
        echo "-  7.Configurar proxy               -"
        echo "- --------------------------------- -"
        echo "-  8.Instalacion de docker          -"
        echo "- --------------------------------- -"     
        echo "-  E. Exit                          -"        
        echo "- --------------------------------- -"
         
    # get input from the user         
        read -p "Enter your choice [1-8] : " choice
    # get input from the user         
        case $choice in       
        1)  
        echo -e "\n----------------------------------------------------------------------------------------"
        echo "   Nombre Server Actual                :[$(hostname)] "
        read -p ">> Digite el nuevo Hostname EJ: [<NOMBRE>] : " hostname1
        echo -e "\n----------------------------------------------------------------------------------------"
        sudo hostnamectl set-hostname $hostname1
        echo "Verifique la variable [ preserve_hostname:  true ] en el archivo /etc/cloud/cloud.cfg   "
        
        echo "--------------------------------------------------------------------------------------"
        preser=$(grep preserve_hostname /etc/cloud/cloud.cfg)
        #echo ">> Resultado /etc/cloud/cloud.cfg: [ >> $preser << ]"
        echo ">> Nombre Server Actual: [$(hostname)] "
        echo "----------------------------- Fin del Script ------------------------------------------"
        read -p "Press [Enter] key to continue..." readEnterKey
        ;;
        2)  
        echo "------------------------------------------------------------------------------------------------------"
        echo "|Se listan las particiones del disco, con el fin que pueda evidenciar la particion que desea realizar |"
        echo "------------------------------------------------------------------------------------------------------"
        read -p "Press [Enter] key to continue..." readEnterKey
        sudo fdisk -l
        read -p "Inserte el nombre del disco que desea particionar EJ: [</dev/xvda>] " Disk
        read -p "Desea realizar la particion del disco \"$Disk\" (y/n)? " answer
        if [[ $answer =~ ^[Yy]$ ]]; then
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 1: Debe darle la opcion <n> para a�adir la nueva particion"
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 2: Debe seleccionar el numero de la particion que va a realizar"
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 3: Debe escoger el primer sector"
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 4: Debe escoger el ultimo sector"
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 5: Debe escoger el espacio del disco"
            echo "------------------------------------------------------------------------------------------------------"
            echo "paso 3: Debe insetar <q> si desea salir y no guardar y <w> si desea aplicar la partici�n permanente"
            echo "------------------------------------------------------------------------------------------------------"
            sudo fdisk $Disk
        fi
        if [[ $answer != ^[Yy]$ ]]
          then
            echo "----------------------"
            echo "Cambios no aplicados"
            echo "----------------------"
        fi
        echo "----------------------------- Fin del Script ------------------------------------------"
        ;;  
        3)
        echo "A continuacion vera las interfaces, la ip actual, etc.."
        echo "________________________________________________________________________________________"
        ifconfig
        echo "----------------------------------------------------------------------------------------"
        read -p "Digite el nombre de la interfaz EJ: [<eth0>]: " Interfaz
        read -p "Digite la nueva IP sin espacios, separada por puntos EJ: [<127.31.82.148>] : " IP
        read -p "Digite la mascara sin espacios, separada por puntos EJ: [<255.255.240.0>] : " Mask
        echo "La configuracion es :" "[IP: \"$IP\"]" "[Interfaz: \"$Interfaz\"]" "[Mascara: \"$Mask\"]" 
         echo "----------------------------------------------------------------------------------------"
        read -p "Desea aplicar los cambios de red (y/n)? " answer
        if [[ $answer =~ ^[Yy]$ ]]
          then
            sudo ifconfig $Interfaz $IP $Mask
        fi
          
        if [[ $answer != ^[Yy]$ ]]
          then
            echo "----------------------------------------------------------------------------------------"
            echo "Cambios no aplicados"
            echo "----------------------------------------------------------------------------------------"
        fi
        
        read -p "Press [Enter] key to continue..." readEnterKey
        ;;
        4)
        echo "--------------------------------------------------------------------------------------------------------------------------"
        echo "A continuacion podra editar en la tabla los host que necesite a�adir"
        echo "--------------------------------------------------------------------------------------------------------------------------"
        echo "Cuando abra el archivo debera insertar al final  la IP y el nombre de la siguiente namera : [<192.168.137.30 k8s-master>] "
        echo "--------------------------------------------------------------------------------------------------------------------------"
        echo -e "Para guadar los cambios debes <Ctrl + X> luego <Y> y <Enter>"
        echo "--------------------------------------------------------------------------------------------------------------------------"
        read -p "Press [Enter] key to continue..." readEnterKey
        sudo nano /etc/hosts
        echo "----------------------------- Fin del Script ------------------------------------------"
        read -p "Press [Enter] key to continue..." readEnterKey
        ;;
        
        5)
        InsFW=$(sudo apt install vsftpd)
        #sudo service vsftpd status
        echo "-------------------------------------------------------"
        echo "Si desea habilitar el Firewall escriba : FW1"
        echo "-------------------------------------------------------"
        echo "Si desea ver el estado del Firewall escriba : FW2"
        echo "-------------------------------------------------------"
        echo "Si desea habilitar puerto TCP escriba : FW3"
        echo "-------------------------------------------------------"
        echo "Si desea habilitar puerto UDP : FW4"
        echo "-------------------------------------------------------"
        echo "Si desea habilitar rango puerto TCP escriba : FW5"
        echo "-------------------------------------------------------"
        echo "Si desea habilitar rango puerto UDP escriba : FW6"
        echo "-------------------------------------------------------"
        echo "Si desea probar netstat escriba : FW7"
        echo "-------------------------------------------------------"
        echo "Si desea probar con curl escriba : FW8"
        echo "-------------------------------------------------------"
        read -p "Digite la interfaz : " F
        
        if [ "$F" == "FW1" ]; then
            sudo ufw enable
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW2" ]; then
            sudo ufw status
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        
        if [ "$F" == "FW3" ]; then
            read -p "Digite el puerto EJ: [<22>] : " PTCP
            sudo ufw allow $PTCP/tcp
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW4" ]; then
            read -p "Digite el puerto EJ: [<22>] : " PUDP
            sudo ufw allow $PUDP/udp
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW5" ]; then
            read -p "Digite el rango de puertos TCP EJ: [<30000 32767>] : " PTCP1 PTCP2
            sudo ufw allow $PTCP1:$PTCP2/tcp
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW6" ]; then
            read -p "Digite el rango de puertos UDP EJ: [<30000 32767>] : " PUDP1 PUDP2
            sudo ufw allow $PUDP1:$PUDP2/udp
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW7" ]; then
            read -p "Digite el puerto [<22>]: " P2
            netstat -an | grep $P2
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$F" == "FW8" ]; then
            read -p "Digite la IP y el puerto [<127.168.24.3 22>] : " IP1 P3
            curl -v telnet://$IP1:$P3
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        echo "----------------------------- Fin del Script ------------------------------------------"
        ;;
        6)
        Ins=$(sudo apt install resolvconf)
        echo "-------------------------------------------------------"
        echo "Si desea activar el DNS escriba : D1"
        echo "-------------------------------------------------------"
        echo "Si desea parar el DNS escriba : D2"
        echo "-------------------------------------------------------"
        echo "Si desea conocer el estado del DNS escriba : D3"
        echo "-------------------------------------------------------"
        echo "Si desea restaurar el DNS escriba : D4"
        echo "-------------------------------------------------------"
        echo "Si desea editar el DNS escriba EJ: [<nameserver 8.8.4.4>] : D5"
        echo "-------------------------------------------------------"
        
        read -p "Digite la interfaz : " D
        
        if [ "$D" == "D1" ]; then
            sudo service resolvconf start
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$D" == "D2" ]; then
            sudo service resolvconf stop
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$D" == "D3" ]; then
            Sta=$(sudo service resolvconf status)
            echo $Sta
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$D" == "D4" ]; then
            sudo service resolvconf restart
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if [ "$D" == "D5" ]; then
            sudo nano /etc/resolv.conf
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        if ["$D"!="D1"] || ["$D"!="D2"] || ["$D"!="D3"] || ["$D"!="D4"] || ["$D"!="D5"]; then
            echo "no es una opci�n aceptable"
            read -p "Press [Enter] key to continue..." readEnterKey
        fi
        echo "----------------------------- Fin del Script ------------------------------------------"
        read -p "Press [Enter] key to continue..." readEnterKey
        ;;
        7)
        echo "A continuacion podra modificar la tabla de proxy"
        echo "Ubique la seccion ## CONFIGURACION DEL PROXY ## e inserte los parametros solicitados"
        
        echo "- --------------------------------- ---------"
        echo " Ejemplo:                                    "
        echo "- --------------------------------- ---------"
        echo "-  1. HTTP_PROXY="10..236.50.83:8080"        "
        echo "- --------------------------------- ---------"       
        echo "-  2. HTTPS_PROXY=" 10..236.50.83:8080 "      "               
        echo "- --------------------------------- ---------"
        echo "-  3. FTP_PROXY=" 10..236.50.83:8080 "       -"               
        echo "- --------------------------------- ---------"
        echo "-  4. NO_PROXY="localhost, 127.0.0.1, "      -"               
        echo "- --------------------------------- ---------"
        
        echo -e "Para guadar los cambios debes <Ctrl + X> luego <Y> y <Enter>"
        read -p "Press [Enter] key to continue..." readEnterKey
        cd /home/ubuntu ; sudo nano .bashrc
        echo "----------------------------- Fin del Script ------------------------------------------"
        ;;
        8)
        echo "-----------------------------------------------------------------------------"
        echo "Instalar docker-compose"
        echo "-----------------------------------------------------------------------------"
        sudo apt-get update
        sudo apt-get install curl
        sudo apt-get install gnupg
        sudo apt-get install ca-certificates
        sudo apt-get install lsb-release
        sudo apt-get install docker-compose-plugin
        sudo docker-compose --version
        read -p "Press [Enter] key to continue..." readEnterKey
        
        sudo apt-get update
        read -p "Press [Enter] key to continue..." readEnterKey
        sudo apt-get install docker.io
        read -p "Press [Enter] key to continue..." readEnterKey
        
        sudo mkdir -p /etc/apt/keyrings 
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs)         stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        read -p "Press [Enter] key to continue..." readEnterKey
        

        echo "-----------------------------------------------------------------------------"
        echo "Instalar docker ce"
        echo "-----------------------------------------------------------------------------"
        sudo apt-get install docker-ce  
        sudo apt-get install docker-ce-cli
        sudo apt-get install containerd.io
        sudo apt-get install docker-compose
        sudo apt-get install docker-compose-plugin
        echo "-----------------------------------------------------------------------------"
        echo "Verificar Version"
        echo "-----------------------------------------------------------------------------"
        docker --version
        echo "-----------------------------------------------------------------------------"
        echo "Iniciar docker con el sistema"
        echo "-----------------------------------------------------------------------------"
        sudo systemctl enable docker
        sudo systemctl start docker
        user=$(whoami)
        sudo usermod -G docker $user
        grep $user /etc/group
        echo "-----------------------------------------------------------------------------"
        echo "folder docker"
        echo "-----------------------------------------------------------------------------"
        folder=/Images
        sudo mkdir -p $folder/$user
        sudo mkdir -p $folder/$user/Data
        sudo chown -R $user:$user $folder/$user
        sudo chown -R $user:$user $folder/$user/Data
        echo "----------------------------- Fin del Script ------------------------------------------"
        ;;
        E)                
        echo "Gracias!"
        exit 0
        ;;
        *)
        echo "Error: Invalid option..."	
        read -p "Press [Enter] key to continue..." readEnterKey
        ;;
        esac
done