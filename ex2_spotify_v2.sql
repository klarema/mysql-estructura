-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema spotify
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `spotify` DEFAULT CHARACTER SET utf8 ;
USE `spotify` ;

-- -----------------------------------------------------
-- Table `spotify`.`Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`Usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NULL COMMENT 'Users types are Free, Premium. Premium pays a subscription',
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nom` VARCHAR(45) NULL,
  `data_naix` DATE NULL,
  `sexe` VARCHAR(5) NULL,
  `pais` VARCHAR(45) NULL,
  `CP` VARCHAR(10) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`subscriptions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`subscriptions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `inici_date` DATETIME NULL,
  `renova_date` DATETIME NULL,
  `pagament_type` VARCHAR(25) NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_subscriptions_Usuari_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_subscriptions_Usuari`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `spotify`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`targeta_dades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`targeta_dades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_targeta` VARCHAR(45) NULL,
  `caducitat` VARCHAR(5) NULL,
  `codi_seguredad` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`paypal_dades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`paypal_dades` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`pagaments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`pagaments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `order_date` DATETIME NULL,
  `order_number` VARCHAR(10) NULL,
  `total` DECIMAL(6,2) NULL,
  `subscriptions_id` INT NOT NULL,
  `targeta_dades_id` INT NULL,
  `paypal_dades_id` INT NULL,
  PRIMARY KEY (`id`, `subscriptions_id`),
  UNIQUE INDEX `order_number_UNIQUE` (`order_number` ASC) VISIBLE,
  INDEX `fk_pagaments_subscriptions1_idx` (`subscriptions_id` ASC) VISIBLE,
  INDEX `fk_pagaments_targeta_dades1_idx` (`targeta_dades_id` ASC) VISIBLE,
  INDEX `fk_pagaments_paypal_dades1_idx` (`paypal_dades_id` ASC) VISIBLE,
  CONSTRAINT `fk_pagaments_subscriptions1`
    FOREIGN KEY (`subscriptions_id`)
    REFERENCES `spotify`.`subscriptions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagaments_targeta_dades1`
    FOREIGN KEY (`targeta_dades_id`)
    REFERENCES `spotify`.`targeta_dades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagaments_paypal_dades1`
    FOREIGN KEY (`paypal_dades_id`)
    REFERENCES `spotify`.`paypal_dades` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_compartida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_compartida` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cancon_afegit` VARCHAR(45) NULL,
  `date_added` VARCHAR(45) NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_compartida_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_compartida_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `spotify`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `nombre_cancons` JSON NULL COMMENT 'array of song - playlist\'id, song-id, song-name, ',
  `create_date` DATETIME NULL,
  `Usuari_id` INT NOT NULL,
  `playlistEliminada` JSON NULL,
  `playlist_compartida_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_playlist_playlist_compartida1_idx` (`playlist_compartida_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `spotify`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_playlist_compartida1`
    FOREIGN KEY (`playlist_compartida_id`)
    REFERENCES `spotify`.`playlist_compartida` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`genreMusic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`genreMusic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artiste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artiste` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `imatge` BLOB NULL DEFAULT NULL,
  `genreMusic_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_artiste_genreMusic1_idx` (`genreMusic_id` ASC) VISIBLE,
  CONSTRAINT `fk_artiste_genreMusic1`
    FOREIGN KEY (`genreMusic_id`)
    REFERENCES `spotify`.`genreMusic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`albums`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`albums` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `any` CHAR(4) NULL,
  `imatge` BLOB NULL,
  `artiste_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_albums_artiste1_idx` (`artiste_id` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artiste1`
    FOREIGN KEY (`artiste_id`)
    REFERENCES `spotify`.`artiste` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`canco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`canco` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `durada` DOUBLE NULL,
  `vegades_repro` INT NULL DEFAULT '0' COMMENT 'vegades que ha estat reproduïda pels usuaris de Spotify',
  `albums_id` INT NOT NULL,
  `artiste_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canco_albums1_idx` (`albums_id` ASC) VISIBLE,
  INDEX `fk_canco_artiste1_idx` (`artiste_id` ASC) VISIBLE,
  CONSTRAINT `fk_canco_albums1`
    FOREIGN KEY (`albums_id`)
    REFERENCES `spotify`.`albums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canco_artiste1`
    FOREIGN KEY (`artiste_id`)
    REFERENCES `spotify`.`artiste` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`favourites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`favourites` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `albums_id` INT NULL,
  `canco_id` INT NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_favourites_albums1_idx` (`albums_id` ASC) VISIBLE,
  INDEX `fk_favourites_canco1_idx` (`canco_id` ASC) VISIBLE,
  INDEX `fk_favourites_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_favourites_albums1`
    FOREIGN KEY (`albums_id`)
    REFERENCES `spotify`.`albums` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favourites_canco1`
    FOREIGN KEY (`canco_id`)
    REFERENCES `spotify`.`canco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favourites_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `spotify`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`artistesRelacionadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`artistesRelacionadas` (
  `genreMusic_id` INT NOT NULL,
  `artiste_id` INT NOT NULL,
  PRIMARY KEY (`genreMusic_id`, `artiste_id`),
  INDEX `fk_genreMusic_has_artiste_artiste1_idx` (`artiste_id` ASC) VISIBLE,
  INDEX `fk_genreMusic_has_artiste_genreMusic1_idx` (`genreMusic_id` ASC) VISIBLE,
  CONSTRAINT `fk_genreMusic_has_artiste_genreMusic1`
    FOREIGN KEY (`genreMusic_id`)
    REFERENCES `spotify`.`genreMusic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_genreMusic_has_artiste_artiste1`
    FOREIGN KEY (`artiste_id`)
    REFERENCES `spotify`.`artiste` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`playlist_Canciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`playlist_Canciones` (
  `canco_id` INT NOT NULL,
  `playlist_id` INT NOT NULL,
  PRIMARY KEY (`canco_id`, `playlist_id`),
  INDEX `fk_canco_has_playlist_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  INDEX `fk_canco_has_playlist_canco1_idx` (`canco_id` ASC) VISIBLE,
  CONSTRAINT `fk_canco_has_playlist_canco1`
    FOREIGN KEY (`canco_id`)
    REFERENCES `spotify`.`canco` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_canco_has_playlist_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `spotify`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `spotify`.`userFollowsArtiste`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `spotify`.`userFollowsArtiste` (
  `Usuari_id` INT NOT NULL,
  `artiste_id` INT NOT NULL,
  PRIMARY KEY (`Usuari_id`, `artiste_id`),
  INDEX `fk_Usuari_has_artiste_artiste1_idx` (`artiste_id` ASC) VISIBLE,
  INDEX `fk_Usuari_has_artiste_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Usuari_has_artiste_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `spotify`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuari_has_artiste_artiste1`
    FOREIGN KEY (`artiste_id`)
    REFERENCES `spotify`.`artiste` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE spotify;
INSERT INTO spotify.genreMusic(nom) VALUES ('rock'), ('pop'), ('dance'), ('country');
INSERT INTO spotify.artiste (nom, imatge, genreMusic_id) 
VALUES ('Madenna','NULL','1'),
('Meet Leaf','NULL','3'),
('Lead Zip','NULL','2'),
('Snootie','NULL','2'),
('Country Jo','NULL','4');
INSERT INTO spotify.albums
(titol,any,imatge,artiste_id)
VALUES ('All my songs', '2015','NULL','1'),
('Songs from my album', '2015','NULL','2'),
('Stinging songs', '2022','NULL','5'),
('One to ten', '2019','NULL','3'),
('Autumn turns', '2008','NULL','2'),
('La-la-la', '2017','NULL','1');

INSERT INTO spotify.canco(titol,durada,vegades_repro,albums_id,artiste_id )
VALUES ('one song', 2,DEFAULT,'6', '1'),
('two song','3.5',DEFAULT,'6', '1'),
('three song','3',DEFAULT,'5', '1'),
('four song','1.5',DEFAULT,'6', '1'),
('five song','4',DEFAULT,'4', '2'),
('six song','2.2',DEFAULT,'6', '2'),
('seven song','2',DEFAULT,'5', '2'),
('eight song','2',DEFAULT,'4', '2'),
('nine song','1.5',DEFAULT,'3', '2'),
('ten song','2',DEFAULT,'3', '2'),
('eleven song','3',DEFAULT,'3', '3'),
('twelve song','2.5',DEFAULT,'4', '3'),
('thirteen song','2',DEFAULT,'1', '3'),
('fourteen song','2',DEFAULT,'1', '3'),
('fifteen song','1',DEFAULT,'2', '3'),
('sixteen song','1.5',DEFAULT,'4', '3'),
('seventeen song','2',DEFAULT,'2', '3');

INSERT INTO spotify.usuari(type,email,password,nom,data_naix,sexe,pais,CP)
VALUES
('free','jo@hmail.com','passowrd1','Jo Freeway','1999-01-01','M','New Zealand','N4567'),
('premium','Hou@gmail.com','passowrd2','Ben Dunne','1999-01-01','M','France','YTRUPI'),
('premium','K88@gmail.com','passowrd3','Lola Harris','1999-01-01','F','France','KIUJYH'),
('free','jo@hmail.com','passowrd4','Mariu Holden','1999-01-01','M','Spain','02587'),
('free','jo@trmail.com','passowrd10','Harry Gomez','1999-01-01','F','New Zealand','N4567'),
('premium','jo@trmail.com','passowrd12','Ryan Trenie', '1999-01-01','M','New Zealand','N7567'),
('premium','aha@mail.com','passowrd13','Ursula Von Fon','1999-01-01','F','New Zealand','N8867'),
('premium','Yessica@hmail.com','passowrd14','Yule Orr','1999-01-01','F','New Zealand','N4567'),
('premium','Mickal@treemail.com','passowrd10','Wan Uslo','1999-01-01','TR','Scotland','DER123'),
('free','Top55@htail.com','passowrd9','Deidi Frans','1999-01-01','F','France','LLRUPI'),
('premium','jo@Mmail.com','passowrd8','Pat Cash','1999-01-01','F','Spain','02789'),
('free','joanna-9@hbmail.com','passowrd7','Ron Wood','1999-01-01','TR','Italy','ML4566'),
('premium','annaR@pail.com','passowrd6','Doh RayMe','1999-01-01','F','Norway','HYU45'),
('free','bob3@hgail.com','passowrd5','Hanan Whaonway','1999-01-01','M','Spain','02579');

INSERT INTO spotify.subscriptions (inici_date,renova_date,pagament_type,Usuari_id)
VALUES
('2020-01-20 00:00:00','2023-01-01 00:00:00','paypal','2'),
('2021-03-30 00:00:00','2023-01-01 00:00:00','tarjeta','3'),
('2016-01-20 00:00:00','2023-01-01 00:00:00','paypal','6'),
('2021-01-20 00:00:00','2022-07-01 00:00:00','paypal','7'),
('2015-01-20 00:00:00','2022-07-01 00:00:00','tarjeta','8'),
('2018-01-20 00:00:00','2023-01-01 00:00:00','tarjeta','9'),
('2022-01-20 00:00:00','2022-07-01 00:00:00','paypal','11'),
('2020-01-20 00:00:00','2022-12-01 00:00:00','paypal','13');
INSERT INTO spotify.paypal_dades(nom) VALUES('Ben Dunne'), ('Pat Cash');
INSERT INTO spotify.targeta_dades(numero_targeta,caducitat,codi_seguredad)
VALUES
('123456789','01/25','456'),
('678911445','08/27','159');
INSERT INTO spotify.pagaments
(order_date,order_number,total,subscriptions_id,targeta_dades_id,paypal_dades_id)
VALUES
('2021-01-01 00:00:00','00001','120.50','1',NULL,'1'),
('2022-03-01 00:00:00','00002','105.50','2','1',NULL),
('2022-01-01 00:00:00','00003','65.50','1',NULL,'1'),
('2022-02-07 00:00:00','00004','90.50','6','2', NULL),
('2022-03-10 00:00:00','00005','55.00','7',NULL,'2');

INSERT INTO spotify.playlist
(titol,nombre_cancons,create_date,Usuari_id,playlistEliminada,playlist_compartida_id)
VALUES
('My A Playlist', NULL, '2021-01-01 00:00:00', 2, NULL, NULL),
('My B Playlist', NULL, '2021-02-15 00:00:00', 2, NULL, NULL),
('Playlist one', NULL, '2021-01-01 00:00:00', 3, NULL, NULL);

INSERT INTO spotify.playlist_compartida
(cancon_afegit,date_added,Usuari_id)
VALUES('song ten','2021-02-19 15:00:00',4);
UPDATE spotify.playlist SET playlist_compartida_id=1 WHERE id=1; 
INSERT INTO spotify.favourites(albums_id,canco_id,Usuari_id)
VALUES
(NULL, 1, 5), 
(NULL, 10, 5), 
(2, NULL, 5), 
(NULL, 12, 5),
(2, NULL, 7), 
(NULL, 3, 7);

INSERT INTO `spotify`.`artistesrelacionadas`
(`genreMusic_id`,`artiste_id`)
VALUES(1, 1);

INSERT INTO `spotify`.`userfollowsartiste`
(`Usuari_id`,`artiste_id`)
VALUES (2, 1);

INSERT INTO `spotify`.`playlist_canciones`
(`canco_id`,`playlist_id`)
VALUES(1, 1);




