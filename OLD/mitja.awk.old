#Inicialitzem variables
BEGIN {var=0; total=0; sum=0;}
#Descartem la primera linea
{if(NR==1){getline}
#Recuperem el valor sense el caracter %
sum=substr($2,1,length($2)-1)
total=total+sum}
#Retornem la suma dels valor dividit per el num de registres menys
#la primera linia
END {print total/(NR-1)}
