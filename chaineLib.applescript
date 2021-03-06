---------------------------------------------------------------------------------------------------------------------------
-- Nom du fichier :    ChaineLib.applescript
---------------------------------------------------------------------------------------------------------------------------
-- Description      :    Bibliothèque AppleScript pour manipuler des chaînes de caractères
---------------------------------------------------------------------------------------------------------------------------
-- Remarques      :
--				    - À enregistrer sous le format "Script" (.scpt)
--				    - À copier dans le dossier ~/Library/Script Libraries/ pour être utilisable ailleurs
--				    - testé sur Mac OS X 10.12.6 (voir la section TESTS plus bas)
---------------------------------------------------------------------------------------------------------------------------



(*
Nom			: majuscule 
Description	: Mets les caractères de la chaîne spécifiée en majuscules
chaine		: chaîne à mettre en majuscules
retour		: la chaîne en majuscules
*)
on majuscule(chaine)
	set uc to "ÆŒÄÅÇÉÑÖÜÀÃÕŸÂÊÁËÈÍÎÏÌÓÔÒÚÛÙABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set lc to "æœäåçéñöüàãõÿâêáëèíîïìóôòúûùabcdefghijklmnopqrstuvwxyz"
	repeat with i from 1 to 54
		set AppleScript's text item delimiters to character i of lc
		set chaine to text items of chaine
		set AppleScript's text item delimiters to character i of uc
		set chaine to chaine as text
	end repeat
	set AppleScript's text item delimiters to ""
	return chaine
end majuscule


(*
Nom			: minuscule 
Description	: Mets les caractères de la chaîne spécifiée en minuscules
chaine		: chaîne à mettre en minuscules
retour		: la chaîne en minuscules
*)
on minuscule(chaine)
	set uc to "ÆŒÄÅÇÉÑÖÜÀÃÕŸÂÊÁËÈÍÎÏÌÓÔÒÚÛÙABCDEFGHIJKLMNOPQRSTUVWXYZ"
	set lc to "æœäåçéñöüàãõÿâêáëèíîïìóôòúûùabcdefghijklmnopqrstuvwxyz"
	repeat with i from 1 to 54
		set AppleScript's text item delimiters to character i of uc
		set chaine to text items of chaine
		set AppleScript's text item delimiters to character i of lc
		set chaine to chaine as text
	end repeat
	set AppleScript's text item delimiters to ""
	return chaine
end minuscule


(*
Nom			: sousChaine
Description	: Récupère le texte entre les bornes spécifiées
chaine		: chaine à utiliser
debut		: l'indice de début du texte dans la chaîne (doit être >=1)
fin			: l'indice de fin du texte dans la chaîne (doit être <= longueur de la chaîne)
retour		: la sous-chaîne entre les bornes spécifiées ou la chaîne si les bornes sont incorrectes
Remarque 	: 
		   Il est possible de récupérer une sous-chaîne en partant de la fin. Il suffit de donner des valeurs négatives.
		  ex: sub_string(maPhrase, -1, -9) récupère les 9 derniers caractères de la chaîne maPhrase
*)
on sousChaine(chaine, debut, fin)
	try
		return (text (debut) thru (fin) of chaine)
	on error
		return chaine
	end try
end sousChaine



(*
Nom			: supprimeCaractere
Description	: Supprime le caractère spécifié de la chaine passée en paramètres
chaine		: chaine à modifier
caractere		: le caractère à supprimer
retour		: la chaîne sans le caractère
*)
on supprimeCaractere(chaine, caractere)
	set nouvelleChaine to ""
	
	repeat with i from 1 to the length of the chaine
		set unCaractere to character i of chaine
		-- log my_char
		if unCaractere is not equal to caractere then
			set nouvelleChaine to nouvelleChaine & unCaractere
		end if
	end repeat
	return nouvelleChaine
end supprimeCaractere

(*
Nom			: supprimeCaractere2
Description	: Supprime le caractère spécifié de la chaine passée en paramètres
chaine		: chaine à modifier
caractere		: le caractère à supprimer
retour		: la chaîne sans le caractère
*)
on supprimeCaractere2(chaine, caractere)
	set prevTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to caractere
	set s to text items of chaine
	set AppleScript's text item delimiters to ""
	set s to s as text
	set AppleScript's text item delimiters to prevTIDs
	
	return s
end supprimeCaractere2

(*
Nom			: supprimeLesEspaces
Description	: Une fonction pour supprimer tous les espaces dans une chaîne de caractères
chaine		: le texte contenant des espaces à supprimer
retour		: le texte sans les espaces
Remarque	: l'espace n'est pas toujours le séparateur d'un mot. A voir ...
*)
on supprimeLesEspaces(chaine)
	set listeDeMots to every word of chaine
	set nouvelleChaine to listeDeMots as text
	return nouvelleChaine
end supprimeLesEspaces


(*
Nom				: remplaceCaractere
Description		: Remplace le caractère spécifié de la chaine passée en paramètres par un autre
chaine			: chaine à modifier
ancienCaractere	: le caractère à remplacer
nouveauCaractere	: le nouveau caractère 
retour 			: la chaîne modifiée
*)
on remplaceCaractere(chaine, ancienCaractere, nouveauCaractere)
	set nouvelleChaine to ""
	
	repeat with i from 1 to the length of the chaine
		set unCaractere to character i of chaine
		-- log my_char
		if unCaractere is equal to ancienCaractere then
			set nouvelleChaine to nouvelleChaine & nouveauCaractere
		else
			set nouvelleChaine to nouvelleChaine & unCaractere
		end if
	end repeat
	return nouvelleChaine
