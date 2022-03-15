#SUPPRESSION DES TABLEAUX 

DROP TABLE IF EXISTS revenu;
DROP TABLE IF EXISTS participation_revision;
DROP TABLE IF EXISTS Seance_revision;
DROP TABLE IF EXISTS evenement;
DROP TABLE IF EXISTS calendrier;
DROP TABLE IF EXISTS cagnotte;
DROP TABLE IF EXISTS objectif;
DROP TABLE IF EXISTS confirmation;
DROP TABLE IF EXISTS date_event;
DROP TABLE IF EXISTS pratiquer;
DROP TABLE IF EXISTS Camarade;
DROP TABLE IF EXISTS Ami;
DROP TABLE IF EXISTS adresses_loisir;
DROP TABLE IF EXISTS Loisir;
DROP TABLE IF EXISTS Reseau;
DROP TABLE IF EXISTS Personne;

CREATE TABLE Personne(
   telephone CHAR(11),
   nom VARCHAR(50),
   prenom VARCHAR(50),
   ville VARCHAR(50),
   PRIMARY KEY(telephone)
);

CREATE TABLE Reseau(
   id_reso INT PRIMARY KEY auto_increment,
   nom_reseau VARCHAR(50),
   pseudo VARCHAR(50),
   telephone CHAR(50),
   FOREIGN KEY(telephone) REFERENCES Personne(telephone)
);

CREATE TABLE Loisir(
   nom_loisir VARCHAR(50),
   PRIMARY KEY(nom_loisir)
);

CREATE TABLE Adresses_loisir(
   id_adresse INT,
   numero_rue INT,
   nom_rue VARCHAR(50),
   ville VARCHAR(50),
   nom_loisir VARCHAR(50) NOT NULL,
   FOREIGN KEY(nom_loisir) REFERENCES Loisir(nom_loisir)
);

CREATE TABLE Pratiquer(
   telephone CHAR(11),
   nom_loisir VARCHAR(50),
   PRIMARY KEY(telephone, nom_loisir),
   FOREIGN KEY(telephone) REFERENCES Personne(telephone),
   FOREIGN KEY(nom_loisir) REFERENCES Loisir(nom_loisir)
);

CREATE TABLE Camarade(
   id_camarade INT,
   telephone CHAR(11),
   PRIMARY KEY(id_camarade),
   FOREIGN KEY(telephone) REFERENCES Personne(telephone)
);

CREATE TABLE Ami(
   id_ami INT,
   telephone CHAR(11),
   PRIMARY KEY(id_ami),
   FOREIGN KEY(telephone) REFERENCES Personne(telephone)
);


CREATE TABLE Objectif(
   id_objectif INT,
   nom VARCHAR(50),
   description VARCHAR(50),
   type VARCHAR(50),
   somme_cible INT,
   annee INT,
   PRIMARY KEY(id_objectif)
);


CREATE TABLE Cagnotte(
   id_cagnotte INT,
   montant INT,
   id_objectif INT,
   montant_initial INT,
   PRIMARY KEY(id_cagnotte),
   UNIQUE(id_objectif),
   FOREIGN KEY(id_objectif) REFERENCES Objectif(id_objectif)
);

CREATE TABLE Revenu(
   id_revenu INT,
   somme_revenu INT,
   mois_revenu VARCHAR(50),
   annee INT,
   id_cagnotte INT,
   PRIMARY KEY(id_revenu),
   FOREIGN KEY(id_cagnotte) REFERENCES Cagnotte(id_cagnotte)
);

CREATE TABLE Calendrier(
   id_calendrier INT,
   jour VARCHAR(50),
   mois VARCHAR(50),
   annee VARCHAR(50),
   heure DECIMAL(4,2),
   depense INT,
   id_cagnotte INT,
   PRIMARY KEY(id_calendrier),
   FOREIGN KEY(id_cagnotte) REFERENCES Cagnotte(id_cagnotte)
);


