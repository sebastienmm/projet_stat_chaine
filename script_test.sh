#!/bin/bash

texte=`cat texte_test.txt`
echo "$texte"

for mot in $texte
do
		tom=`echo $mot | rev`
		
		 
		if [ $mot = $tom ]
		then
			echo " $mot " >> palindrome.txt
		fi
done


chaine=`cat palindrome.txt`
if [ -n chaine ]
then
	echo -e " La liste des palindromes du texte sont :\n $chaine "
else
	echo -e " Il n\'y a pas e palindrome dans ce texte "
fi


