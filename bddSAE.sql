DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS prend_un;
DROP TABLE IF EXISTS Panier;
DROP TABLE IF EXISTS Payement;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Telephone;
DROP TABLE IF EXISTS fournisseur;
DROP TABLE IF EXISTS Adresse;
DROP TABLE IF EXISTS Marque;
DROP TABLE IF EXISTS Etat_telephone;
DROP TABLE IF EXISTS Couleur;
DROP TABLE IF EXISTS Etat;
DROP TABLE IF EXISTS Livraison;
DROP TABLE IF EXISTS user;

CREATE TABLE user(
   id_User INT AUTO_INCREMENT,
   username VARCHAR(255),
   password VARCHAR(255),
   role VARCHAR(255),
   est_actif VARCHAR(3),
   pseudo VARCHAR(255),
   email VARCHAR(255),
   PRIMARY KEY(id_User)
);

CREATE TABLE Livraison(
   id_livraison INT AUTO_INCREMENT,
   date_livraison DATE,
   PRIMARY KEY(id_livraison)
);

CREATE TABLE Etat(
   id_etat INT AUTO_INCREMENT,
   libelle_etat VARCHAR(255),
   id_livraison INT NOT NULL,
   PRIMARY KEY(id_etat),
   FOREIGN KEY(id_livraison) REFERENCES Livraison(id_livraison)
);

CREATE TABLE Couleur(
   id_couleur INT AUTO_INCREMENT,
   libelle_couleur VARCHAR(255),
   PRIMARY KEY(id_couleur)
);

CREATE TABLE Etat_telephone(
   id_etatTelephone INT AUTO_INCREMENT,
   libelle_etatTelephone VARCHAR(255),
   PRIMARY KEY(id_etatTelephone)
);

CREATE TABLE Marque(
   id_marque INT AUTO_INCREMENT,
   libelle_marque VARCHAR(255),
   PRIMARY KEY(id_marque)
);

CREATE TABLE Adresse(
   id_adresse INT AUTO_INCREMENT,
   libelle_adresse VARCHAR(255),
   PRIMARY KEY(id_adresse)
);



CREATE TABLE fournisseur(
    id_fournisseur INT AUTO_INCREMENT,
    libelle_fournisseur VARCHAR(255),
    PRIMARY KEY (id_fournisseur)
);

CREATE TABLE Telephone(
   id_telephone INT AUTO_INCREMENT,
   prix DECIMAL(7,2),
   Modele VARCHAR(255),
   id_marque INT NOT NULL,
   id_etatTelephone INT NOT NULL,
   id_TelephoneCouleur INT NOT NULL,
   id_fournisseur INT NOT NULL,
   stock INT,
   PRIMARY KEY(id_telephone),
   CONSTRAINT fk_id_marque FOREIGN KEY(id_marque) REFERENCES Marque(id_marque),
   CONSTRAINT fk_id_etatTelephone FOREIGN KEY(id_etatTelephone) REFERENCES Etat_telephone(id_etatTelephone),
   CONSTRAINT fk_id_couleur FOREIGN KEY(id_TelephoneCouleur) REFERENCES Couleur(id_couleur),
   CONSTRAINT fk_id_fournisseur FOREIGN KEY(id_fournisseur) REFERENCES fournisseur(id_fournisseur)
);
CREATE TABLE Commande(
   id_Commande INT AUTO_INCREMENT,
   date_achat DATE,
   user_id INT,
   etat_id INT NOT NULL,
   PRIMARY KEY(id_Commande),
   CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES user(id_User),
   CONSTRAINT fk_etat_id FOREIGN KEY(etat_id) REFERENCES Etat(id_etat)
);

CREATE TABLE Payement(
   id_payement INT AUTO_INCREMENT,
   nom_payement VARCHAR(255),
   id_Commande INT NOT NULL,
   PRIMARY KEY(id_payement),
  CONSTRAINT fk_id_Commande  FOREIGN KEY(id_Commande) REFERENCES Commande(id_Commande)
);