CREATE TABLE Seance_revision(
   id_seance INT,
   matiere VARCHAR(50),
   travail VARCHAR(50),
   deadline DATE,
   id_calendrier INT,
   PRIMARY KEY(id_seance),
 FOREIGN KEY(id_calendrier) REFERENCES Calendrier(id_calendrier)
);

CREATE TABLE Participation_revision(
   id_seance INT,
   id_camarade INT,
   PRIMARY KEY(id_seance, id_camarade),
   FOREIGN KEY(id_seance) REFERENCES Seance_revision(id_seance),
   FOREIGN KEY(id_camarade) REFERENCES Camarade(id_camarade)
);

CREATE TABLE Date_event(
   id_proposition INT,
   date_e DATE ,
   etat_confirmation INT,
   heure DECIMAL(4,2),
   PRIMARY KEY(id_proposition)
);

CREATE TABLE Confirmation(
   id_proposition int,
   id_ami int,
   etat_confirmation INT,
   organisateur INT,
   PRIMARY KEY(id_proposition, id_ami),
   FOREIGN KEY(id_proposition) REFERENCES Date_event(id_proposition),
   FOREIGN KEY(id_ami) REFERENCES Ami(id_ami)
);

CREATE TABLE Evenement(
   id_evenement INT,
   nom VARCHAR(50),
   nom_organisateur VARCHAR(50),
   numero_rue VARCHAR(50),
   nom_rue VARCHAR(50),
   ville VARCHAR(50),
   id_calendrier INT,
   id_proposition INT,
   PRIMARY KEY(id_evenement),
   UNIQUE(id_proposition),
   FOREIGN KEY(id_calendrier) REFERENCES Calendrier(id_calendrier),
   FOREIGN KEY(id_proposition) REFERENCES Date_event(id_proposition)
);

-- remplissage des tables

INSERT INTO Loisir(nom_loisir) 
VALUES ('Tennis');
INSERT INTO Loisir(nom_loisir) 
VALUES('Football');
INSERT INTO Loisir(nom_loisir) 
VALUES('Echecs'); 
INSERT INTO Loisir(nom_loisir) 
VALUES('Shopping');
INSERT INTO Loisir(nom_loisir) 
VALUES('Cinéma'); 
INSERT INTO Loisir(nom_loisir) 
VALUES('Lecture'); 
INSERT INTO Loisir(nom_loisir) 
VALUES('Baseball');
INSERT INTO Loisir(nom_loisir) 
VALUES('Vélo');
INSERT INTO Loisir(nom_loisir) 
VALUES('Théâtre');

INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0698874633', 'BOUGUEROUA', 'Lamine', 'Paris');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0687450291', 'MACRON', 'Emmanuel', 'Paris');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0761526378', 'PICHETTE', 'Amélie', 'Bordeaux');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0798064602', 'DENNIS', 'Clementine', 'Melun');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0910657389', 'CHANDONNET', 'Dominique', 'Berlin');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0698774633', 'GOULET', 'Isabelle', 'Villejuif');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0643420242','MICHEL','Luc','Annecy');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0698874634', 'MARQUIS', 'Yves', 'Paris');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0791491294', 'SMITH', 'Merlin', 'Noisy-le-Grand');
INSERT INTO Personne (telephone, nom, prenom, ville) 
VALUES ('0794820145', 'CHEN', 'Céline', 'Bobigny');

INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Lamineee','0698874633');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Snapchat','Lamineee','0698874633');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Twitter','Lamineee','0698874633');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Manu77','0687450291');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Instagram','Manu77','0687450291');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Amélieee3','0761526378');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Snapchat','Amélieee3','0761526378');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Clem','0798064602');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Chanchan','0910657389');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Instagram','Chanchan','0910657389');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','YY','0698774633' );
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Instagram','Best3','0643420242');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Twitter','Firtsss','0698874634' );
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Snapchat','Firtsss','0698874634' );
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','Onlyme','0791491294');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Facebook','WAR','0794820145');
INSERT INTO Reseau(nom_reseau, pseudo, telephone)
VALUES ('Instagram','WAR','0794820145');

INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(1, 125, 'Rue André Karman', 'Paris', 'Tennis');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(2, 99, 'Rue des Dunes', 'Saint-Malo', 'Vélo');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(3, 93, 'Avenue de Bouvines', 'Paris', 'Shopping');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(4, 34, 'Chemin Challet', 'Paris', 'Echecs');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(5, 51, 'Rue des Soeurs', 'Bobigny', 'Théâtre');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(7, 57, 'Rue Sadi Carnot', 'Auxerre', 'Football');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(9, 87, 'Boulevard de Prague', 'Nîmes', 'Baseball');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(10, 21, 'Rue de Lille', 'Arras', 'Tennis');
INSERT INTO Adresses_Loisir(id_adresse, numero_rue,nom_rue, ville, nom_loisir) 
VALUES(11, 59, 'Rue des Lacs', 'Paris', 'Lecture');


INSERT INTO Pratiquer(telephone, nom_loisir) 
VALUES('0643420242','Lecture');
INSERT INTO Pratiquer(telephone, nom_loisir) 
VALUES('0643420242','Tennis');
INSERT INTO Pratiquer(telephone, nom_loisir) 
VALUES('0643420242','Théâtre');
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0687450291','Lecture'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0687450291','Théâtre'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0687450291','Echecs'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698774633','Shopping'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698774633','Echecs'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698874633','Football'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698874633','Baseball'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698874634','Tennis'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698874634','Vélo'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698874634','Football'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0791491294','Baseball'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0791491294','Tennis'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0794820145','Echecs'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0794820145','Shopping'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0794820145','Vélo'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0698774633','Vélo'); 
INSERT INTO Pratiquer(telephone, nom_loisir)
VALUES('0761526378','Shopping'); 

INSERT INTO Camarade(id_camarade, telephone)
VALUES(1, '0698874633'); 
INSERT INTO Camarade(id_camarade, telephone)
VALUES(2, '0687450291');
INSERT INTO Camarade(id_camarade, telephone)
VALUES(3, '0761526378');
INSERT INTO Camarade(id_camarade, telephone)
VALUES(4, '0798064602');
INSERT INTO Camarade(id_camarade, telephone)
VALUES(5, '0910657389');


INSERT INTO Ami(id_ami,telephone)
VALUES(1, '0698874633'); 
INSERT INTO Ami(id_ami,telephone)
VALUES(2, '0687450291');
INSERT INTO Ami(id_ami,telephone)
VALUES(3, '0643420242');
INSERT INTO Ami(id_ami,telephone)
VALUES(4, '0698774633');
INSERT INTO Ami(id_ami,telephone)
VALUES(5, '0791491294'); 
INSERT INTO Ami(id_ami,telephone)
VALUES(6, '0794820145'); 
INSERT INTO Ami(id_ami,telephone)
VALUES(7, '0698874634'); 


INSERT INTO Objectif (id_objectif,nom, description, type,somme_cible,annee)
VALUES(1, "Voyage", "Voyage à l'autre bout du monde pendant 2 semaines", "Plaisir", 4000, 2020);
INSERT INTO Objectif (id_objectif,nom, description, type,somme_cible,annee)
VALUES(2, "Voiture", "Voiture familiale", "Besoin", 15000, 2021);
INSERT INTO Objectif (id_objectif,nom, description, type,somme_cible,annee)
VALUES(3, "Rolex", "Montre pour se vanter", "Luxe", 100000, 2024);

