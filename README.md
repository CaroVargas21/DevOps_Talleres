# Talleres DevOps

Hay dos shell que se usan siempre que quiera subir algun cambio al repositorio
### > pushGit.sh
Para subir los documentos debe ejecutar :
```bash

./pushGit.sh "Comentario ... " "La rama donde lo desea subir"

```
La shell ./VariablesVacias.sh es la que valida que las variables de arriba contengan un valor y no estén vacias.

```bash

#/bin/bash
clear

# set variables y la shell dependiente
comment=$1
rama=$2
source ./VariablesVacias.sh

```
Se deben configurar el usuario, el email y el *core.autocrlf* es falso si deseo seguir manteniendo en Linux, si desea que se pasen a Windows deberá poner True.
```bash
#Las credenciales para acceder
git config --global user.email "car.esvargas@gmail.com"
git config --global user.name "CaroVargas21"
git config --global core.autocrlf false
```
Se le da la opción de clonar el repositorio, para esto debe escribir *Y* sino, puede darle cualquier otra letra

```bash
# Ejecucion

  read -p "Desea clonar el repositorio? escriba [<Y>] si es asi : " clone
  if [[ $clone =~ ^[Yy]$ ]]
  then
    git clone git@github.com:CaroVargas21/DevOps_Talleres.git
  fi
``` 
Si desea hacer un tag debe escribir *Y*, si no lo desea puede escribir cualquier otra letra, además se le confirma si en la rama que escogió es donde desea realizar el tag, luego se crea, actualiza y se lista el tag.
```bash
  read -p "Desea tagear? si es asi marque [<Y>] : " tag

  if [[ $tag =~ ^[Yy]$ ]]; then
    echo "Te encuentras parado sobre la rama"; git status
    read -p "Desea seguir en esta rama? si es as□ marque [<Y>] : " ramis
    if [[ $ramis =~ ^[Yy]$ ]]; then
      read -p "Escriba la nomenclatura del tag EJ: (v1.0) : " version
      git tag "$version" #vp min master
      read -p "Press [Enter] key to continue..." readEnterKey
      git pull --tags #Actualizar
            git tag -l #listar
      read -p "Press [Enter] key to continue..." readEnterKey
      git push origin "$version"
      git pull
      read -p "Press [Enter] key to continue..." readEnterKey
    fi
  fi
  ``` 
Esta parte del código se utiliza para hacer el push, lee el comentario y la rama que coloca cuando manda a ejecutar la shell, pasa a la rama que edito por si se encontraba en otra, le muestra en que estado esta y hace el commit y finaliza el script
  ```bash 
  
  echo "comment [$comment] | rama [$rama]"
  echo "inicia carga en git"
  #Para que vaya a la rama donde voy a subir
  git checkout $rama
  read -p "Press [Enter] key to continue..." readEnterKey
  git status
  read -p "Press [Enter] key to continue..." readEnterKey

  git add .
  read -p "Press [Enter] key to continue..." readEnterKey

  git commit -m "$comment"
  read -p "Press [Enter] key to continue..." readEnterKey

  git push origin $rama
  echo -e "\n----- Fin del Script -----------------------------------------------------------"
  read -p "Press [Enter] key to continue..." readEnterKey

``` 
### > VariablesVacias.sh
Esta shell valida si los valores de comentario y rama estan vacios y brinda un ejemplo de como debe ejecutar la shell anterior.
```bash 

#!/bin/bash
    clear

#####################################################################################################
# Seccion 1: Variables
#####################################################################################################

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
  
```


