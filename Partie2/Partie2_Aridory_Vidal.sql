/* SAÉ MS204
 * PARTIE 1
 * ARIDORY MALCOLM, VIDAL MARTIN
 * LOGIN : ARID0002
 */

-- 4 Chargement de la base INFO_EXPO

-- 4.a

-- TYPELIEU
INSERT INTO TYPELIEU VALUES (1, 'Musée municipal');
INSERT INTO TYPELIEU VALUES (2, 'Musée National');
INSERT INTO TYPELIEU VALUES (3, 'Musée Privé');
INSERT INTO TYPELIEU VALUES (4, 'Musée Départemental');
INSERT INTO TYPELIEU VALUES (5, 'Galerie d’art');
INSERT INTO TYPELIEU VALUES (6, 'Châteaux');
INSERT INTO TYPELIEU VALUES (7, 'Institutions culturelles');

-- DEPARTEMENT
INSERT INTO DEPARTEMENT VALUES (75, 'Paris');
INSERT INTO DEPARTEMENT VALUES (77, 'Seine-et-Marne');
INSERT INTO DEPARTEMENT VALUES (78, 'Yvelines');
INSERT INTO DEPARTEMENT VALUES (91, 'Essonne');
INSERT INTO DEPARTEMENT VALUES (92, 'Hauts-de-Seine');
INSERT INTO DEPARTEMENT VALUES (93, 'Seine-Saint-Denis');
INSERT INTO DEPARTEMENT VALUES (94, 'Val-de-Marne');
INSERT INTO DEPARTEMENT VALUES (95, 'Val-d’Oise');

-- GENRE
INSERT INTO GENRE VALUES (1, 'Architecture/Design/Mode');
INSERT INTO GENRE VALUES (2, 'Art Contemporain');
INSERT INTO GENRE VALUES (3, 'Beaux-Arts');
INSERT INTO GENRE VALUES (4, 'Châteaux/Monuments');
INSERT INTO GENRE VALUES (5, 'Galeries');
INSERT INTO GENRE VALUES (6, 'Histoire/Civilisations');
INSERT INTO GENRE VALUES (7, 'Instituts culturels');
INSERT INTO GENRE VALUES (8, 'Jeunes Publics');
INSERT INTO GENRE VALUES (9, 'Photographie');
INSERT INTO GENRE VALUES (10, 'Salons');
INSERT INTO GENRE VALUES (11, 'Sciences et Techniques');

-- 4.b : import des données de lieux.csv

-- 4.c : on importe typeoeuvre, puis oeuvre puis expo

-- TYPEOEUVRE

INSERT INTO TYPEOEUVRE
    (NUMTPEVR, LIBTPEVR)
SELECT
    NUMTPEVR,
    LIBTPEVR
FROM
    TESTSAELD.TYPEOEUVRE_IMPORT;

-- OEUVRE

INSERT INTO OEUVRE
(NUMEVR, NUMART, NUMTPEVR, TITRE, ANNEECR)
SELECT
    OI.NUMEVR,
    OI.NUMART,
    OI.NUMTPEVR,
    OI.TITRE,
    OI.ANNEECR
FROM
    TESTSAELD.OEUVRE_IMPORT OI
    INNER JOIN TYPEOEUVRE TPO ON OI.NUMTPEVR = TPO.NUMTPEVR;

-- EXPO

INSERT INTO EXPO
(NUMLIEU, NUMEXPO, NUMGENRE, TITREEXPO, DATEDEB, DATEFIN, RESUME, TARIF, TARIFR, CHOIX)
SELECT
    EI.NUMLIEU,
    EI.NUMEXPO,
    EI.NUMGENRE,
    EI.TITREEXPO,
    EI.DATEDEB,
    EI.DATEFIN,'ai'
    EI.RESUME,
    EI.TARIF,
    EI.TARIFREDUIT,
    EI.CHOIX
FROM
    TESTSAELD.EXPO_IMPORT EI
    INNER JOIN LIEU LI ON (EI.NUMLIEU = LI.NUMLIEU);
    
-- 4.d

ALTER TABLE PRESENTATION
ADD CONSTRAINT 
    FK_PRESENTATION_NUMEVR FOREIGN KEY (numEvr) REFERENCES OEUVRE(numEvr);

ALTER TABLE PRESENTATION
ADD CONSTRAINT 
    FK_PRESENTATION_EXPO FOREIGN KEY (numLieu, numExpo) REFERENCES EXPO(numLieu, numExpo);
    

-- 4.e

-- Insertions des données pour la personne (1) qui a été voir toutes les expos du centre Pompudou

INSERT INTO ACHAT (numLieu, numExpo, numPers, dateAchat, nbBil, nbBilTR, modeReglt)
SELECT numLieu, numExpo, 1, SYSDATE, 1, 0, 'CB'
FROM EXPO
WHERE numLieu = (SELECT numLieu FROM LIEU WHERE nomLieu LIKE 'Centre Pompidou');

-- Insertion d'un achat en dehors de Paris



-- Insertion d'autres achats