INSERT INTO Cagnotte(id_cagnotte, montant,montant_initial,id_objectif)
VALUES(1, 4000, 800, 1);
INSERT INTO Cagnotte(id_cagnotte, montant,montant_initial,id_objectif)
VALUES(2, 10200, 600, 2);
INSERT INTO Cagnotte(id_cagnotte, montant,montant_initial,id_objectif)
VALUES(3, 200, 0, 3);

INSERT INTO Revenu(id_revenu, somme_revenu, mois_revenu, annee, id_cagnotte)
VALUES(1, 1000, "Janvier", 2020, 1);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(2, 1000, "Février", 2020, 1);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(3, 1000, "Mars", 2020, 1);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(4, 1000, "Avril", 2020, 1);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
#Voyage débloqué (penser à faire en sorte de dépenser 200€ en activité pour bien avoir 600€ de montant initial pour le suivant)
VALUES(5, 1000, "Mai", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(6, 1000, "Juin", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(7, 1000, "Juillet", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(8, 1000, "Août", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(9, 1000, "Septembre", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(10, 1000, "Octobre", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(11, 1000, "Novembre", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(12, 1000, "Décembre", 2020, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(13, 1000, "Janvier", 2021, 2);
INSERT INTO Revenu(id_revenu, somme_revenu,mois_revenu,annee, id_cagnotte)
VALUES(14, 1000, "Février", 2021, 2);



INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(1, 15, "Janvier", 2020, 11.30, 40, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(2, 23, "Janvier", 2020, 18.00, 30, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(3, 2, "Février", 2020, 15.00, 35, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(4, 17, "Février", 2020, 18.00, 25, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(5, 8, "Mars", 2020, 14.00, 40, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(6, 22, "Avril", 2020, 18.00, 20, 1);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(7, 1, "Mai", 2020, 19.00, 55, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(8, 4, "Juin", 2020, 16.00, 40, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(9, 17, "Juin", 2020, 17.30, 30, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(10, 28, "Juillet", 2020, 12.30, 30, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(11, 6, "Août", 2020, 14.15, 15, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(12, 5, "Septembre", 2020, 17.40, 75, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(13, 18, "Novembre", 2020, 15.00, 0, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(14, 16, "Décembre", 2020, 17.00, 10, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(15, 19, "Décembre", 2020, 13.00, 50, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(16, 14, "Janvier", 2021, 11.00, 20, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(17, 2, "Février", 2021, 8.00, 30, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(18, 26, "Février", 2021, 17.00, 0, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(19, 26, "Février", 2021, 20.00, 20, 2);
INSERT INTO Calendrier(id_calendrier,jour,mois,annee,heure,depense,id_cagnotte)
VALUES(20, 26, "Mars", 2021, 14.30, 15, 2);
 
 INSERT INTO Seance_revision(id_seance,matiere, travail,deadline,id_calendrier)
VALUES(1, 'Maths', 'Révision', NULL, 13); 
 INSERT INTO Seance_revision(id_seance,matiere, travail,deadline,id_calendrier)
VALUES(2, 'BDD', 'Projet', NULL, 14); 
 INSERT INTO Seance_revision(id_seance,matiere, travail,deadline,id_calendrier)
VALUES(3, 'Théorie des graphes', 'Homework', '2020-01-12', 11); 
 INSERT INTO Seance_revision(id_seance,matiere, travail,deadline,id_calendrier)
VALUES(4, 'Cybersécurité', 'Révision', NULL, 18); 
 INSERT INTO Seance_revision(id_seance,matiere, travail,deadline,id_calendrier)
VALUES(5, 'English', 'Homework', '2020-04-03', 20);
 

 
INSERT INTO participation_revision(id_seance,id_camarade)
VALUES(1, 1); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(1, 3); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(1, 5); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(2,1); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(2, 2); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(3, 3); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(3, 4); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(3, 5);
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(4, 1);
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(5, 1);
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(5, 2); 
INSERT INTO Participation_revision(id_seance,id_camarade)
VALUES(5, 3);


INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(1,'2020-01-15',1,11.30);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(2,'2020-01-23',1,18.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(3,'2020-02-02',1,15.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(4,'2020-02-17',1,18.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(5,'2020-03-08',1,14.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(6,'2020-04-22',1,18.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(7,'2020-05-1',1,19.55);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(8,'2020-06-04',1,16.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(9,'2020-06-17',1,17.30);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(10,'2020-07-28',1,12.30);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(11,'2020-09-05',1,17.40);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(12,'2020-12-19',1,13.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(13,'2021-01-14',1,11.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(14,'2021-02-02',1,8.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(15,'2021-02-26',1,20.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(16,'2020-05-05',0,22.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(17,'2020-04-01',0,22.00);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(18,'2020-08-05',0,11.20);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(19,'2021-01-28',0,12.30);
INSERT INTO Date_event(id_proposition,date_e, etat_confirmation, heure)
VALUES(20,'2021-01-24',0,22.00);


INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(1,'Tennis','MICHEL',125,'Rue André Karman','Paris',1,1);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(2,'Théâtre','MICHEL',51,'Rue des soeurs','Bobigny',2,2);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(3,'Shopping','GOULET',93,'Avenue de Bouvines','Paris',3,3);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(4,'Sport Tennis','SMITH',125,'Rue André Karman','Paris',4,4);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(5,'Bibliothèque','MACRON',59,'Rue des Lacs','Paris',5,5);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(6,'Football','MARQUIS',57,'Rue Sadi Carnot','Auxerre',6,6);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(7,'Baseball','SMITH',87,'Boulevard de Prague','Nîmes',7,7);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(8,'Compétition Echec','MACRON',34,'Chemin Challet','Paris',8,8);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(9,'Football','BOUGUEROUA',57,'Rue Sadi Carnot','Auxerre',9,9);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(10,'Shopping','CHEN',93,'Avenue de Bouvines','Paris',10,10);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(11,'Théâtre','MICHEL',51,'Rue des Soeurs','Bobigny',12,11);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(12,'Achat de livre','MACRON',59,'Rue des Lacs','Paris',15,12);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(13,'Sport','MICHEL',57,'Rue Sadi Carnot','Auxerre',16,13);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(14,'Randonnée','MARQUIS',99,'Rue des Dunes','Saint-Malo',17,14);
INSERT INTO Evenement (id_evenement, nom, nom_organisateur, numero_rue, nom_rue,ville,id_calendrier,id_proposition)
VALUES(15,'Shopping','CHEN',34,'Rue des roses','Arras',19,15);




INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(1,3,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(1,5,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(1,7,1,3);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(2,2,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(2,3,1,3);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(3,4,1,4);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(3,6,1,4);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(4,3,1,5);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(4,5,1,5);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(4,7,1,5);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(5,2,1,2);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(5,3,1,2);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(6,1,1,7);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(6,7,1,7);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(7,1,1,5);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(7,5,1,5);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(8,2,1,2);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(8,4,1,2);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(8,6,1,2);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, Organisateur)
VALUES(9,1,1,1);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(9,7,1,1);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(10,4,1,6);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(10,6,1,6);


INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(11,2,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(11,3,1,3);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(12,2,1,2);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(12,3,1,2);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(13,3,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(13,5,1,3);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(13,7,1,3);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(14,6,1,7);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(14,7,1,7);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(15,4,1,6);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(15,6,1,6);


INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(16,6,1,6);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(16,7,0,6);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(17,4,0,6);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(17,6,1,6);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(18,1,1,1);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(18,7,0,1);

#INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
#VALUES(18,1,0,7);
#INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
#VALUES(18,7,1,7);




INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(19,1,1,1);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(19,5,0,1);

INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(20,2,1,2);
INSERT INTO Confirmation(id_proposition, id_ami, etat_confirmation, organisateur)
VALUES(20,3,0,2);