end remplaceCaractere



(*
Remplace le caractère spécifié de la chaine passée en paramètres par un autre
this_text : chaine à modifier
old_char : le caractère à remplacer
new_char: le nouveau caractère 
retour : la chaîne modifiée
*)
on replace_char2(this_text, old_char, new_char)
	set prevTIDs to AppleScript's text item delimiters
	set AppleScript's text item delimiters to old_char
	set s to text items of this_text
	set AppleScript's text item delimiters to new_char
	set s to s as text
	set AppleScript's text item delimiters to prevTIDs
	
	return s
end replace_char2



(*
Nom			: contientAccent
Description	: Détermine si la chaîne contient au moins un accent.
chaine		: chaine à tester
return		: le premier accent trouvé ou une chaîne vide.
*)
on contientAccent(chaine)
	
	set accents to {"à", "á", "â", "ã", "ä", "ç", "è", "é", "ê", "ë", "ì", "í", "î", "ï", "ñ", "ò", "ó", "ô", "õ", "ö", "ù", "ú", "û", "ü", "ý", "ÿ", "À", "Á", "Â", "Ã", "Ä", "Ç", "È", "É", "Ê", "Ë", "Ì", "Í", "Î", "Ï", "Ñ", "Ò", "Ó", "Ô", "Õ", "Ö", "Ù", "Ú", "Û", "Ü", "Ý"}
	
	set ret to ""
	
	repeat with unAccent in accents
		if chaine contains unAccent then
			set ret to unAccent
			exit repeat
		end if
	end repeat
	
	return ret
	
end contientAccent


(*
Nom			: supprimeAccents
Description	: Remplace les caractères accentués par le même caractère non accentué
s			: chaine à utiliser
return		: la chaîne sans accents
*)
on supprimeAccents(s)
	set accents to "àáâãäçèéêëìíîïñòóôõöùúûüýÿÀÁÂÃÄÇÈÉÊËÌÍÎÏÑÒÓÔÕÖÙÚÛÜÝ"
	set sansAccents to "aaaaaceeeeiiiinooooouuuuyyAAAAACEEEEIIIINOOOOOUUUUY"
	considering case
		repeat with i from 1 to count of accents
			set AppleScript's text item delimiters to character i of accents
			set s to text items of s
			set AppleScript's text item delimiters to character i of sansAccents
			set s to s as text
		end repeat
	end considering
	set AppleScript's text item delimiters to ""
	return s
end supprimeAccents

(*
Nom			: aLEnvers
Description	: Renvoie la chaîne avec les caractères dans l'ordre inverse
chaine		: chaine à utiliser
return		: la chaîne avec les caractères dans l'ordre inverse
Exemple		: maChaine => eniahCam
*)
on aLEnvers(chaine)
	return (reverse of (characters of chaine)) as text
end aLEnvers


(*
Nom			: chaineVersListe
Description	: Renvoie une liste de chaînes à partir d'une chaîne et d'un délimiteur
chaine		: chaine à diviser en liste
delimiteur	: chaîne qui permet de diviser la chaîne
return		: Une liste des parties de la chaîne
Exemple		: chaineVersListe("bruno.boissonnet.30.ans", ".") => {"bruno", "boissonnet", "30", "ans"}
*)
on chaineVersListe(chaine, delimiteur)
	set tid to AppleScript's text item delimiters
	set AppleScript's text item delimiters to delimiteur
	--set theTextItems to every text item of theText
	set theTextItems to text items of chaine
	set AppleScript's text item delimiters to tid -- whatever they were before - ALWAYS SET THEM BACK!
	return theTextItems
end chaineVersListe


-----------------------------------------------------------------------------------------------------------
--                                                     TESTS
-----------------------------------------------------------------------------------------------------------

-- Pour tester cette bibliothèque :

-- 1°) Installez la bibliothèque dans le dossier : ~/Library/Script Libraries/
-- 2°) Créez un nouveau fichier script contenant le code suivant :


(*
set maChaine to "É l o ï s e.
Causse.30.a n s"

tell script "Chaine"
	
	log chaineVersListe(maChaine, ".")
	set chaineEnMajuscule to majuscule(maChaine)
	tell me to log chaineEnMajuscule
	set chaineEnMinuscule to minuscule(chaineEnMajuscule)
	tell me to log chaineEnMinuscule
	
	log sousChaine(maChaine, 7, 16)
	
	log supprimeCaractere(maChaine, "
")
	log supprimeCaractere2(maChaine, "
")
	log maChaine
	log supprimeLesEspaces(maChaine)
	
	log remplaceCaractere(maChaine, " ", "-")
	log replace_char2(maChaine, " ", "-")
	
	if contientAccent(maChaine) is not "" then
		log maChaine & " contient au moins un accent."
	end if
	
	log supprimeAccents(maChaine)
	
	log aLEnvers(maChaine)
	
	get chaineVersListe(maChaine, ".")
	
end tell
*)

