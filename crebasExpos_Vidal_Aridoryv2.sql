/*==============================================================*/
/* Nom de SGBD :  ORACLE Version 11g                            */
/* Date de cr�ation :  16/05/2024 14:09:59                      */
/*==============================================================*/


drop table Achat cascade constraints;

drop table DEPARTEMENT cascade constraints;

drop table EXPO cascade constraints;

drop table GENRE cascade constraints;

drop table LIEU cascade constraints;

drop table TYPELIEU cascade constraints;

/*==============================================================*/
/* Table : TYPELIEU                                             */
/*==============================================================*/
create table TYPELIEU 
(
   numTpLieu            INTEGER              not null,
   libTpLieu            VARCHAR2(30)         not null,
   constraint PK_TYPELIEU primary key (numTpLieu)
);

/*==============================================================*/
/* Table : DEPARTEMENT                                          */
/*==============================================================*/
create table DEPARTEMENT 
(
   numDpt               NUMBER(2)            not null,
   nomDpt               VARCHAR2(30)         not null,
   constraint PK_DEPARTEMENT primary key (numDpt)
);

/*==============================================================*/
/* Table : LIEU                                                 */
/*==============================================================*/
create table LIEU 
(
   numLieu              INTEGER              not null,
   numDpt               NUMBER(2),
   numTpLieu            INTEGER,
   nomLieu              VARCHAR2(50)         not null,
   missions             VARCHAR2(50),
   arrondissement       INTEGER             
      constraint CKC_ARRONDISSEMENT_LIEU check (arrondissement is null or (arrondissement between 1 and 20)),
   villeLieu            VARCHAR2(30),
   constraint PK_LIEU primary key (numLieu),
   constraint FK_LIEU_ETRE_TYPELIEU foreign key (numTpLieu)
         references TYPELIEU (numTpLieu),
   constraint FK_LIEU_SE_SITUER_DEPARTEM foreign key (numDpt)
         references DEPARTEMENT (numDpt)
);

/*==============================================================*/
/* Table : GENRE                                                */
/*==============================================================*/
create table GENRE 
(
   numGenre             INTEGER              not null,
   libGenre             VARCHAR2(30)         not null,
   constraint PK_GENRE primary key (numGenre)
);

/*==============================================================*/
/* Table : EXPO                                                 */
/*==============================================================*/
create table EXPO 
(
   numLieu              INTEGER              not null,
   numExpo              INTEGER              not null,
   numGenre             INTEGER,
   titreExpo            VARCHAR2(30)         not null,
   dateDeb              DATE                 not null,
   dateFin              DATE,
   resume               VARCHAR2(100),
   tarif                NUMBER(4,2)         
      constraint CKC_TARIF_EXPO check (tarif is null or (tarif >= 0)),
   tarifR               NUMBER(4,2)         
      constraint CKC_TARIFR_EXPO check (tarifR is null or (tarifR >= 0)),
   choix                INTEGER             
      constraint CKC_CHOIX_EXPO check (choix is null or (choix in (NULL,1))),
   constraint PK_EXPO primary key (numLieu, numExpo),
   constraint FK_EXPO_LI_LIEU foreign key (numLieu)
         references LIEU (numLieu),
   constraint FK_EXPO_APPARTENI_GENRE foreign key (numGenre)
         references GENRE (numGenre),
   constraint CKC_DATEFIN_EXPO check (dateFin >= dateDeb)
);

/*==============================================================*/
/* Table : Achat                                                */
/*==============================================================*/
create table Achat 
(
   numLieu              INTEGER              not null,
   numExpo              INTEGER              not null,
   numPers              INTEGER              not null,
   dateAchat            DATE                 not null,
   nbBil                INTEGER,
   nbBilTR              INTEGER,
   modeReglt            CHAR(3)             
      constraint CKC_MODEREGLT_ACHAT check (modeReglt is null or (modeReglt in ('CB','CHQ','ESP'))),
   constraint PK_ACHAT primary key (numLieu, numExpo, numPers, dateAchat),
   constraint FK_ACHAT_LI_ACHAT__EXPO foreign key (numLieu, numExpo)
         references EXPO (numLieu, numExpo),
   constraint FK_ACHAT_LI_ACHAT__PERSONNE foreign key (numPers)
         references PERSONNE (numPers)
);

/*==============================================================*/
/* Table : TYPEOEUVRE                                           */
/*==============================================================*/
CREATE TABLE TYPEOEUVRE (
    numTpEvr INTEGER NOT NULL,
    libTpEvr VARCHAR2(30) NOT NULL,
    constraint PK_TYPEOEUVRE primary key (numTpEvr)
);

/*==============================================================*/
/* Table : ARTISTE                                              */
/*==============================================================*/
CREATE TABLE ARTIST
AS SELECT 


/*==============================================================*/
/* Table : OEUVRE                                               */
/*==============================================================*/
CREATE TABLE OEUVRE (
    numEvr INTEGER NOT NULL,
    numArt INTEGER NOT NULL,
    numTpEvr INTEGER NOT NULL,
    titre VARCHAR2(50) NOT NULL,
    anneeCr INTEGER,
    constraint PK_OEUVRE primary key (numTpEvr)
    constraint FK_NUMTPEVR_OEUVRE FOREIGN KEY (numTpEvr) REFERENCES TYPEOEUVRE(numTpEvr) ON DELETE SET NULL
    constraint FK_NUMART_OEUVRE FOREIGN KEY (numArt) REFERENCES ARTIST(numArt) ON DELETE CASCADE
);