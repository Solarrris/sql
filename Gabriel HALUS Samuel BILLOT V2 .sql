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

CREATE TABLE dateJ (
    dateJour date primary key CHECK (DAYOFWEEK(dateJour) NOT IN ('Sunday'))
);

CREATE TABLE reservation (
    numResa integer primary key,
    nbParties integer check (nbParties between 1 and 3),
    nbJoueurs integer check (nbJoueurs between 1 and 8),
    nbMineurs integer,
    hDebJeu time(0),
    participe boolean,  
    dateJour date references dateJ(dateJour),
    numPiste integer references piste(numPiste),
    codeAdh varchar references adherent(codeAdh)
);

CREATE TABLE chaussures (
    numPaire integer primary key,
    pointure integer,
    etat varchar CHECK(etat IN('OK', 'KO'))
);

CREATE TABLE horaire (
    heure time(0) primary key CHECK (heure between '9:30:00' and '20:30:00')
);

CREATE TABLE utilisation (
    numPaire integer references chaussures(numPaire),
    dateJour date references dateJ(dateJour),
    debutU time(0) references horaire(heure),
    finU time(0) references horaire(heure) CHECK (finU > debutU),
    primary key (debutU, finU, dateJour, numPaire)
);

CREATE TABLE occupation_p (
    numPiste integer references piste(numPiste),
    dateJour date references dateJ(dateJour),
    debut time(0) references horaire(heure),
    fin time(0) references horaire(heure) CHECK (fin > debut),
    primary key (numPiste, debut, fin, dateJour)
);

CREATE TABLE emprunt (
    numResa integer references reservation(numResa),
    numPaire integer references chaussures(numPaire),
    primary key (numResa, numPaire)
);