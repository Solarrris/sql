/*______________________________________________________________________________
        ÉTAPE 2
_______________________________________________________________________________*/

--------------------------------------------------------------------------------
-- A - PREMIÈRES DONNÉES DANS LA BASE
--------------------------------------------------------------------------------

----------------------------------------
-- A1 - Jeu de données initial
---------------------------------------
SET DATESTYLE TO EUROPEAN;

-- Insertion de 10 adhérents

INSERT INTO ADHERENT VALUES ('123', 'Halus', 'Gabriel', '2003/02/27', '15 boulevard des saltimbanques', '0786541278', 'gabrielhalus@michel.com', 'michel');

INSERT INTO ADHERENT VALUES ('456', 'Billot', 'Samuel', '2003/10/25', '18 rue des goulots', '0778985621', 'samuelbillot@francis.com', 'ilovefrancis56');

INSERT INTO ADHERENT VALUES ('a78fd', 'Fruchart', 'Mélian', '2003/03/30', '12 avenue des tulipes', '0648971264', 'melianfruchoux@rene.fr', 'renéenforceouais');

INSERT INTO ADHERENT VALUES ('12sdfg3', 'Endignous', 'Arnaud', '2008/02/28', '17 boulevard des saltimbanques', '0786541278', 'arnaud.endignous@raymond.com', 'raymond');

INSERT INTO ADHERENT VALUES ('123ert', 'Churchil', 'Winston', '1906/02/27', '13 boulevard des saltimbanques', '0786541223', 'winstonchurchil@mgontrand.com', 'gontrand');

INSERT INTO ADHERENT VALUES ('1azr23', 'Bonaparte', 'Napoléon', '1774/02/27', '15 boulevard des pissenlits', '0786541236', 'napolbonap@romuald.com', 'romualddu16');

INSERT INTO ADHERENT VALUES ('1dg23', 'Bigard', 'Jean-Marie', '1975/02/27', '15 rue des idiots', '0786546524', 'jmbigard@maurice.com', 'maurice');

INSERT INTO ADHERENT VALUES ('12gfc3', 'Zemmour', 'Eric', '1965/07/26', '14 boulevard des tulipes', '0686541278', 'ericlez@herve.com', 'herve');

INSERT INTO ADHERENT VALUES ('1xv23v', 'Blanchon', 'Hervé', '1964/08/10', '5 avenue des couards', '0782241278', 'herveblanchon@Hyppolite.com', 'hyppolitecoeur');

INSERT INTO ADHERENT VALUES ('1xc2bb', 'Etienne', 'Samuel', '1985/07/07', '2 rue des gentils', '0787841278', 'sametienne@eudes.com', 'eudeslamenace667');




-- Insertion d'une piste : numéro de piste = 1

INSERT INTO PISTE VALUES (1);

-- Insertion de 2 paires de chaussures par pointure
-- Au moins une paire par pointure doit être en bon état

INSERT INTO CHAUSSURES VALUES (1, 32, 'OK');
INSERT INTO CHAUSSURES VALUES (2, 32, 'KO');

INSERT INTO CHAUSSURES VALUES (3, 33, 'OK');
INSERT INTO CHAUSSURES VALUES (4, 33, 'OK');

INSERT INTO CHAUSSURES VALUES (5, 34, 'KO');
INSERT INTO CHAUSSURES VALUES (6, 34, 'OK');

INSERT INTO CHAUSSURES VALUES (7, 35, 'OK');
INSERT INTO CHAUSSURES VALUES (8, 35, 'KO');

INSERT INTO CHAUSSURES VALUES (9, 36, 'OK');
INSERT INTO CHAUSSURES VALUES (10, 36, 'OK');

INSERT INTO CHAUSSURES VALUES (11, 37, 'OK');
INSERT INTO CHAUSSURES VALUES (12, 37, 'OK');

INSERT INTO CHAUSSURES VALUES (13, 38, 'OK');
INSERT INTO CHAUSSURES VALUES (14, 38, 'OK');

INSERT INTO CHAUSSURES VALUES (15, 39, 'OK');
INSERT INTO CHAUSSURES VALUES (16, 39, 'KO');

INSERT INTO CHAUSSURES VALUES (17, 40, 'OK');
INSERT INTO CHAUSSURES VALUES (18, 40, 'OK');

INSERT INTO CHAUSSURES VALUES (19, 41, 'KO');
INSERT INTO CHAUSSURES VALUES (20, 41, 'OK');

INSERT INTO CHAUSSURES VALUES (21, 42, 'OK');
INSERT INTO CHAUSSURES VALUES (22, 42, 'OK');

