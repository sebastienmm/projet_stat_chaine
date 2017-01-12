#!/bin/bash

fichier_texte=$1

verif_exist_param1(){

if [ -z $fichier_texte ]
then		
	read -p " Entrez un fichier texte à analiser pour effectuer une statistique :" $fichier_texte 
else
	echo ' le paramètre $1 est renseigné '
	
fi

}
verif_exist_fichier(){

	if [ -e $fichier_texte ]
	then
		echo " Le fichier existe,nous pouvons continuez "
	else
		verif_exist_param1
		verif_exist_fichier
	fi
}
