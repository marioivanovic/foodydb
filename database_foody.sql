-- CREATION DATABASE --

CREATE DATABASE Foody;


-- CREATION DES TABLES 


CREATE TABLE Categorie (
    CodeCateg INT NOT NULL AUTO_INCREMENT,
    NomCateg VARCHAR(15) NOT NULL,
    Descriptionn VARCHAR(255),
     CONSTRAINT `PK_Categories` PRIMARY KEY (CodeCateg)
   );

CREATE INDEX NomCateg ON `Categorie` (`NomCateg`);

CREATE TABLE Clientt (
    Codecli VARCHAR(5) NOT NULL,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) NOT NULL,
    Fonction VARCHAR(45) NOT NULL,
    Adresse VARCHAR(45),
    Ville VARCHAR(25) ,
    Region VARCHAR(25),
    Codepostal VARCHAR(10),
    Pays VARCHAR(25) ,
    Tel VARCHAR(25) ,
    Fax VARCHAR(25),
	CONSTRAINT `PK_Clientt` PRIMARY KEY (Codecli)
);

CREATE INDEX `Ville` ON `Clientt` (`Ville`);

CREATE INDEX `Societe` ON `Clientt` (`Societe`);

CREATE INDEX `Codepostal` ON `Clientt` (`Codepostal`);

CREATE INDEX `Region` ON `Clientt` (`Region`);

CREATE TABLE `Employe` (
    NoEmp INT NOT NULL AUTO_INCREMENT,
    Nom VARCHAR(50) NOT NULL,
    Prenom VARCHAR(50) NOT NULL,
    Fonction VARCHAR(50) ,
    TitreCourtoisie VARCHAR(50),
    DateNaissance DATETIME,
    DateEmbauche DATETIME ,
    Adresse VARCHAR(60),
    Ville VARCHAR(50),
    Region VARCHAR(50),
    Codepostal VARCHAR(50) ,
    Pays VARCHAR(50) ,
    TelDom VARCHAR(20) ,
    Extension VARCHAR(50),
    RendCompteA INT, 
    REFERENCES employe(NoEmp),
    CONSTRAINT `PK_Employe` PRIMARY KEY (NoEmp)
);

CREATE INDEX `Nom` ON `Employe` (`Nom`);

CREATE INDEX `Codepostal` ON `Employe` (`Codepostal`);

CREATE TABLE DetailsCommande (
    NoCom INT NOT NULL,
    RefProd INT NOT NULL,
    PrixUnit DECIMAL(10,4) NOT NULL DEFAULT 0,
    Qte INT NOT NULL DEFAULT 1,
    Remise Double NOT NULL DEFAULT 0,
    CONSTRAINT `PK_DetailsCommande` PRIMARY KEY (NoCom , RefProd)
);

CREATE TABLE Commande (
    NoCom INT NOT NULL AUTO_INCREMENT,
    CodeCli VARCHAR(10) ,
    NoEmp INT,
    DateCom DATETIME ,
    ALivAvant DATETIME,
    DateEnv DATETIME,
    NoMess INT ,
    Portt DECIMAL(10,4) DEFAULT 0,
    Destinataire VARCHAR(50) ,
    AdrLiv VARCHAR(50) ,
    VilleLiv VARCHAR(50) ,
    RegionLiv VARCHAR(50),
    CodePostalLiv VARCHAR(20),
    PaysLiv VARCHAR(25) ,
    PRIMARY KEY (NoCom)
);
CREATE INDEX `DateCom` ON `Commande` (`DateCom`);

CREATE INDEX `DateEnv` ON `Commande` (`DateEnv`);

CREATE INDEX `CodePostalLiv` ON `Commande` (`CodePostalLiv`);

CREATE TABLE Produit (
    RefProd INT NOT NULL AUTO_INCREMENT,
    NomProd VARCHAR(50) NOT NULL,
    NoFour INT ,
    CodeCateg INT,
    QteParUnit VARCHAR(20) ,
    PrixUnit DECIMAL(10,4) default 0,
    UnitesStock SMALLINT DEFAULT 0,
    UnitesCom SMALLINT DEFAULT 0,
    NiveauReap SMALLINT DEFAULT 0,
    Indisponible BIT NOT NULL default 0,
    CONSTRAINT `PK_Produit` PRIMARY KEY (RefProd)
);

CREATE INDEX `NomProd` ON `Produit` (`NomProd`);

CREATE TABLE Messager (
    NoMess INT NOT NULL AUTO_INCREMENT,
    NomMess VARCHAR(50) NOT NULL,
    Tel VARCHAR(20),
    CONSTRAINT `PK_Shippers` PRIMARY KEY (NoMess)
);