INSERT INTO CHAUSSURES VALUES (23, 43, 'OK');
INSERT INTO CHAUSSURES VALUES (24, 43, 'OK');

INSERT INTO CHAUSSURES VALUES (25, 44, 'KO');
INSERT INTO CHAUSSURES VALUES (26, 44, 'OK');

INSERT INTO CHAUSSURES VALUES (27, 45, 'OK');
INSERT INTO CHAUSSURES VALUES (28, 45, 'OK');

INSERT INTO CHAUSSURES VALUES (29, 46, 'KO');
INSERT INTO CHAUSSURES VALUES (30, 46, 'OK');



-- Enregistrement d'une réservation pour le 21 janvier 2022 :
-- numéro 1, début à 9h15, 2 parties, 2 personnes, pas de mineur, piste n°1
-- l'adhérent qui fait la réservation ne fera pas partie des joueurs

INSERT INTO RESERVATION VALUES (1, 2, 2, 0, '9:15:00', false, '2022/01/21', 1, '123');


-- Retenue d'une paire de chaussures, pointure 42 et une paire de chaussures
-- pointure 43, pour la réservation n°1

INSERT INTO EMPRUNT VALUES (1, (SELECT numPaire FROM CHAUSSURES WHERE pointure = 42 LIMIT 1));
INSERT INTO EMPRUNT VALUES (1, (SELECT numPaire FROM CHAUSSURES WHERE pointure = 43 LIMIT 1));

----------------------------------------------------
-- A2 - Gérer les conséquences de l'enregistrement
--      de la réservation°1 et de la retenue de paires
--      de chaussures pour cette réservation
----------------------------------------------------

-- 2.1 calcul de l'heure de fin de jeu pour la réservation n°1:

SELECT (hDebJeu+(10*nbJoueurs*nbParties) FROM RESERVATION WHERE numResa = 1);


/* Résultat du SELECT (à coller ci-dessous)
*/

-- 2.2 Dans la relation représentant l'occupation des pistes de jeu :
-- Insérer un n-uplet qui mémorise l'occupation de la piste n°1,
-- à partir de l'heure de début de jeu de la réservation n°1 et jusqu'à l'heure
-- estimée de fin de jeu pour cette réservation

INSERT INTO OCCUPATION_P VALUES ((SELECT numPiste FROM RESERVATION WHERE numResa = 1),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 1),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 1),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 1);

-- vérification (SELECT....)

SELECT * FROM OCCUPATION_P;


/* Résultat du SELECT (à coller ci-dessous)
*/


--2.3. Dans la relation représentant l'utilisation des paires de chaussures
-- prêtées par le club :
-- Écrire l'instruction permettant de mémoriser la retenuTe de paires
-- de chaussures pour la réservation n°1

INSERT INTO UTILISATION VALUES ((SELECT numPaire FROM EMPRUNT WHERE numResa = 1 LIMIT 1),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 1),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 1),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 1);


-- vérification (SELECT...)

SELECT * FROM UTILISATION;

/* Résultat du SELECT (à coller ci-dessous)
*/

----------------------------------------
-- A3 - Nouvelles réservations
----------------------------------------

-- 3.1 : prise en compte des demandes
-- réservation n°2, début à 11h30, 1 partie, 3 personnes dont 1 mineur,
-- affectation de la piste n°1,
-- l'adhérent qui fait la réservation fera partie des joueurs

INSERT INTO RESERVATION VALUES (2, 1, 3, 1, '11:30:00', true, '2022/01/21', 1, '1xc2bb');


-- réservation n°3, début à 16h, 3 parties, 4 personnes dont 3 mineurs,
-- affectation de la piste n°1,
-- l'adhérent qui fait la réservation fera partie des joueurs

INSERT INTO RESERVATION VALUES (3, 3, 4, 3, '16:00:00', true, '2022/01/21', 1, '456');


-- retenue d'une paire de chaussures, pointure 36 pour la réservation n°2

INSERT INTO EMPRUNT VALUES (2, (SELECT numPaire FROM CHAUSSURES WHERE pointure = 36 LIMIT 1));


-- retenue d'une paire de chaussures, pointure 32 pour la réservation n°3

INSERT INTO EMPRUNT VALUES (3, (SELECT numPaire FROM CHAUSSURES WHERE pointure = 32 LIMIT 1));


-- 3.2 gestion des conséquences de la prise en compte des demandes

-- a) Occupation des pistes

INSERT INTO OCCUPATION_P VALUES ((SELECT numPiste FROM RESERVATION WHERE numResa = 2),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 2),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 2),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 2);




