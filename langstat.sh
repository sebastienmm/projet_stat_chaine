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

	if [ -e $fichier_texte ] && [ -f $fichier_texte ]
	then
		echo " Le fichier existe,nous pouvons continuez "
	else
		read  -p " Le fichier $fichier_texte n'existe pas veuillez entrez un autre nom :" fichier_texte 
		verif_exist_fichier
	fi
}
verif_exist_param1
verif_exist_fichier

recherche_nombre_mots(){
	for lettre in {A..Z}	
	do
		echo "$(grep $lettre $fichier_texte | wc -l) - $lettre" >> stat.txt
	done
	sort -n -r stat.txt
}
recherche_nombre_mots
