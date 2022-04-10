-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube_db` DEFAULT CHARACTER SET utf8 ;
USE `youtube_db` ;

-- -----------------------------------------------------
-- Table `youtube_db`.`Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`Usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nom_usuari` VARCHAR(45) NULL,
  `date_nax` DATE NULL,
  `sexe` VARCHAR(10) NULL,
  `pais` VARCHAR(45) NULL,
  `CP` VARCHAR(15) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`Video` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `titol` VARCHAR(45) NULL,
  `description` VARCHAR(300) NULL,
  `size` INT NULL,
  `nomArxiu` VARCHAR(45) NULL,
  `durada` VARCHAR(45) NULL,
  `thumbnail` BLOB NULL,
  `plays_count` INT NULL DEFAULT '0',
  `likes_count` INT NULL DEFAULT '0',
  `dislike_count` INT NULL DEFAULT '0',
  `estat` VARCHAR(45) NULL,
  `Usuari_id` INT NOT NULL,
  `published_date` DATETIME NULL,
  `label_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Video_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_Video_label1_idx` (`label_id` ASC) VISIBLE,
  CONSTRAINT `fk_Video_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube_db`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Video_label1`
    FOREIGN KEY (`label_id`)
    REFERENCES `youtube_db`.`label` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`canal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`canal` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `description` VARCHAR(300) NULL,
  `created` DATE NULL,
  `subscribers` JSON NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_canal_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_canal_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube_db`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`comentari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari` VARCHAR(500) NULL,
  `agrada_o_no` VARCHAR(10) NULL,
  `date` DATETIME NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentari_Video1_idx` (`Video_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube_db`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`registre_likes_dislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`registre_likes_dislikes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `like_dislike` VARCHAR(5) NULL,
  `date` DATETIME NULL,
  `Usuari_id` INT NOT NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_registre_likes_dislikes_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_registre_likes_dislikes_Video1_idx` (`Video_id` ASC) VISIBLE,
  CONSTRAINT `fk_registre_likes_dislikes_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube_db`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registre_likes_dislikes_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube_db`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `playlist` JSON NULL DEFAULT NULL,
  `estat` VARCHAR(45) NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube_db`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube_db`.`comentari_has_Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube_db`.`comentari_has_Usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari_id` INT NULL,
  `Usuari_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentari_has_Usuari_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_comentari_has_Usuari_comentari1_idx` (`comentari_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_has_Usuari_comentari1`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `youtube_db`.`comentari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentari_has_Usuari_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube_db`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `youtube_db`;

DELIMITER $$
USE `youtube_db`$$
CREATE DEFINER = CURRENT_USER TRIGGER `youtube_db`.`Video_AFTER_INSERT` AFTER INSERT ON `Video` FOR EACH ROW
BEGIN

END
$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


USE youtube_db;
INSERT INTO label (nom) VALUES ('modern'), ('humour'), ('clasic'), ('news');
INSERT INTO usuari (email, password, nom_usuari, date_nax, sexe, pais, CP) 
VALUES 
('yeti@youtube.com', 'Password1', 'yeti-101', '1989-12-12', 'F', 'ESP', '08046'), 
('maya@gmail.com', 'Password2', 'maya1985', '1979-11-11', 'M', 'ESP', '08092'), 
('frank@hotmail.com', 'Password3', 'franky', '1999-06-06', 'F', 'US', '123456'), 
('rosa21@mailDrake.com', 'Password4', 'rosa_gs', '2004-03-03', 'F', 'UK', 'SW1234'), 
('williamTall@gmail.com', 'Password5', 'tallWill', '2000-02-02', 'M', 'UK', 'SQ2321');
INSERT INTO canal
(nom, description, created, subscribers, Usuari_id)
VALUES
('channelYeti', 'film clips', '2021-10-11', NULL, 1);
INSERT INTO video
(titol, description, size, nomArxiu, durada, thumbnail, plays_count, likes_count, dislike_count, estat, Usuari_id, published_date, label_id)
VALUES
('Falling', 'very funny film clip', 2, 'comedy', '120', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-20', 2),
('Red Tiles', 'very moden film clip', 1, 'modern', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-21', 2),
('Blue Skies', 'very classic film clip', 1, 'classic', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-23', 2),
('Diff', 'very different film clip', 2, 'comedy', '100', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'ocult', 1, '2021-11-05', DEFAULT),
('Truthy', 'very news clip', 1, 'news', '30', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-12-17', 4),
('Halo signs', 'very moden film clip', 1, 'modern', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'privat', 1, '2021-10-21', 2),
('Red Skies', 'very classic film clip', 1, 'classic', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'privat', 1, '2021-10-23', 2),
('Other', 'an other very different film clip', 2, 'comedy', '100', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-11-05', DEFAULT),
('Falsy', 'amother very news clip', 1, 'news', '30', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-12-17', 4);
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-01-02 13:00:30', 2, 1);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 1;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-01-02 13:00:30', 2, 2);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 2;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-01-02 13:00:30', 2, 5);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 5;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-01-02 13:00:30', 3, 1);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 1;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('dis', '2022-01-02 13:00:30', 3, 5);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 5;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-02 17:00:30', 4, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-02 18:00:30', 4, 8);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 8;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-02 18:00:30', 3, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-12 17:00:30', 2, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-12 17:00:30', 3, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-12 17:00:30', 5, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-02 18:00:30', 4, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
INSERT INTO `youtube_db`.`registre_likes_dislikes` (like_dislike, date, Usuari_id, Video_id)
VALUES ('like', '2022-03-02 18:00:30', 5, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('I like this video a lot. ', 'like', '2022-03-02 18:10:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 1, 2);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('This is the best one I have seen ever. ', 'like', '2022-03-12 18:10:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 2, 3);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('Like it even more today. ', 'like', '2022-03-18 18:50:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 3, 2);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('This is the best. ', 'like', '2022-03-19 18:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 4, 5);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('It is good. ', 'like', '2022-03-19 18:50:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 5, 4);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('This is the worst. ', 'dis', '2022-03-19 20:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 6, 4);
INSERT INTO comentari (comentari, agrada_o_no, date, Video_id)
VALUES('It is not good. ', 'dis', '2022-03-19 21:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 7, 2);
INSERT INTO playlist (nom, date, playlist, estat, Usuari_id)
VALUES
('Top Two', '2022-01-18 18:20:30', NULL, 'public', 2),
('Private list', '2022-01-18 19:10:30', NULL, 'private', 2),
('Favourites', '2022-02-19 14:20:30', NULL, 'public', 4);