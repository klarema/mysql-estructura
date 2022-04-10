-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema pizzaOrders
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema pizzaOrders
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `pizzaOrders` ;
-- -----------------------------------------------------
-- Schema universidad
-- -----------------------------------------------------
USE `pizzaOrders` ;

-- -----------------------------------------------------
-- Table `pizzaOrders`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Provincia` (
  `idProvincia` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Localidad`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Localidad` (
  `idLocalidad` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `Provincia_idProvincia` INT NOT NULL,
  PRIMARY KEY (`idLocalidad`),
  INDEX `fk_Localidad_Provincia1_idx` (`Provincia_idProvincia` ASC) VISIBLE,
  CONSTRAINT `fk_Localidad_Provincia1`
    FOREIGN KEY (`Provincia_idProvincia`)
    REFERENCES `pizzaOrders`.`Provincia` (`idProvincia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Client` (
  `idClient` INT NOT NULL,
  `non` VARCHAR(45) NULL,
  `cognom` VARCHAR(45) NULL,
  `adreca` VARCHAR(45) NULL,
  `CP` INT NULL,
  `Localidad_idLocalidad` INT NOT NULL,
  PRIMARY KEY (`idClient`),
  INDEX `fk_Client_Localidad1_idx` (`Localidad_idLocalidad` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Category` (
  `idCategory` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Productes` (
  `idProductes` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `image` BLOB NULL,
  `Preu` DECIMAL(5,2) NULL,
  `Category_idCategory` INT NULL,
  PRIMARY KEY (`idProductes`),
  INDEX `fk_Productes_Category1_idx` (`Category_idCategory` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_Category1`
    FOREIGN KEY (`Category_idCategory`)
    REFERENCES `pizzaOrders`.`Category` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`botiga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`botiga` (
  `idbotiga` INT NOT NULL,
  `adreca` VARCHAR(45) NULL,
  `CP` INT NULL,
  `Localidad_idLocalidad` INT NOT NULL,
  PRIMARY KEY (`idbotiga`),
  INDEX `fk_botiga_Localidad1_idx` (`Localidad_idLocalidad` ASC) VISIBLE,
  CONSTRAINT `fk_botiga_Localidad1`
    FOREIGN KEY (`Localidad_idLocalidad`)
    REFERENCES `pizzaOrders`.`Localidad` (`idLocalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Empleat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Empleat` (
  `idempleat` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `cognom` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NULL,
  `Tel` VARCHAR(45) NULL,
  `Tasc` ENUM('repartidor', 'cuiner') NULL,
  `botiga_idbotiga` INT NOT NULL,
  PRIMARY KEY (`idempleat`),
  INDEX `fk_empleat_botiga1_idx` (`botiga_idbotiga` ASC) VISIBLE,
  CONSTRAINT `fk_empleat_botiga1`
    FOREIGN KEY (`botiga_idbotiga`)
    REFERENCES `pizzaOrders`.`botiga` (`idbotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Comandes` (
  `idComandes` INT NOT NULL,
  `Ordered_At` DATETIME NULL,
  `Delivery_Type` VARCHAR(45) NULL,
  `Delivered_At` DATETIME NULL,
  `botiga_idbotiga` INT NOT NULL,
  `empleat_idempleat` INT NOT NULL,
  `Client_idClient` INT NOT NULL,
  PRIMARY KEY (`idComandes`),
  INDEX `fk_Comandes_botiga1_idx` (`botiga_idbotiga` ASC) VISIBLE,
  INDEX `fk_Comandes_empleat1_idx` (`empleat_idempleat` ASC) VISIBLE,
  INDEX `fk_Comandes_Client1_idx` (`Client_idClient` ASC) VISIBLE,
  CONSTRAINT `fk_Comandes_botiga1`
    FOREIGN KEY (`botiga_idbotiga`)
    REFERENCES `pizzaOrders`.`botiga` (`idbotiga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_empleat1`
    FOREIGN KEY (`empleat_idempleat`)
    REFERENCES `pizzaOrders`.`Empleat` (`idempleat`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_Client1`
    FOREIGN KEY (`Client_idClient`)
    REFERENCES `pizzaOrders`.`Client` (`idClient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pizzaOrders`.`Comandes_has_Productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `pizzaOrders`.`Comandes_has_Productes` (
  `id` INT NOT NULL,
  `Comandes_idComandes` INT NOT NULL,
  `Productes_idProductes` INT NOT NULL,
  INDEX `fk_Comandes_has_Productes_Productes1_idx` (`Productes_idProductes` ASC) VISIBLE,
  INDEX `fk_Comandes_has_Productes_Comandes1_idx` (`Comandes_idComandes` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Comandes_has_Productes_Comandes1`
    FOREIGN KEY (`Comandes_idComandes`)
    REFERENCES `pizzaOrders`.`Comandes` (`idComandes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comandes_has_Productes_Productes1`
    FOREIGN KEY (`Productes_idProductes`)
    REFERENCES `pizzaOrders`.`Productes` (`idProductes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



USE pizzaorders;
-- provincia
INSERT INTO `pizzaorders`.`provincia` (`idProvincia`,`nom`)
VALUES (1, "Girona");
INSERT INTO `pizzaorders`.`provincia` (`idProvincia`,`nom`)
VALUES (2, "Taragona");
-- localidad
INSERT INTO `pizzaorders`.`localidad` (`idLocalidad`, `nom`, `Provincia_idProvincia`)
VALUES (1, "Palafrugell", 1);
INSERT INTO `pizzaorders`.`localidad` (`idLocalidad`, `nom`, `Provincia_idProvincia`)
VALUES (2, "Llivia", 1);
INSERT INTO `pizzaorders`.`localidad` (`idLocalidad`, `nom`, `Provincia_idProvincia`)
VALUES (3, "Tortosa", 2);
INSERT INTO `pizzaorders`.`localidad` (`idLocalidad`, `nom`, `Provincia_idProvincia`)
VALUES (4, "Cambrils", 2);
-- client
INSERT INTO `pizzaorders`.`client` (`idClient`, `non`, `cognom`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (1,"Julia","Merced","123 Rocafell 3B","05514", 3);
INSERT INTO `pizzaorders`.`client` (`idClient`, `non`, `cognom`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (2,"Martin","Gonzalez","Palltel Cases 14-16","05478", 2);
INSERT INTO `pizzaorders`.`client` (`idClient`, `non`, `cognom`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (3,"Juan","Martin","88C Fabra Pau 234","05515", 1);
INSERT INTO `pizzaorders`.`client` (`idClient`, `non`, `cognom`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (4,"Antoni","Balleston","123 Rocafell 3B","05431", 2);
INSERT INTO `pizzaorders`.`client` (`idClient`, `non`, `cognom`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (5,"Reni","Sandrea","Jironell Bajo 7","05661", 4);
-- botiga
INSERT INTO `pizzaorders`.`botiga` (`idbotiga`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (1, "88 Rocafell 1-2", "05431", 2);
INSERT INTO `pizzaorders`.`botiga` (`idbotiga`, `adreca`, `CP`, `Localidad_idLocalidad`)
VALUES (2, "123 Castrel Roig 5", "05514", 3);
-- productes
INSERT INTO `pizzaorders`.`category` (`idCategory`, `nom`)
VALUES (1, "Winter");
INSERT INTO `pizzaorders`.`category` (`idCategory`, `nom`)
VALUES (2, "Summer");
-- productes
-- ALTER TABLE `pizzaorders`.`productes` DROP COLUMN `Productescol`;
-- productes
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (1,"Pizza Grand","Grand with 4 cheeses",NULL,9.50,1);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (2,"Pizza Petit","Petit with spinach",NULL,6.50,2);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (3,"Burger Vegan","Aubergine and mushroom",NULL,8.00,NULL);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (4,"Pizza Deep","Pizza with salami, cheesy",NULL,8.00,1);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (5,"Burger Maesto","Double burger with bacon",NULL,10.00,NULL);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (6,"Pep-cola","Like Pepsi like cola",NULL,2.10,NULL);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (7,"Vitagua","Natural water",NULL,3.70,NULL);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (8,"Burger Cheese","Double cheese",NULL,4.80,NULL);
INSERT INTO `pizzaorders`.`productes` (`idProductes`,`nom`,`description`,`image`,`Preu`,`Category_idCategory`)
VALUES (9,"Pizza Crusty","Thin base tomato",NULL,7.90,2);
-- empleat
-- ALTER TABLE `pizzaorders`.`empleat` DROP COLUMN `empleatcol`;
INSERT INTO `pizzaorders`.`empleat` (`idempleat`, `nom`,`cognom`,`NIF`,`Tel`,`Tasc`,`botiga_idbotiga`)
VALUES (1,"Lola","Maritem","M12345678","123-456-789","cuiner",1);
INSERT INTO `pizzaorders`.`empleat` (`idempleat`, `nom`,`cognom`,`NIF`,`Tel`,`Tasc`,`botiga_idbotiga`)
VALUES (2,"Michel","Oreli","J17891164","155-456-449","repartidor",1);
INSERT INTO `pizzaorders`.`empleat` (`idempleat`, `nom`,`cognom`,`NIF`,`Tel`,`Tasc`,`botiga_idbotiga`)
VALUES (3,"Ana","Durell","P12215487","111-589-780","cuiner",2);
INSERT INTO `pizzaorders`.`empleat` (`idempleat`, `nom`,`cognom`,`NIF`,`Tel`,`Tasc`,`botiga_idbotiga`)
VALUES (4,"Stella","Dann","M22558877","321-498-722","repartidor",2);
-- comandes
INSERT INTO `pizzaorders`.`comandes` (`idComandes`,`Ordered_At`,`Delivery_Type`,`Delivered_At`,`botiga_idbotiga`,`empleat_idempleat`,`Client_idClient`)
VALUES (1,"2021-12-10 19:02:25","domicili","2021-12-10 20:25:25",1,1,1);
INSERT INTO `pizzaorders`.`comandes` (`idComandes`,`Ordered_At`,`Delivery_Type`,`Delivered_At`,`botiga_idbotiga`,`empleat_idempleat`,`Client_idClient`)
VALUES (2,"2021-12-18 16:25:25","domicili","2021-12-18 17:49:25",2,4,5);
INSERT INTO `pizzaorders`.`comandes` (`idComandes`,`Ordered_At`,`Delivery_Type`,`Delivered_At`,`botiga_idbotiga`,`empleat_idempleat`,`Client_idClient`)
VALUES (3,"2022-01-11 22:32:25","domicili","2022-01-11 23:15:25",1,2,4);
INSERT INTO `pizzaorders`.`comandes` (`idComandes`,`Ordered_At`,`Delivery_Type`,`Delivered_At`,`botiga_idbotiga`,`empleat_idempleat`,`Client_idClient`)
VALUES (4,"2022-01-19 20:10:25","botiga","2022-01-19 20:27:25",1,1,4);
INSERT INTO `pizzaorders`.`comandes` (`idComandes`,`Ordered_At`,`Delivery_Type`,`Delivered_At`,`botiga_idbotiga`,`empleat_idempleat`,`Client_idClient`)
VALUES (5,"2022-02-05 18:10:25","botiga","2022-02-05 18:57:25",2,3,1);
-- comandes_has_productes
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(1,1,2);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(2,1,4);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(3,1,6);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(4,1,7);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(5,2,7);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(6,2,7);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(7,2,6);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(8,2,8);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(9,2,9);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(10,2,2);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(11,3,8);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(12,3,8);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(13,3,7);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(14,4,5);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(15,4,7);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(16,5,1);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(17,5,4);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(18,5,9);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(19,5,6);
INSERT INTO `pizzaorders`.`comandes_has_productes`(`id`,`Comandes_idComandes`,`Productes_idProductes`)
VALUES(20,5,7);



USE pizzaorders;
-- Llista quants productes del tipus 'begudes' s'han venut en una determinada localitat - link drinks sold to commandes to botiga, count each 
Select COUNT(comandes_has_productes.id) AS `begudes_localitat `
FROM pizzaorders.comandes_has_productes
JOIN pizzaorders.comandes
ON comandes.idComandes=comandes_has_productes.Comandes_idComandes
JOIN pizzaorders.botiga
ON comandes.botiga_idbotiga=botiga.idbotiga
WHERE botiga.Localidad_idLocalidad=2 AND comandes_has_productes.Productes_idProductes=7;

-- Llista quantes comandes ha efectuat un determinat empleat - where Employee name + cognon, find that id on the commandes, rturn count of commandes
Select COUNT(comandes.idComandes) AS `Orders_per_Employee`
FROM pizzaorders.comandes
JOIN pizzaorders.empleat
ON empleat.idempleat=comandes.empleat_idempleat
WHERE empleat.nom='Lola' AND empleat.cognom='Maritem';