INSERT INTO OCCUPATION_P VALUES ((SELECT numPiste FROM RESERVATION WHERE numResa = 3),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 3),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 3),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 3);

-- vérification

SELECT * FROM OCCUPATION_P


/* Résultat du SELECT (à coller ci-dessous)
*/

-- b) utilisation des chaussures

INSERT INTO UTILISATION VALUES ((SELECT numPaire FROM EMPRUNT WHERE numResa = 2 LIMIT 1),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 2),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 2),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 2);



INSERT INTO UTILISATION VALUES ((SELECT numPaire FROM EMPRUNT WHERE numResa = 3 LIMIT 1),
                                (SELECT dateJour FROM RESERVATION WHERE numResa = 3),
                                (SELECT hDebJeu FROM RESERVATION WHERE numResa = 3),
                                (SELECT (hDebJeu+(10*nbParties*nbJoueurs)) FROM RESERVATION WHERE numResa = 3);


-- vérification

SELECT * FROM UTILISATION;


/* Résultat du SELECT (à coller ci-dessous)
*/

--------------------------------------------------------------------------------
-- B - REQUETTAGE
--------------------------------------------------------------------------------
--------------------------------------------------
-- B1 -	Écrire et tester les requêtes suivantes :
--------------------------------------------------

-- B1.1 Nombre total de mineurs pour les réservations du 21 janvier 2022

SELECT COUNT(nbMineurs) FROM RESERVATION WHERE dateJour LIKE '2022/01/21';


/* Résultat du SELECT (à coller ci-dessous)
*/

-- B1.2 Détail de la réservation numéro 1


/* Résultat du SELECT (à coller ci-dessous)
*/

-- B1.3 Numéro et pointure des paires de chaussures réservées
-- pour chaque réservation du 21 janvier 2022

SELECT numResa, numPaire, pointure FROM EMPRUNT, CHAUSSURES
WHERE EMPRUNT.numPaire = CHAUSSURES.numPaire
GROUP BY numResa;



/* Résultat du SELECT (à coller ci-dessous)
*/

-- B1.4 Pour chaque pointure, nombre de paires de chaussures dans la base

SELECT pointure, COUNT(numPaire) FROM CHAUSSURES GROUP BY pointure;


/* Résultat du SELECT (à coller ci-dessous)
*/

-- B1.5 Pour chaque pointure, nombre de paires de chaussures en mauvais état

SELECT pointure, COUNT(numPaire) FROM CHAUSSURES WHERE etat LIKE 'KO' GROUP BY pointure;


/* Résultat du SELECT (à coller ci-dessous)
*/

--B1.6 Planning d'occupation de la piste 1, le 21 janvier 2022

SELECT (debut, fin) FROM OCCUPATION_P WHERE numPiste = 1 AND dateJour LIKE '2022/01/21'

/* Résultat du SELECT (à coller ci-dessous)
*/
--------------------------------------------------
-- B2 -	Vérifier s'il est possible de prendre en
--      compte une demande de réservation...
--------------------------------------------------

-- B2.1	Vérifier s'il est possible de prendre en compte une réservation
-- pour 2 joueurs et 3 parties, qui débuterait à 13h, le 21 janvier 2022,
-- sachant qu'une paire de chaussures, pointure 42 est demandée…

-- 1) calcul de l'heure de fin de jeu :




/* Résultat du SELECT (à coller ci-dessous)
*/
-- 2) Y a-t-il une piste disponible ?
--    REMARQUE :  pour l'instant il n'y a qu'une piste, mais écrire une requête
--                qui qrend en compte le fait qu'il puisse y en avoir plusieurs



-- /* Résultat du SELECT (à coller ci-dessous)



-- 3) S'il y a une piste disponible,
--    Y a-t-il une paire de chaussures disponible en pointure 42 ?



/* Résultat du SELECT (à coller ci-dessous)
*/

-- B2.1	Vérifier s'il est possible de prendre en compte une réservation
-- pour 4 joueurs et 2 parties, qui débuterait à 15h, le 21 janvier 2022,
-- sachant qu'une paire de chaussures, pointure 43 est demandée…

-- 1) calcul de l'heure de fin de jeu :



/* Résultat du SELECT (à coller ci-dessous)
*/
-- 2) Y a-t-il une piste disponible ?
--    REMARQUE : ^our l'instant il n'y a qu'une piste, mais écrire une requête
--                qui qrend en compte le fait qu'il puisse y en avoir plusieurs



/* Résultat du SELECT (à coller ci-dessous)
*/

-- 3) S'il y a une piste disponible,
--    Y a-t-il une paire de chaussures disponible en pointure 42 ?



/* Résultat du SELECT (à coller ci-dessous)
*/