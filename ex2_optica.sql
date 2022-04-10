CREATE SCHEMA optica;


CREATE TABLE IF NOT EXISTS `Optica`.`Proveidor` (
  `idProveidor` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `carrer` VARCHAR(45) NULL,
  `número` VARCHAR(45) NULL,
  `pis` VARCHAR(45) NULL,
  `porta` VARCHAR(45) NULL,
  `ciutat` VARCHAR(25) NULL,
  `codi-postal` VARCHAR(10) NULL,
  `pais` VARCHAR(25) NULL,
  `telèfon` VARCHAR(9) NULL,
  `fax` VARCHAR(9) NULL,
  `NIF` VARCHAR(15) NULL,
  PRIMARY KEY (`idProveidor`));

CREATE TABLE IF NOT EXISTS `Optica`.`client` (
  `idclient` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `adreça postal` VARCHAR(45) NULL,
  `telèfon` VARCHAR(45) NULL,
  `clientcol` VARCHAR(45) NULL,
  `correu electrònic` VARCHAR(45) NULL,
  `data de registre` VARCHAR(45) NULL,
  `recommanat` VARCHAR(45) NULL,
  PRIMARY KEY (`idclient`));


CREATE TABLE IF NOT EXISTS `Optica`.`Ulleres` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `graduació` VARCHAR(45) NULL,
  `muntura` VARCHAR(45) NULL,
  `color_muntura` VARCHAR(45) NULL,
  `color_vidres` VARCHAR(45) NULL,
  `preu` DECIMAL(6,2) NULL,
  `Proveidor_idProveidor` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Marca_Proveidor_idx` (`Proveidor_idProveidor` ASC) VISIBLE,
  CONSTRAINT `fk_Marca_Proveidor`
    FOREIGN KEY (`Proveidor_idProveidor`)
    REFERENCES `Optica`.`Proveidor` (`idProveidor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE IF NOT EXISTS `Optica`.`vendes` (
  `id-vendes` INT NOT NULL,
  `empleat` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `client_idclient` INT NOT NULL,
  `Ulleres_id` INT NOT NULL,
  PRIMARY KEY (`id-vendes`),
  INDEX `fk_vendes_client1_idx` (`client_idclient` ASC) VISIBLE,
  INDEX `fk_vendes_Ulleres1_idx` (`Ulleres_id` ASC) VISIBLE,
  CONSTRAINT `fk_vendes_client1`
    FOREIGN KEY (`client_idclient`)
    REFERENCES `Optica`.`client` (`idclient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vendes_Ulleres1`
    FOREIGN KEY (`Ulleres_id`)
    REFERENCES `Optica`.`Ulleres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- proveidor
INSERT INTO `optica`.`proveidor` (`idProveidor`, `nom`, `carrer`, `número`, `pis`, `porta`, `ciutat`,
`codi-postal`, `pais`, `telèfon`, `fax`, `NIF`)
VALUES
(1, 'Provider-One', 'Highland St', '121', '3', '6', 'London', 'SW1234', 'England',
'123456789', '445588965', 'FE123456');

INSERT INTO `optica`.`proveidor` (`idProveidor`, `nom`, `carrer`, `número`, `pis`, `porta`, `ciutat`,
`codi-postal`, `pais`, `telèfon`, `fax`, `NIF`)
VALUES
(2, 'Provider-Two', 'Santa Gloria', '14', '4', '4C', 'Roma', 'RM7676', 'Italia',
'552778899', '111222333', 'FE123456');

-- clients
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (1,'Carla Mendez', '08014', '123654654', 'd', 'carla@mail.com', 2020-12-12, 'YES');
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (2,'Rita Sanchez', '08016', '619885522', 'd', 'rita27@mail.com', 2022-10-10, 'NO');
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (3,'Pep Garolli', '08021', '670115599', 'd', 'PG@mail.com', 2021-12-12, 'NO');
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (4,'Ulises Marques', '08014', '681448811', 'd', 'uli1983@mail.com', 2022-01-01, 'YES');
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (5,'Julia Greiss', '08016', '617885533', 'd', 'greiss11@mail.com', 2021-01-01, 'NO');
INSERT INTO `optica`.`client` (`idclient`, `nom`, `adreça postal`, `telèfon`, `clientcol`, `correu electrònic`, `data de registre`, `recommanat`)
VALUES (6,'Ulises Marques', '08014', '619998877', 'd', 'uli1983@mail.com', 2022-03-03, 'YES');

-- ulleres
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (1, 'chanel', '+0.5', 'metal', 'grey', 'blue', '9100', 1);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (2, 'chanel', '+0.5', 'plastic', 'white', 'clear', '1500', 1);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (3, 'ray', '+0.5', 'metal', 'grey', 'blue', '4500', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (4, 'blue-jean', '+0.5', 'plastic', 'pink', 'blue', '6200', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (5, 'chanel', '+2.5', 'plastic', 'red', 'clear', '8500', 1);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (6, 'blue-jean', '-1.5', 'plastic', 'grey', 'clear', '6000', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (7, 'blue-jean', '+1.5', 'metal', 'blue', 'clear', '4000', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (8, 'ray', '+1.5', 'plastic', 'black', 'clear', '7500', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (9, 'ray', '-0.5', 'plastic', 'grey', 'clear', '8000', 2);
INSERT INTO `optica`.`ulleres` (`id`,`marca`, `graduació`, `muntura`, `color_muntura`, `color_vidres`, `preu`, `Proveidor_idProveidor`)
VALUES (10, 'chanel', '-0.5', 'metal', 'black', 'clear', '9900', 1);

-- vendes
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(1, 'Maria Lens', '2020-07-07', '1', '1');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(2, 'Maria Lens', '2021-04-04', '6', '3');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(3, 'Maria Lens', '2021-11-11', '3', '6');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(4, 'Toni Garcia', '2021-12-12', '5', '8');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(5, 'Toni Garcia', '2021-12-12', '5', '6');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(6, 'Maria Lens', '2022-03-03', '2', '4');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(7, 'Toni Garcia', '2022-02-02', '4', '10');
INSERT INTO `optica`.`vendes`
(`id-vendes`, `empleat`, `fecha`, `client_idclient`, `Ulleres_id`)
VALUES
(8, 'Maria Lens', '2022-02-02', '1', '2');

-- queries for database optica 
-- USE optica 
-- Llista el total de compres d'un client
SELECT COUNT(`vendes`.`client_idclient`) AS `total_de_compres`
FROM `optica`.`vendes` 
WHERE `vendes`.`client_idclient`=1;
-- Llista les diferents ulleres que ha venut un empleat durant un any (where Maria in 2021 = id 3 - ray, id 6 - blue-jean)
SELECT `vendes`.`empleat`, `ulleres`.`marca`
FROM  `optica`.`ulleres`
	JOIN  `optica`.`vendes`
	ON `ulleres`.`id`=`vendes`.`Ulleres_id`
	WHERE `vendes`.`empleat`='Maria Lens' AND `vendes`.`fecha` REGEXP '^2021';
-- Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica
SELECT Count(`ulleres`.`id`) AS `ulleres_venudes`, `proveidor`.`nom` AS `proveïdors` FROM `optica`.`vendes` 
	JOIN `optica`.`ulleres` ON `ulleres`.`id`=`vendes`.`id-vendes` 
	JOIN `optica`.`proveidor` ON `ulleres`.`Proveidor_idProveidor`= `proveidor`.`idProveidor`
	GROUP BY `ulleres`.`Proveidor_idProveidor`;



