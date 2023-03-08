#!/bin/bash
path5=/home/ubuntu/Repositorios/DevOps_Talleres/Punto_1/salida_out2.txt

while IFS= read -r line ext
do
    touch "$line$ext-mv.txt"
    
done < $path5
ls Ar*.txt >salida_out3.txt

echo "-------------------------------------------------------"
echo "Los archivos que quedaron en la salida_out3 son:"
echo "-------------------------------------------------------"
find . -maxdepth 1 -name "*-*" -print
echo "-------------------------------------------------------"