CREATE TABLE Panier(
   id_panier INT AUTO_INCREMENT,
   date_ajout DATE,
   prix_unit DECIMAL(7,2),
   quantite_panier INT,
   id_User INT NOT NULL,
   id_payement INT NOT NULL,
   id_telephone INT NOT NULL,
   PRIMARY KEY(id_panier),
   CONSTRAINT fk_id_User FOREIGN KEY(id_User) REFERENCES user(id_User),
   CONSTRAINT fk_id_payement FOREIGN KEY(id_payement) REFERENCES Payement(id_payement),
   CONSTRAINT fk_id_telephone FOREIGN KEY(id_telephone) REFERENCES Telephone(id_telephone)
);

CREATE TABLE prend_un(
   id_User INT,
   id_telephone INT,
   PRIMARY KEY(id_User, id_telephone),
   FOREIGN KEY(id_User) REFERENCES user(id_User),
   FOREIGN KEY(id_telephone) REFERENCES Telephone(id_telephone)
);

CREATE TABLE a(
   id_User INT,
   id_adresse INT,
   PRIMARY KEY(id_User, id_adresse),
   FOREIGN KEY(id_User) REFERENCES user(id_User),
   FOREIGN KEY(id_adresse) REFERENCES Adresse(id_adresse)
);

CREATE TABLE ligne_commande
(
    id_Telephone           INT ,
    id_Commande            INT ,
    prix_unitaire          DECIMAL(7, 2),
    quantite_ligneCommande INT,
    PRIMARY KEY (id_Telephone, id_Commande),
    FOREIGN KEY (id_Telephone) REFERENCES Telephone(id_telephone),
    FOREIGN KEY (id_Commande) REFERENCES Commande (id_Commande)
);



INSERT INTO user (username, password, role, est_actif, pseudo, email) VALUES
('Simon', '1004', 'Administrateur', 'OUI', 'Mizuzun', 'mizuzun03@gmail.com'),
('Adrien', 'éclaté_au_sol', 'Membre', 'NON', 'Kezku', 'Adrien@edu.univ-fcomte.fr'),
('Corentin', 'Patapon', 'Membre', 'NON', 'Patapignouf', 'Patapignouf@gmail.com'),
('Teo', 'Geometrie', 'Administrateur', 'OUI', 'Kitsu', 'Kitsutsu@gmail.com'),
('Mohammed', '1234', 'Membre', 'OUI','Fire_Blaze', 'Explosion@edu.univ-fcomte.fr'),
('Raph', 'Raph', 'Administrateur', 'OUI', 'Razen', 'Razenzen@gmail.com'),
('Julien', 'Pompier', 'Membre', 'OUI', 'DrJulien', 'Juliennnndu39@msn.com'),
('William', 'Kiwi', 'Membre', 'NON', 'Srownel', 'Srownel@gmail.com'),
('Millet', 'Millet', 'Administrateur', 'NON', 'Mimi', 'Millet@edu.univ-fcomte.fr'),
('Giuliana', 'azerty', 'Membre', 'NON', 'Giuliana','giulianatrucphabrisio@gmail.com');

INSERT INTO Livraison (date_livraison) VALUES
('2022-03-05'),
('2021-06-12'),
('2021-12-29'),
('2020-08-05'),
('2022-06-25'),
('2021-04-15'),
('2022-10-07'),
('2020-02-10');



INSERT INTO Etat (libelle_etat, id_livraison) VALUES
('en attente', 3),
('validé', 7),
('en expédié', 4),
('confirmé', 1),
('en attente', 8),
('expédié', 7),
('confirmé', 2),
('en attente', 5),
('validé', 4),
('expédié', 6);

