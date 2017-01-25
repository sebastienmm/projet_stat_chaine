#!/bin/bash

fichier_analyse=$2

palindrome(){
compt=0
for lettre in {A..Z}
do
mot_trie=$(sed 's/ /\n/g' $fichier_analyse | grep -i "\<$lettre"  | sed 's/[\r]*$//' )
echo -e " Pour la lettre $lettre " >> palindrome.txt
	for mot in $mot_trie
	do	
			tom=$(echo "$mot" | rev)
			#echo "$tom"
		 
			if [ $mot = $tom ]
			then
				#echo "$mot"
				echo  "$mot" >> palindrome.txt
			fi
			compt=$((compt + 1))
			echo "$compt"
	done
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

palindrome

