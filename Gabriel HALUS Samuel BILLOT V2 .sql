CREATE TABLE adherent (
    codeAdh varchar primary key,
    nom varchar,
    prenom varchar,
    dateNaiss date,
    adresse varchar,
    tel integer not null check (tel between 0 and 9999999999),
    mail varchar,
    mdp varchar
);

CREATE TABLE piste (
    numPiste integer primary key
);

CREATE TABLE reservation (
    numResa integer primary key,
    nbParties integer check (nbParties between 1 and 3),
    nbJoueurs integer check (nbJoueurs between 1 and 8),
    nbMineurs integer,
    hDebJeu time(0),
    participe boolean,  
    dateJour date,
    numPiste integer references piste(numPiste),
    codeAdh varchar references adherent(codeAdh)
);

CREATE TABLE chaussures (
    numPaire integer primary key,
    pointure integer,
    etat varchar CHECK(etat IN('OK', 'KO'))
);

CREATE TABLE utilisation (
    numPaire integer references chaussures(numPaire),
    dateJour date,
    debutU time(0),
    finU time(0) CHECK (finU > debutU),
    primary key (debutU, finU, dateJour, numPaire)
);

CREATE TABLE occupation_p (
    numPiste integer references piste(numPiste),
    dateJour date,
    debut time(0),
    fin time(0) CHECK ('09:15:00' < debut AND debut < fin AND fin < '20:30:00'),
    primary key (numPiste, debut, fin, dateJour)
);

CREATE TABLE emprunt (
    numResa integer references reservation(numResa),
    numPaire integer references chaussures(numPaire),
    primary key (numResa, numPaire)
);