CREATE TABLE Fournisseur (
    NoFour INT NOT NULL AUTO_INCREMENT,
    Societe VARCHAR(45) NOT NULL,
    Contact VARCHAR(45) ,
    Fonction VARCHAR(45) ,
    Adresse VARCHAR(255) ,
    Ville VARCHAR(45),
    Region VARCHAR(45),
    CodePostal VARCHAR(10) ,
    Pays VARCHAR(45) ,
    Tel VARCHAR(20) ,
    Fax VARCHAR(20),
    PageAccueil MEDIUMTEXT,
    CONSTRAINT `PK_Fournisseur` PRIMARY KEY (NoFour)
);

CREATE INDEX `Societe` ON `Fournisseur` (`Societe`);

CREATE INDEX `CodePostal` ON `Fournisseur` (`CodePostal`);


-- AJOUT DE LA DATA DANS CHAQUE TABLE DE LA DATABASE --



LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/produit.csv' INTO TABLE Produit FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/client.csv' INTO TABLE Client FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/commande.csv' INTO TABLE Commande FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/detailscommande.csv' INTO TABLE DetailsCommande FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/employe.csv' INTO TABLE Employe FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/categorie.csv' INTO TABLE Categorie FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/fournisseur.csv' INTO TABLE Fournisseur FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;

LOAD DATA LOCAL INFILE 'Desktop/CDA_Java_Aulnay/week_1/Back/data/messager.csv' INTO TABLE Messager FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 LINES;



-- REQUETES --



SELECT * FROM Produit ORDER BY PrixUnit DESC LIMIT 10;
SELECT * FROM Produit WHERE PrixUnit DESC LIMIT 3;


SELECT * FROM Client WHERE Ville="Paris" AND Fax IS NULL;
SELECT * FROM Client WHERE Pays IN ("France","Germany","Canada");
SELECT Societe FROM Client WHERE Societe LIKE '%restaurant%';


SELECT Descriptionn, NomCateg FROM Categorie;
SELECT Pays, Ville FROM Client ORDER BY Pays ASC, Ville DESC;
SELECT UPPER(RefProd), UPPER(NomProd), NoFour, PrixUnit FROM Produit WHERE NoFour=8;
SELECT NoCom, PrixUnit, Qte, Remise, (PrixUnit*Remise) AS MontantRemise, ((PrixUnit-(PrixUnit*Remise))* Qte) AS MontantTotalAPayer FROM DetailsCommande WHERE NoCom=10251;
SELECT RefProd, PrixUnit, UnitesStock, UnitesStock AS DispoProd FROM Produit WHERE UnitesStock > 1;


SELECT CONCAT(Adresse, Ville, Codepostal, Pays) AS Adresse_complete FROM Client;
SELECT RIGHT(CodeCli,2) as CodeCli FROM Client;
SELECT LOWER(Societe)FROM Client;
UPDATE Client SET Fonction="Freelance" WHERE Fonction="Owner";
SELECT Societe, Contact, Fonction FROM Client WHERE Fonction LIKE '%Manager%';


SELECT DATE_FORMAT(DateCom, "%W") FROM Commande;
SELECT DATE_FORMAT(DateCom, "%W"),  CASE WHEN DATE_FORMAT(DateCom, "%W")='Saturday' THEN ‘Weekend' WHEN DATE_FORMAT(DateCom, "%W")='Sunday' THEN 'Weekend' ELSE ‘Week Day' END AS 'Days' FROM Commande;
SELECT NoCom, CodeCli, Destinataire, DATEDIFF(ALivAvant, DateCom) FROM Commande;
SELECT NoCom, CodeCli, Destinataire, ADDDATE(ALivAvant, INTERVAL 1 MONTH) FROM Commande AS delaiRelance;


SELECT COUNT(Fonction) FROM Employe WHERE Fonction="Sales Manager";
SELECT COUNT(*) FROM Produit WHERE CodeCateg = 1 AND NoFour IN (1, 18);
SELECT COUNT(DISTINCT PaysLiv) FROM Commande;


SELECT MIN(CAST(Portt AS FLOAT)) AS PortMinimum, MAX(CAST(Portt AS FLOAT)) AS PortMaximum FROM Commande;
SELECT ROUND(AVG(Portt), 2) as PortMoyen FROM Commande WHERE CodeCli = "QUICK";
SELECT SUM(Portt) FROM Commande WHERE NoMess=1;
SELECT SUM(Portt) FROM Commande WHERE NoMess=2;
SELECT SUM(Portt) FROM Commande WHERE NoMess=3;


