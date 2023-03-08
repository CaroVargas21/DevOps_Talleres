#!/bin/bash
    clear
    
#####################################################################################################
# Seccion 1: Variables
#####################################################################################################
    
    #source  /pushGit.sh
    artifact=$1
    

#####################################################################################################
# Seccion 2: Ayuda
#####################################################################################################
    
     #Ayuda de Shell
     
  if [[ $artifact == "-h" ]]; then 
    
      echo ' -----------------------------------------------------------------------------------------------------------------------'
      echo ' EJemplo de como debe ejecutar el pushGit.sh                                                                                                              '
      echo ' -----------------------------------------------------------------------------------------------------------------------'
      echo ' # Ir a la carpeta de de PerfilCaro                                                                                     '
      echo ' # cd /Repositorios/PerfilCaro/                                                                                         '
      echo ' # Ejecutar la shell con el comentario y la rama                                                                        '
      echo ' # ./pushGit.sh "Comentario......" "Nombre de la rama"                                                                  '
      echo ' -----------------------------------------------------------------------------------------------------------------------'
      exit 0
  
  fi
  #Ayuda de Shell Orquestador
  if [[ -z $comment ]] || [[ -z $rama ]]; then # Si no se envia carpeta de repositorio de la aplicacion
      echo  '---------------------------------------------------------------------'
      echo  ' >>> Requiere parametros. recomendamos usar la ayuda  >>>>           '
      echo  ' >>> [ ./VariablesVacias.sh -h ] >>>>                          '
      echo  '---------------------------------------------------------------------'
      exit 1
  fi
  read -p "Press [Enter] key to continue..." readEnterKey


