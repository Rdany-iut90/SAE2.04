DROP TABLE IF EXISTS donne_un;
DROP TABLE IF EXISTS ligne_commande;
DROP TABLE IF EXISTS a;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Avis;
DROP TABLE IF EXISTS Panier;
DROP TABLE IF EXISTS Telephone;
DROP TABLE IF EXISTS Entrepot;
DROP TABLE IF EXISTS Adresse;
DROP TABLE IF EXISTS Marque;
DROP TABLE IF EXISTS Etat_telephone;
DROP TABLE IF EXISTS Couleur;
DROP TABLE IF EXISTS Etat;
DROP TABLE IF EXISTS Livraison;
DROP TABLE IF EXISTS payement;
DROP TABLE IF EXISTS user;

CREATE TABLE IF NOT EXISTS user
(
    user_id   INT AUTO_INCREMENT,
    username  VARCHAR(25),
    password  VARCHAR(255),
    role      VARCHAR(25),
    est_actif VARCHAR(1),
    email     VARCHAR(50),
    PRIMARY KEY (user_id)
);

CREATE TABLE payement(
   id_payement INT NOT NULL AUTO_INCREMENT,
   nom_payement VARCHAR(255),
   prix INT,
   user_id INT,
   PRIMARY KEY(id_payement),
   FOREIGN KEY (user_id) REFERENCES user(user_id)
);

CREATE TABLE Livraison(
   id_livraison INT NOT NULL AUTO_INCREMENT,
   date_livraison DATE,
   PRIMARY KEY(id_livraison)
);

CREATE TABLE Etat(
   id_etat INT NOT NULL AUTO_INCREMENT,
   libelle_etat VARCHAR(255),
   id_livraison INT NOT NULL,
   PRIMARY KEY(id_etat),
   FOREIGN KEY(id_livraison) REFERENCES Livraison(id_livraison)
);

CREATE TABLE Couleur(
   id_couleur INT NOT NULL AUTO_INCREMENT,
   libelle_couleur VARCHAR(255),
   PRIMARY KEY(id_couleur)
);

CREATE TABLE Etat_telephone(
   id_etatTelephone INT NOT NULL AUTO_INCREMENT,
   libelle_etatTelephone VARCHAR(255),
   PRIMARY KEY(id_etatTelephone)
);

CREATE TABLE Marque(
   id_marque INT NOT NULL AUTO_INCREMENT,
   libelle_marque VARCHAR(255),
   PRIMARY KEY(id_marque)
);

CREATE TABLE Adresse(
   id_adresse INT NOT NULL AUTO_INCREMENT,
   libelle_adresse VARCHAR(255),
   PRIMARY KEY(id_adresse)
);




CREATE TABLE Entrepot(
   id_entrepot INT AUTO_INCREMENT,
   stockTelephone INT,
   PRIMARY KEY(id_entrepot)
);

CREATE TABLE Telephone(
   id_telephone INT NOT NULL  AUTO_INCREMENT,
   prix DECIMAL(7,2),
   Modele VARCHAR(255),
   image  VARCHAR(255),
   id_marque INT NOT NULL,
   id_etatTelephone INT NOT NULL,
   id_TelephoneCouleur INT NOT NULL,
   id_entrepot INT,
   PRIMARY KEY(id_telephone),
   CONSTRAINT fk_id_marque FOREIGN KEY(id_marque) REFERENCES Marque(id_marque),
   CONSTRAINT fk_id_etatTelephone FOREIGN KEY(id_etatTelephone) REFERENCES Etat_telephone(id_etatTelephone),
   CONSTRAINT fk_id_couleur FOREIGN KEY(id_TelephoneCouleur) REFERENCES Couleur(id_couleur),
   CONSTRAINT fk_id_entrepot FOREIGN KEY(id_entrepot) REFERENCES Entrepot(id_entrepot)
);



CREATE TABLE Panier(
   id_panier INT NOT NULL AUTO_INCREMENT,
   date_ajout DATE,
   prix_unit DECIMAL(7,2),
   quantite INT,
   id_User INT NOT NULL,
   id_telephone INT NOT NULL,
   PRIMARY KEY(id_panier),
   CONSTRAINT fk_id_User FOREIGN KEY(id_User) REFERENCES user(user_id),
   CONSTRAINT fk_id_telephone FOREIGN KEY(id_telephone) REFERENCES Telephone(id_telephone)
);



CREATE TABLE Avis(
   id_avis INT AUTO_INCREMENT,
   nbrétoile INT,
   commentaire VARCHAR(255),
   PRIMARY KEY(id_avis)
);

CREATE TABLE Commande(
   id_Commande INT NOT NULL AUTO_INCREMENT,
   date_achat DATE,
   user_id INT,
   etat_id INT NOT NULL,
   PRIMARY KEY(id_Commande),
   CONSTRAINT fk_user_id FOREIGN KEY(user_id) REFERENCES user(user_id),
   CONSTRAINT fk_etat_id FOREIGN KEY(etat_id) REFERENCES Etat(id_etat)
);