SELECT Fonction, COUNT(*) AS NbrEmployes FROM Employe GROUP BY Fonction;
SELECT NoFour, COUNT(*) AS NbrProduitsFournis , COUNT(DISTINCT CodeCateg) AS NbrCategories FROM Produit GROUP BY NoFour;
SELECT NoFour, CodeCateg, AVG(PrixUnit) AS PrixMoyen FROM Produit GROUP By NoFour, CodeCateg;


SELECT NoFour FROM Produit GROUP BY NoFour HAVING COUNT(*)=1;
SELECT NoFour, CodeCateg FROM Produit GROUP BY NoFour, CodeCateg HAVING COUNT(DISTINCT CodeCateg)=1;
SELECT NoFour, NomProd, PrixUnit FROM Produit WHERE PrixUnit >= 50 GROUP BY NoFour HAVING PrixUnit = MAX(PrixUnit);


SELECT * FROM Produit NATURAL JOIN Fournisseur;
SELECT * FROM Client NATURAL JOIN Commande WHERE Societe="Lazy K Kountry Store";
SELECT NomMess, COUNT(*) AS "Nombre Commandes" FROM Messager NATURAL JOIN Commande GROUP BY NomMess;


SELECT * FROM Produit INNER JOIN Fournisseur ON Produit.NoFour = Fournisseur.NoFour;
SELECT * FROM Commande INNER JOIN Client ON Commande.CodeCli = Client.CodeCli WHERE Societe = "Lazy K Kountry Store";
SELECT NomMess, COUNT(*) FROM Commande INNER JOIN Messager ON Commande.NoMess = Messager.NoMess GROUP BY NomMess;


SELECT NomProd, COUNT(DISTINCT NoCom) FROM Produit LEFT OUTER JOIN DetailsCommande ON Produit.RefProd = DetailsCommande.RefProd GROUP BY NomProd;
SELECT NomProd FROM Produit LEFT OUTER JOIN DetailsCommande ON Produit.RefProd = DetailsCommande.RefProd GROUP BY NomProd HAVING COUNT(DISTINCT NoCom)=0;
SELECT Nom, Prenom FROM Employe LEFT OUTER JOIN Commande ON Employe.NoEmp = Commande.NoEmp GROUP BY Nom, Prenom HAVING COUNT(DISTINCT NoCom)=0;


SELECT * FROM Produit, Fournisseur WHERE Produit.NoFour = Fournisseur.NoFour;
SELECT * FROM Commande, Client WHERE Commande.CodeCli = Client.CodeCli AND Societe="Lazy K Kountry Store";
SELECT NomMess, COUNT(*) FROM Commande, Messager WHERE Commande.NoMess = Messager.NoMess GROUP BY NomMess;


SELECT Nom, Prenom FROM Employe WHERE NoEmp NOT IN (SELECT NoEmp FROM Commande);
SELECT COUNT(*) FROM Produit WHERE NoFour= (SELECT NoFour FROM Fournisseur WHERE Societe="Ma Maison");
SELECT COUNT(*) FROM Commande WHERE NoEmp IN (SELECT NoEmp FROM Employe WHERE RendCompteA = (SELECT NoEmp From Employe WHERE Nom = "Buchanan" AND Prenom="Steven"));


SELECT NomProd FROM Produit WHERE NOT EXISTS (SELECT * FROM DetailsCommande WHERE RefProd = Produit.RefProd);
SELECT Societe FROM Fournisseur WHERE NOT EXISTS (SELECT * FROM Produit, DetailsCommande, Commande WHERE Produit.RefProd = DetailsCommande.RefProd AND DetailsCommande.NoCom = Commande.NoCom AND PaysLiv = "France" AND NoFour = Fournisseur.NoFour);
SELECT Nom, Prenom, Pays From Employe WHERE Fonction="%Representative%" UNION SELECT Nom, Prenom, Pays FROM Employe WHERE Pays="UK";
SELECT Societe, Pays FROM Client , Commande , Employe  WHERE Client.CodeCli = Commande.CodeCli AND Commande.NoEmp = Employe.NoEmp AND Employe.Ville = "London" UNION SELECT Societe, Client.Pays FROM Client, Commande, Messager WHERE Client.CodeCli = Commande.CodeCli AND Commande.NoMess = Messager.NoMess AND NomMess = "Speedy Express";
SELECT Nom, Prenom, Fonction, Ville, Pays FROM Employe WHERE Pays='UK' AND Fonction LIKE '%Representative%';