INSERT INTO Couleur (libelle_couleur) VALUES
('Fade'),
('Violet'),
('Rouge'),
('Titane'),
('Bleu'),
('Jaune'),
('Marron'),
('Cosmos'),
('Noir'),
('Gris');


INSERT INTO Etat_telephone (libelle_etatTelephone) VALUES
('occasion'),
('neuf'),
('reconditionné'),
('neuf'),
('occasion'),
('occasion'),
('reconditionné'),
('occasion'),
('reconditionné'),
('neuf');

INSERT INTO Marque (libelle_marque) VALUES
('Samsung'),
('Apple'),
('Honor'),
('Xiaomi'),
('Huawei'),
('Apple'),
('Samsung'),
('Honor'),
('Xiaomi'),
('Huawei');

INSERT INTO Adresse (libelle_adresse) VALUES
('36 rue de la Sablière'),
('54 rue Charles de Gaulle'),
('14 rue de la Concorde'),
('78 rue de la République'),
('25 rue de Macron'),
('45 rue de la Chapelle'),
('35 rue de la Voie'),
(' 13 rue du Coq'),
('50 boulevard Monmarte'),
('30 boulevard Charleroi');


INSERT INTO fournisseur(libelle_fournisseur) VALUES
('ChinaseEntreprise'),
('PSDdistribution'),
('Mfrance'),
('Malgérie'),
('AlidinExport'),
('spalalaExport');


INSERT INTO Telephone(prix,Modele,id_marque,id_etatTelephone,id_TelephoneCouleur,id_fournisseur,stock) VALUES
(1279.00,'Galaxy S21 Ultra 5G',1,10,10,1,15),
(1259.00,'IPHONE 13 PRO MAX',2,2,2,2,23),
(679.00,'HUAWEI MATE 40 PRO',10,1,3,3,14),
(500.00,'Galaxy S20',7,8,9,1,4),
(699.99,'IPHONE 13',6,9,1,2,5),
(400.00,'HUAWEI MATE 30 PRO',5,4,5,6,27),
(450.99,'XIAOMI MI 11',9,3,7,3,2),
(200.00,'XIAOMI MI 8',4,5,8,1,3),
(249.99,'HONOR 50 LITE',3,7,4,6,4),
(499.90,'HONOR 50',8,6,6,5,11);



INSERT INTO Commande (date_achat,user_id,etat_id) VALUES
('2022-03-05',1,1),
('2021-06-12',2,2),
('2021-12-29',3,3),
('2020-08-05',4,4),
('2022-06-25',5,5),
('2021-04-15',6,6),
('2022-10-07',7,7),
('2020-02-10',8,8);



INSERT INTO Payement( nom_payement, id_Commande) VALUES
('carte bancaire',2),
('paypal',3),
('carte prépayé',1),
('paypal',4),
('carte bancaire',6),
('carte bancaire',5),
('paypal',7),
('carte prépayé',8),
('carte prépayé',1);

INSERT INTO Panier( date_ajout, id_telephone, id_User, prix_unit, quantite_panier,  id_payement) VALUES
('2011-04-21',1,3,1,NULL,2),
('2003-04-29',2,1,3,NULL,1),
('2003-04-23',3,2,2,NULL,1),
('2013-06-21',4,4,1,NULL,1 ),
('2011-04-21',6,6,2,NULL,2 ),
('2005-05-10',5,7,3,NULL,1 ),
('1977-09-09',7,5,1, NULL,1 ),
('2009-04-14',8,8,1,NULL,1 ),
('2010-01-21',10,9,2,NULL,3 );


INSERT INTO ligne_commande(id_telephone, id_Commande, prix_unitaire, quantite_ligneCommande) VALUES
(1,1,NULL,1),
(2,3,NULL,1),
(3,4,NULL,1),
(4,5,NULL,2),
(6,7,NULL,1),
(8,8,NULL,1),
(5,6,NULL,1),
(7,5,NULL,1),
(2,2,NULL,1);


























