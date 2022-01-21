/*______________________________________________________________________________

        ÉTAPE 3
_______________________________________________________________________________*/

--------------------------------------------------------------------------------
-- A - GESTION DU STOCK DE CHAUSSURES
--------------------------------------------------------------------------------

----------------------------------------
-- 1 Relation résultat TOBEREPLACED
----------------------------------------

CREATE TABLE TOBEREPLACED
        AS (SELECT pointure, count(DISTINCT numPaire) as "nbr paires à remplacer" FROM CHAUSSURES
        WHERE etat LIKE 'KO'
        GROUP BY pointure);

/* Affichage de la Relation

 pointure | nbr paires à remplacer 
----------+------------------------
       39 |                      1
       40 |                      1
       43 |                      2
(3 rows)

*/
----------------------------------------
-- 2 Suppresion des paires de chaussures
--   en mauvais état
----------------------------------------

DELETE FROM EMPRUNT
WHERE numPaire in (
        SELECT numPaire FROM CHAUSSURES
        WHERE etat LIKE 'KO'
);

DELETE FROM UTILISATION
WHERE numPaire in (
        SELECT numPaire FROM CHAUSSURES
        WHERE etat LIKE 'KO'
);

DELETE FROM CHAUSSURES
WHERE etat LIKE 'KO';

/* Vérification...

 numpaire | pointure | etat 
----------+----------+------
        1 |       39 | OK
        3 |       39 | OK
        4 |       40 | OK
        5 |       40 | OK
        6 |       40 | OK
        8 |       41 | OK
        9 |       41 | OK
       10 |       42 | OK
       13 |       43 | OK
(9 rows)

*/

--------------------------------------------------------------------------------
-- B - CHANGEMENT DE PISTE POUR LES RÉSERVATIONS DE LA PISTE 1, QUI N'ONT
--     PAS ENCORE EU LIEU
--------------------------------------------------------------------------------

----------------------------------------
-- 1 Nouvelle Piste
----------------------------------------

INSERT INTO PISTE VALUES('10');

/* Vérification...

 numpiste 
----------
        1
        2
        3
        4
        5
        6
        7
        8
        9
       10
(10 rows)

*/
-----------------------------------------
-- 2 Modifications suite au changement de
--   la piste 1 par cette nouvelle piste,
--   pour toutes les réservations futures
-----------------------------------------

UPDATE RESERVATION
SET numPiste = '10'
WHERE numPiste = '01';

UPDATE OCCUPATION_P
SET numPiste = '10'
WHERE numPiste = '01';

/* Vérification...

 numresa | nbparties | nbjoueurs | nbmineurs | hdebjeu  | participe |  datejour  | numpiste | codeadh 
---------+-----------+-----------+-----------+----------+-----------+------------+----------+---------
       2 |         3 |         3 |         2 | 10:20:00 | t         | 2022-01-17 |        2 | 12d3
       1 |         2 |         3 |         0 | 14:30:00 | t         | 2022-01-17 |       10 | 42D0

 numpiste |  datejour  |  debut   |   fin    
----------+------------+----------+----------
        2 | 2022-01-17 | 14:30:00 | 15:30:00
       10 | 2022-01-17 | 10:20:00 | 12:00:00

*/

--------------------------------------------------------------------------------
-- C - ÉVOLUTION DU NOMBRE DE PARTIES MAXIMUM (ACTÉE DÉBUT FÉVRIER)
--------------------------------------------------------------------------------

ALTER TABLE RESERVATION
DROP CONSTRAINT reservation_nbparties_check;

ALTER TABLE RESERVATION
ADD CONSTRAINT nbParties CHECK (nbParties between 1 and 5); 

/* afficage du schéma de chaque relation de la base
   EXEMPLE : \d nom_relation


  Column   |           Type            | Collation | Nullable | Default 
-----------+---------------------------+-----------+----------+---------
 numresa   | integer                   |           | not null | 
 nbparties | integer                   |           |          | 
 nbjoueurs | integer                   |           |          | 
 nbmineurs | integer                   |           |          | 
 hdebjeu   | time(0) without time zone |           |          | 
 participe | boolean                   |           |          | 
 datejour  | date                      |           |          | 
 numpiste  | integer                   |           |          | 
 codeadh   | character varying         |           |          | 
 
Check constraints:
    "nbparties" CHECK (nbparties >= 1 AND nbparties <= 5)
    "reservation_nbjoueurs_check" CHECK (nbjoueurs >= 1 AND nbjoueurs <= 8)

*/
