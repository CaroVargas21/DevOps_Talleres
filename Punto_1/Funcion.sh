#!/bin/bash
path=/home/ubuntu/Repositorios/DevOps_Talleres/Punto_1/entrada.in
while IFS= read -r line
do
    echo "$line"
    touch "$line"
done < $path
echo "-----------------------------------------------------------------"
echo "     Archivos listados : "
echo "-----------------------------------------------------------------"
ls Arc*.txt >salida_out.txt | cat -b salida_out.txt
echo "-----------------------------------------------------------------"

