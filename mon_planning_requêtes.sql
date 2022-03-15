#1. Afficher toutes les informations relatives au dernier évènement qui a bien eu lieu : 
#nom, date, nom de l’organisateur, liste des participants, endroit, dépenses.
SELECT e.nom, c.jour,c.mois,c.annee, e.nom_organisateur, e.numero_rue,e.nom_rue,e.ville,c.depense, personne.nom as participants
FROM evenement e join calendrier c using (id_calendrier) join confirmation using(id_proposition) 
join ami using(id_ami) join personne using (telephone) order by id_evenement;

#2. Donner la liste des amis qui partagent avec vous le même loisir (donné en paramètre).
#En supposant que c'est la lecture

SELECT Personne.nom, Personne.prenom FROM personne join pratiquer using(telephone) 
Where nom_loisir = 'Lecture';

#3. Donner le nombre de séances de révision organisées pendant le mois dernier.

SELECT COUNT(id_seance) as Nbr_séance FROM seance_revision join calendrier 
using(id_calendrier)
WHERE mois = 'Février';

#4. Donner la liste des camarades de classe qui ne sont pas considérés comme amis.
SELECT p.nom, p.prenom FROM camarade join personne p using(telephone)
WHERE id_camarade not in  ( SELECT id_camarade FROM camarade join ami using(telephone));

#5. Donner la liste des amis qui habitent la même ville où aura lieu un évènement donné.
#On doit retrouver les personnes habitant à paris et bobigny

SELECT DISTINCT p.nom, p.prenom ,p.ville FROM ami join personne p using(telephone)
 join evenement on p.ville = evenement.ville;

#6. Donner la liste des adresses favorites qui n’ont jamais hébergé d’évènements jusque-là. 
SELECT a.numero_rue, a.nom_rue, a.ville, a.nom_loisir FROM adresses_loisir a 
WHERE a.id_adresse not in (SELECT a.id_adresse FROM  adresses_loisir a join evenement on a.nom_rue = evenement.nom_rue);

#7. Afficher la liste des dépenses ainsi que des rentrées d’argent du mois en cours.

SELECT DISTINCT c.mois,c.jour, c.depense, r.somme_revenu FROM calendrier c join revenu r on r.mois_revenu = c.mois
WHERE mois = 'février';
#Avec somme_revenu qui ne compte que 1 fois

#8. Donner le taux d’acceptation des évènements (nombre d’évènements validés sur le nombre total d’évènements proposés) pour chaque organisateur.

select distinct (a.count_one / b.count_two) * 100 as final_count, a.organisateur, a.nom from 
(select COUNT(distinct id_proposition) as count_one, confirmation.organisateur,nom
from date_event join confirmation using(id_proposition) join ami on confirmation.organisateur = ami.id_ami join personne using(telephone)
where date_event.etat_confirmation = "1"
group by organisateur) a,  #Le nombre de proposition validé
(select COUNT(distinct id_proposition) as count_two, confirmation.organisateur
from date_event join confirmation using(id_proposition)
group by organisateur) b   #Le nombre de proposition 
where a.organisateur= b.organisateur;

# LES VUES 
#1. Créer une vue appelée « ambition » qui permet de lister tous les objectifs définis 
#pendant l’année dernière, et la cagnotte rassemblée pour chaque objectif.

DROP VIEW IF EXISTS ambition;
CREATE VIEW ambition AS 
SELECT c.id_cagnotte, c.montant, o.nom, o.annee FROM cagnotte c join objectif o using(id_objectif)
WHERE annee = '2020';
SELECT * FROM ambition;

#2. Créer une vue appelée « top_organisateurs » qui affiche les deux amis qui ont 
#organisé le plus d’évènements jusque-là.

DROP VIEW IF EXISTS top_organisateurs;
CREATE VIEW top_organisateurs AS 
SELECT COUNT(distinct id_proposition) as compteur, confirmation.organisateur, nom, prenom
from date_event join confirmation using(id_proposition) join ami on confirmation.organisateur = ami.id_ami join personne using(telephone)
where date_event.etat_confirmation = "1"
group by organisateur
order by compteur desc limit 2;

Select * FROM top_organisateurs;

#3. Créer une vue appelée « aujourd’hui », qui donne la liste des évènements et révisions 
#prévues pour aujourd’hui dans le calendrier, classées par horaire.
#En supposant que nous sommes le 26 février 2021

DROP VIEW IF EXISTS aujourd_hui;
CREATE VIEW aujourd_hui AS 
SELECT DISTINCT c.*, e.nom as nom_event, s.matiere as revision from calendrier c left join evenement e using(id_calendrier)
 left join seance_revision s using(id_calendrier)
WHERE jour = 26 and mois = 'Février' and annee = 2021 ORDER BY heure;

SELECT * FROM aujourd_hui;

#4. Créer une vue appelée « trouble_fête », qui donne le nom de l’ami qui refuse le plus 
#de dates proposées pour des évènements.

DROP VIEW IF EXISTS trouble_fête;
CREATE VIEW trouble_fête AS 
SELECT distinct COUNT(distinct id_proposition) as compteur,c.id_ami, nom, prenom
from confirmation c join ami using(id_ami) join personne using(telephone)
where c.etat_confirmation = 0
group by c.id_ami
order by compteur desc limit 1;

SELECT * FROM trouble_fête;


#5. Créer une vue appelée « meilleur_réseau », qui donne le réseau social où sont actifs 
#le plus grand nombre d’amis

CREATE VIEW Meilleur_Reseau AS 
SELECT nom_reseau FROM Reseau 
GROUP BY  nom_reseau 
ORDER BY COUNT(nom_reseau) desc LIMIT 1; 
SELECT * FROM Meilleur_Reseau;

SELECT * FROM meilleur_reseau;

#6. Créer une vue appelée « rêve » qui donne la liste des objectifs dont le montant 
#dépasse de 4 fois toutes les cagnottes annuelles rassemblées jusque-là. 

DROP VIEW IF EXISTS rêve;
select objectif.nom, objectif.somme_cible
from cagnotte, objectif
group by nom
having objectif.somme_cible >= 4 * sum(cagnotte.montant);

SELECT * FROM rêve;

#7. Créer une vue appelée « horaire_a_eviter » qui donne l’horaire de début le plus 
#refusé parmi tous les horaires proposés.

DROP VIEW IF EXISTS horaire_a_eviter;
CREATE VIEW horaire_a_eviter AS 
select heure, count(distinct id_proposition) as compteur
from date_event
where etat_confirmation = 0
group by heure
order by compteur desc limit 1;

SELECT * FROM horaire_a_eviter;

#8. Créer une vue appelée « potentiels_amis » qui donne les deux camarades avec 
#lesquels tu révises le plus. 

DROP VIEW IF EXISTS potentiels_amis;
CREATE VIEW potentiels_amis AS 
select id_camarade, count(distinct id_seance) as participation, nom, prenom
from participation_revision join camarade using(id_camarade) join personne using(telephone) 
WHERE id_camarade not in (SELECT id_camarade FROM camarade join ami using(telephone))
group by id_camarade
order by participation desc limit 2;

SELECT * FROM potentiels_amis;