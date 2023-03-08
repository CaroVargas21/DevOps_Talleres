#!/bin/bash
path=/home/ubuntu/Repositorios/DevOps_Talleres/Punto_1/entrada.in


echo "--------------------"
while IFS= read -r line
do
    if [[ "$line" =~ [1-2] ]]
    then
       $(rm "$line")
       echo $line
    fi
  
done < $path  #grep -E '1|3'| rm "$line"


echo "---------------------------------------------------"

ls Ar*.txt >salida_out2.txt
echo "---------------------------------------------------"
echo "Los archivos que quedaron en la salida_out2 son:"
echo "---------------------------------------------------"
cat salida_out2.txt
echo "---------------------------------------------------"

#echo "$IFS"

#del=$(find . -maxdepth 1 -name "*1*" -print )

#del=$(grep -E '1|3' salida_out.txt)
#echo $del