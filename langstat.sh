#!/bin/bash

#stockage des deux paramètres $1 et $2 dans deux variables
fichier_texte=$1
lettre_alpha=$2

# Ce script comprend 6 fonctions les trois premières répondent à la mission 1 et les trois suivantes à la mission 2
# La mission 1 permet de compter le nombre de mots utilisant chaque lettre de l'alphabet
# La mission 2 permet de rechercher les palindromes ( mots pouvant se lire dans les deux sens exemple: rotor) dans un texte


# Si la chaine de caractère est vide alors la commande read-p demande de renseigner cette variable puis rappelle la même fonctionjusqu'à ce que la variable soit renseignée 
verif_exist_param1(){      # fonction récursive

	if [ -z $fichier_texte ]
	then		
		read -p " Entrez un fichier texte à analyser pour effectuer une statistique :" $fichier_texte
		verif_exist_param1                                                       
	else
		echo ' le paramètre $1 est renseigné '
	
	fi

}


# Cette fonction vérifie si la chaine de caractère représente bien un fichier existant
verif_exist_fichier(){  # c'est aussi une fonction récursive

	if [ -e $fichier_texte ] && [ -f $fichier_texte ]
	then
		echo " Le fichier existe,nous pouvons continuez "
	else
		read  -p " Le fichier $fichier_texte n'existe pas veuillez entrez un autre nom :" fichier_texte 
		verif_exist_fichier
	fi
}


# En utilisant la commande grep on recherche les lignes dans lesquelles une lettre est présente puis on compte le nombre de ligne avec la commande wc et l'option -l
# l'option -i de grep permet d'ignorer la casse 
# le résultat est stocké dans le fichier stat.txt créé pour l'occasion
recherche_nombre_mots(){
	for lettre in {A..Z}	# Cette écriture permet d'énumerer toutes les lettres de l'alphabet
	do
		echo "$(grep -i $lettre $fichier_texte | wc -l) - $lettre" >> stat.txt   
	done
	sort -n -r stat.txt
}

# fonction donnant tous les palindromes présents dans un texte
# mot_trie=$(sed 's/ /\n/g' $fichier_texte | grep -i "\<$lettre_alpha"  | sed 's/[\r]*$//' )

palindrome_complet(){

	compt=0

	for lettre_alpha in {A..Z}
	do
		mot_trie=$(sed 's/ /\n/g' $fichier_texte | grep -i "\<$lettre_alpha"  | sed 's/[\r]*$//' )
		echo -e " Pour la lettre $lettre_alpha " >> palindrome.txt
	
		for mot in $mot_trie
		do	
			tom=$(echo "$mot" | rev)
	 
			if [ $mot = $tom ]
			then
				echo  "$mot" >> palindrome.txt
			fi
			compt=$((compt + 1))
			
		done
	
		echo " Le nombre de mots analysés est $compt "
		echo  "  " >> palindrome.txt
	done

	chaine=$(cat palindrome.txt)

	if [ -n "$chaine" ]
	then
		echo -e " La liste des palindromes du texte sont :\n $chaine "
	else
		echo -e " Il n\'y a pas de palindrome dans ce texte "
	fi
}


palindrome_lettre(){

	compt=0

	mot_trie=$(sed 's/ /\n/g' $fichier_texte | grep -i "\<$lettre_alpha"  | sed 's/[\r]*$//' )
	echo -e " Pour la lettre $lettre_alpha " >> palindrome.txt
	for mot in $mot_trie
	do	
		tom=$(echo "$mot" | rev)
		 
		if [ $mot = $tom ]
		then
			echo  "$mot" >> palindrome.txt
		fi
		compt=$((compt + 1))
		echo "$compt"
	done

	echo  "  " >> palindrome.txt


	chaine=$(cat palindrome.txt)
	if [ -n "$chaine" ]
	then
		echo -e " La liste des palindromes du texte sont :\n $chaine "
	else
		echo -e " Il n\'y a pas de palindrome dans ce texte "
	fi
}


# Cette fonction permet de vérifier si le paramètre 2 est renseigné, ce paramètre correspond à la première lettre des palindromes recherchés
# Si ce paramètre n'est pas renseigné alors la recherche se fera sur toutes les lettres de l'alphabet, dans le cas contraire seul les palindromes
# commençant par la ou les lettres renseignées seront recherchés.
verif_exist_param2(){
	if [ -z $lettre_alpha ]
	then 
		palindrome_complet
	else
		palindrome_lettre
	fi		
}

# Appel des différentes fonctions,
# pour tester les fonctions les unes après les autres vous pouvez les commenter.

verif_exist_param1
verif_exist_fichier
recherche_nombre_mots
verif_exist_param2

