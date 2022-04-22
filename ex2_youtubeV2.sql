-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema youtube
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `youtube` DEFAULT CHARACTER SET utf8 ;
USE `youtube` ;

-- -----------------------------------------------------
-- Table `youtube`.`Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `nom_usuari` VARCHAR(45) NULL,
  `date_nax` DATE NULL,
  `sexe` VARCHAR(10) NULL,
  `pais` VARCHAR(45) NULL,
  `CP` VARCHAR(15) NULL,
  `canalID` INT NULL,
  `canalNom` VARCHAR(45) NULL,
  `canalDescription` VARCHAR(300) NULL,
  `canalCreateDate` DATE NULL,
  `canalSubscribers` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`Video`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`Video` (
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
  PRIMARY KEY (`id`),
  INDEX `fk_Video_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_Video_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`label`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`label` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari` VARCHAR(500) NULL,
  `date` DATETIME NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentari_Video1_idx` (`Video_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videoLikesOrDislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videoLikesOrDislikes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `videoLikeOrDislike` VARCHAR(1) NULL,
  `dateAdded` DATETIME NULL,
  `Usuari_id` INT NOT NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_registre_likes_dislikes_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_registre_likes_dislikes_Video1_idx` (`Video_id` ASC) VISIBLE,
  CONSTRAINT `fk_registre_likes_dislikes_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_registre_likes_dislikes_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`playlist` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `date` DATETIME NULL,
  `estat` VARCHAR(45) NULL,
  `Usuari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_playlist_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentari_has_Usuari`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentari_has_Usuari` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentari_id` INT NULL,
  `Usuari_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentari_has_Usuari_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_comentari_has_Usuari_comentari1_idx` (`comentari_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentari_has_Usuari_comentari1`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `youtube`.`comentari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentari_has_Usuari_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`videoLabels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`videoLabels` (
  `label_id` INT NOT NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`label_id`, `Video_id`),
  INDEX `fk_label_has_Video_Video1_idx` (`Video_id` ASC) VISIBLE,
  INDEX `fk_label_has_Video_label1_idx` (`label_id` ASC) VISIBLE,
  CONSTRAINT `fk_label_has_Video_label1`
    FOREIGN KEY (`label_id`)
    REFERENCES `youtube`.`label` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_label_has_Video_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`VideoPlaylists`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`VideoPlaylists` (
  `playlist_id` INT NOT NULL,
  `Video_id` INT NOT NULL,
  PRIMARY KEY (`playlist_id`, `Video_id`),
  INDEX `fk_playlist_has_Video_Video1_idx` (`Video_id` ASC) VISIBLE,
  INDEX `fk_playlist_has_Video_playlist1_idx` (`playlist_id` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_has_Video_playlist1`
    FOREIGN KEY (`playlist_id`)
    REFERENCES `youtube`.`playlist` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_playlist_has_Video_Video1`
    FOREIGN KEY (`Video_id`)
    REFERENCES `youtube`.`Video` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `youtube`.`comentariLikesDislikes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `youtube`.`comentariLikesDislikes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `comentLikeOrDislike` VARCHAR(1) NULL,
  `dateAdded` DATETIME NULL,
  `Usuari_id` INT NOT NULL,
  `comentari_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_comentariLikesDislikes_Usuari1_idx` (`Usuari_id` ASC) VISIBLE,
  INDEX `fk_comentariLikesDislikes_comentari1_idx` (`comentari_id` ASC) VISIBLE,
  CONSTRAINT `fk_comentariLikesDislikes_Usuari1`
    FOREIGN KEY (`Usuari_id`)
    REFERENCES `youtube`.`Usuari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentariLikesDislikes_comentari1`
    FOREIGN KEY (`comentari_id`)
    REFERENCES `youtube`.`comentari` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `youtube`;

DELIMITER $$
USE `youtube`$$
CREATE DEFINER = CURRENT_USER TRIGGER `youtube`.`Video_AFTER_INSERT` AFTER INSERT ON `Video` FOR EACH ROW
BEGIN

END
$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE youtube;
-- labels
INSERT INTO label (nom) VALUES ('modern'), ('humour'), ('clasic'), ('news');
-- users
INSERT INTO usuari(email,password,nom_usuari,date_nax,sexe,pais,CP,canalID,canalNom,canalDescription,canalCreateDate,canalSubscribers)
VALUES
('yeti@youtube.com', 'Password1', 'yeti-101', '1989-12-12', 'F', 'ESP', '08046', 1, 'channelYeti', 'film clips', '2021-10-11', NULL), 
('maya@gmail.com', 'Password2', 'maya1985', '1979-11-11', 'M', 'ESP', '08092', NULL, NULL, NULL, NULL, NULL), 
('frank@hotmail.com', 'Password3', 'franky', '1999-06-06', 'F', 'US', '123456', NULL, NULL, NULL, NULL, NULL),
('rosa21@mailDrake.com', 'Password4', 'rosa_gs', '2004-03-03', 'F', 'UK', 'SW1234', NULL, NULL, NULL, NULL, NULL), 
('williamTall@gmail.com', 'Password5', 'tallWill', '2000-02-02', 'M', 'UK', 'SQ2321', NULL, NULL, NULL, NULL, NULL);
-- videos
INSERT INTO video
(titol, description, size, nomArxiu, durada, thumbnail, plays_count, likes_count, dislike_count, estat, Usuari_id, published_date)
VALUES
('Falling', 'very funny film clip', 2, 'comedy', '120', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-20'),
('Red Tiles', 'very moden film clip', 1, 'modern', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-21'),
('Blue Skies', 'very classic film clip', 1, 'classic', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-10-23'),
('Diff', 'very different film clip', 2, 'comedy', '100', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'ocult', 1, '2021-11-05'),
('Truthy', 'very news clip', 1, 'news', '30', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-12-17'),
('Halo signs', 'very moden film clip', 1, 'modern', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'privat', 1, '2021-10-21'),
('Red Skies', 'very classic film clip', 1, 'classic', '60', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'privat', 1, '2021-10-23'),
('Other', 'an other very different film clip', 2, 'comedy', '100', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-11-05'),
('Falsy', 'amother very news clip', 1, 'news', '30', DEFAULT, DEFAULT, DEFAULT, DEFAULT, 'public', 1, '2021-12-17');
-- add like dislikes
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-01-02 13:00:30', 2, 1);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 1;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-01-02 13:00:30', 2, 2);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 2;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-01-02 13:00:30', 2, 5);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 5;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-01-02 13:00:30', 3, 1);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 1;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('D', '2022-01-02 13:00:30', 3, 5);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 5;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-02 17:00:30', 4, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-02 18:00:30', 4, 8);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 8;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-02 18:00:30', 3, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-12 17:00:30', 2, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-12 17:00:30', 3, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-12 17:00:30', 5, 9);
UPDATE Video SET likes_count = likes_count + 1 WHERE Video.id= 9;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-02 18:00:30', 4, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
INSERT INTO videolikesordislikes (videoLikeOrDislike, dateAdded, Usuari_id, Video_id)
VALUES ('L', '2022-03-02 18:00:30', 5, 8);
UPDATE Video SET dislike_count = dislike_count + 1 WHERE Video.id= 8;
-- add comments 
INSERT INTO comentari (comentari, date, Video_id)
VALUES('I like this video a lot. ', '2022-03-02 18:10:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 1, 2);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('This is the best one I have seen ever. ', '2022-03-12 18:10:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 2, 3);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('Like it even more today. ', '2022-03-18 18:50:30', 9);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 3, 2);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('This is the best. ', '2022-03-19 18:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 4, 5);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('It is good. ', '2022-03-19 18:50:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 5, 4);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('This is the worst. ', '2022-03-19 20:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 6, 4);
INSERT INTO comentari (comentari, date, Video_id)
VALUES('It is not good. ', '2022-03-19 21:10:30', 1);
INSERT INTO comentari_has_usuari (id,comentari_id,Usuari_id) VALUES(LAST_INSERT_ID(), 7, 2);
-- playlist
INSERT INTO playlist (nom, date, estat, Usuari_id)
VALUES
('Top Two', '2022-01-18 18:20:30', 'public', 2),
('Private list', '2022-01-18 19:10:30', 'private', 2),
('Favourites', '2022-02-19 14:20:30', 'public', 4);
-- comment likes dislikes 
INSERT INTO comentarilikesdislikes(comentLikeOrDislike,dateAdded,Usuari_id,comentari_id)
VALUES
('L', '2022-03-18 18:20:30', 3, 1),
('D', '2022-04-11 19:10:30', 2, 2);
-- playlist and video table
INSERT INTO videoplaylists
(playlist_id,Video_id)
VALUES(1, 1), (2, 10), (3, 4), (1, 10), (2, 9), (3, 5), (1, 5), (2, 2), (3, 7);
-- video and labels
INSERT INTO videolabels(label_id,Video_id)
VALUES
(1,2),(2,1),(3,3),(5,4),(6,1),(7,3),(9,4);