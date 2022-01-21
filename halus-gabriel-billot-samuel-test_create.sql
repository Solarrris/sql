----------------------------------------------
--- ADHERENT
----------------------------------------------
INSERT INTO ADHERENT VALUES('42D0', 'Larnaque', 'Jack', '1994/07/21', 'Coline du crack', '0772165645', 'jackl''arnaque@malubulule.fr', 'liberezTousMesCopains');
INSERT INTO ADHERENT VALUES('12d3', 'Tunning', 'Jacky', '2000/03/20', '144 rue', '0607080910', 'JackLarnaque@tuning.fr', 'JackyTuning38');
INSERT INTO ADHERENT VALUES('17b9', 'Billot', 'Samuel', '2004/10/25', '841 faubourg montmélian', '076633m906','samuel.billot@outlook.fr', 'liberezTousSesCopains');

----------------------------------------------
--- CHAUSSURES
----------------------------------------------
INSERT INTO CHAUSSURES VALUES('01', '39', 'OK');
INSERT INTO CHAUSSURES VALUES('02', '39', 'KO');
INSERT INTO CHAUSSURES VALUES('03', '39', 'OK');
INSERT INTO CHAUSSURES VALUES('04', '40', 'OK');
INSERT INTO CHAUSSURES VALUES('05', '40', 'OK');
INSERT INTO CHAUSSURES VALUES('06', '40', 'OK');
INSERT INTO CHAUSSURES VALUES('07', '40', 'KO');
INSERT INTO CHAUSSURES VALUES('08', '41', 'OK');
INSERT INTO CHAUSSURES VALUES('09', '41', 'OK');
INSERT INTO CHAUSSURES VALUES('10', '42', 'OK');
INSERT INTO CHAUSSURES VALUES('11', '43', 'KO');
INSERT INTO CHAUSSURES VALUES('12', '43', 'KO');
INSERT INTO CHAUSSURES VALUES('13', '43', 'OK');

----------------------------------------------
--- UTILISATION
----------------------------------------------
INSERT INTO UTILISATION VALUES('11', '2022/01/17', '14:30:00', '15:30:00');
INSERT INTO UTILISATION VALUES('01', '2022/01/17', '14:30:00', '15:30:00');
INSERT INTO UTILISATION VALUES('06', '2022/01/17', '14:30:00', '15:30:00');
INSERT INTO UTILISATION VALUES('08', '2022/01/17', '10:20:00', '12:00:00');
INSERT INTO UTILISATION VALUES('04', '2022/01/17', '10:20:00', '12:00:00');
INSERT INTO UTILISATION VALUES('10', '2022/01/17', '10:20:00', '12:00:00');

----------------------------------------------
--- PISTE
----------------------------------------------
INSERT INTO PISTE VALUES('01');
INSERT INTO PISTE VALUES('02');
INSERT INTO PISTE VALUES('03');
INSERT INTO PISTE VALUES('04');
INSERT INTO PISTE VALUES('05');
INSERT INTO PISTE VALUES('06');
INSERT INTO PISTE VALUES('07');
INSERT INTO PISTE VALUES('08');
INSERT INTO PISTE VALUES('09');

----------------------------------------------
--- OCCUPATION_P
----------------------------------------------
INSERT INTO OCCUPATION_P VALUES('01', '2022/01/17', '10:20:00', '12:00:00');
INSERT INTO OCCUPATION_P VALUES('02', '2022/01/17', '14:30:00', '15:30:00');

----------------------------------------------
--- RESERVATION
----------------------------------------------
INSERT INTO RESERVATION VALUES('01', '2', '3', '0', '14:30:00', 'true', '2022/01/17', '01', '42D0');
INSERT INTO RESERVATION VALUES('02', '3', '3', '2', '10:20:00', 'true', '2022/01/17', '02', '12d3');

----------------------------------------------
--- EMPRUNT
----------------------------------------------
INSERT INTO EMPRUNT VALUES('01', '01');
INSERT INTO EMPRUNT VALUES('01', '06');
INSERT INTO EMPRUNT VALUES('01', '11');
INSERT INTO EMPRUNT VALUES('02', '08');
INSERT INTO EMPRUNT VALUES('02', '10');