CREATE TABLE a(
   id_User INT,
   id_adresse INT,
   PRIMARY KEY(id_User, id_adresse),
   FOREIGN KEY(id_User) REFERENCES user(user_id),
   FOREIGN KEY(id_adresse) REFERENCES Adresse(id_adresse)
);

CREATE TABLE ligne_commande
(
    id_Telephone          INT ,
    id_Commande           INT  ,
    prix_unitaire          DECIMAL(7, 2),
    quantite_ligneCommande INT,
    PRIMARY KEY (id_Telephone, id_Commande),
    FOREIGN KEY (id_Telephone) REFERENCES Telephone(id_telephone),
    FOREIGN KEY (id_Commande) REFERENCES Commande (id_Commande)
);

CREATE TABLE donne_un(
   id_Client INT,
   id_telephone INT,
   id_avis INT,
   PRIMARY KEY(id_Client, id_telephone, id_avis),
   FOREIGN KEY(id_Client) REFERENCES user(user_id),
   FOREIGN KEY(id_telephone) REFERENCES Telephone(id_telephone),
   FOREIGN KEY(id_avis) REFERENCES Avis(id_avis)
);



INSERT INTO user (username, password, role, est_actif, email) VALUES
    ('admin', 'sha256$pBGlZy6UukyHBFDH$2f089c1d26f2741b68c9218a68bfe2e25dbb069c27868a027dad03bcb3d7f69a', 'ROLE_admin', 1, 'admin@admin.fr'),
    ('client', 'sha256$Q1HFT4TKRqnMhlTj$cf3c84ea646430c98d4877769c7c5d2cce1edd10c7eccd2c1f9d6114b74b81c4', 'ROLE_client', 1, 'client@client.fr'),
    ('client2', 'sha256$ayiON3nJITfetaS8$0e039802d6fac2222e264f5a1e2b94b347501d040d71cfa4264cad6067cf5cf3', 'ROLE_client', 1, 'client2@client2.fr'),
    ('Mafuo', 'sha256$Q1HFT4TKRqnMhlTj$cf3c84ea646430c98d4877769c7c5d2cce1edd10c7eccd2c1f9d6114b74b81c4', 'ROLE_client', 1, 'Mafuo@gmail.com');

INSERT INTO payement(nom_payement,prix) VALUES
  ('carte bleue',NULL),
  ('carte bleue',NULL),
  ('paypal',NULL),
  ('carte bleue ',NULL),
  ('paypal',NULL),
  ('carte bleue',NULL);

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


INSERT INTO Entrepot(stockTelephone) VALUES
(9),
(4),
(6),
(7),
(1),
(4);


INSERT INTO Telephone(prix,Modele,image,id_marque,id_etatTelephone,id_TelephoneCouleur,id_entrepot) VALUES
(1279.00,'Galaxy S21 Ultra 5G','samsung.jpg',1,10,10,1),
(1259.00,'IPHONE 13 PRO MAX','iphone13.png',2,2,2,2),
(679.00,'HUAWEI MATE 40 PRO','huaweip40.jpg',10,1,3,3),
(500.00,'Galaxy S20','samsungs20.jpg',7,8,9,1),
(699.99,'IPHONE 13','iphone13.jpg',6,9,1,2),
(400.00,'HUAWEI MATE 30 PRO','huaweip30.jpg',5,4,5,6),
(450.99,'XIAOMI MI 11','xiaomi11.png',9,3,7,3),
(200.00,'XIAOMI MI 8','xiaomi8.png',4,5,8,1),
(249.99,'HONOR 50 LITE','honorlite.png',3,7,4,6),
(499.90,'HONOR 50','honor50.jpg',8,6,6,5);

INSERT INTO Panier( date_ajout, id_telephone, id_User, quantite) VALUES
('2011-04-21',1,3,0),
('2003-04-29',2,1,0),
('2003-04-23',3,2,0),
('2013-06-21',4,4,1),
('2011-04-21',6,2,0),
('2005-05-10',5,3,0),
('1977-09-09',7,1, 0),
('2009-04-14',8,2,0),
('2010-01-21',10,3,0);



INSERT INTO Avis (nbrétoile, commentaire)  VALUES
(4,'très bon telephone mais la batterie se decharge rapidement'),
(1,'le telephone ne s alume pas'),
(3,'telephone moyen'),
(5,'telephone parfait');

INSERT INTO Commande (date_achat,user_id,etat_id) VALUES
('2022-03-05',1,1),
('2021-06-12',2,2),
('2021-12-29',3,3),
('2020-08-05',1,4),
('2022-06-25',2,5),
('2021-04-15',1,6),
('2022-10-07',2,7),
('2020-02-10',1,8);

INSERT INTO donne_un (id_Client,id_telephone,id_avis) VALUES
(2,10,1),
(3,4,2),
(2,9,3),
(3,5,4);
