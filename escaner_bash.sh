#!/bin/bash

#port=('21' '22' '80' '443' '8080') ##AQUI TENIA PUERTOS ESPECIFICOS
echo -n "dame una IP: "
read ip
fecha=$(date)

function scan(){
    for i in $ip
    do
        #for port in ${port[@]} ##USABA LA VARIABLE PUERTOS CON PUERTOS ESPECIFICOS
        for port in {1..10000} ##CAMBIE A RANGOS DE PUERTOS
        do 
            timeout 2 bash -c "</dev/tcp/$ip/$port &>/dev/null" && echo "puerto $port abierto" 
        done > scan.txt
    done
}

r=$(scan)
echo $r

function print(){
    echo "EIPMap desarrollado por el estudiante Xavie J. Sierra Moreu"
    echo "Hora de ejecución: $fecha"
    echo "[*] Escaneo de puertos sobre la IP: '$ip' en proceso:"
    while read linea
    do
        echo -e "\t[+] $linea"
    done < scan.txt    
}
imprimir=$(print)
echo -e "$imprimir"

function csv(){
    cat scan.txt | tr -s '[:blank:]' ',' > $ip.txt
}
csv
