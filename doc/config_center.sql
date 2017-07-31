-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema config_center
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `config_center` ;

-- -----------------------------------------------------
-- Schema config_center
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `config_center` DEFAULT CHARACTER SET utf8 ;
USE `config_center` ;

-- -----------------------------------------------------
-- Table `config_center`.`cc_business`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_business` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_business` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NULL,
  `status` INT NOT NULL DEFAULT 0,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cc_business_uniq_idx` (`name` ASC))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_server`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_server` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_server` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `version` DATETIME NOT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  `business_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `business_id`),
  INDEX `fk_cc_server_business_id_idx` (`business_id` ASC),
  UNIQUE INDEX `cc_server_uniq` (`name` ASC, `business_id` ASC),
  CONSTRAINT `fk_cc_server_business_id`
  FOREIGN KEY (`business_id`)
  REFERENCES `config_center`.`cc_business` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_configuration`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_configuration` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_configuration` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `value` VARCHAR(16384) NULL,
  `version` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  `server_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `server_id`),
  INDEX `fk_cc_configuration_server_id_idx` (`server_id` ASC),
  UNIQUE INDEX `cc_configuration_uniq_idx` (`name` ASC, `version` ASC, `server_id` ASC),
  CONSTRAINT `fk_cc_configuration_server_id`
  FOREIGN KEY (`server_id`)
  REFERENCES `config_center`.`cc_server` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_machine` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_machine` (
  `id` BIGINT NOT NULL,
  `address` VARCHAR(32) NOT NULL,
  `port` INT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  `server_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `cc_machine_uniq_idx` (`address` ASC, `port` ASC),
  INDEX `fk_cc_machine_server_idx` (`server_id` ASC),
  CONSTRAINT `fk_cc_machine_server_id`
  FOREIGN KEY (`server_id`)
  REFERENCES `config_center`.`cc_server` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_publish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_publish` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_publish` (
  `configuration_id` BIGINT NOT NULL,
  `machine_id` BIGINT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `updated` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  PRIMARY KEY (`configuration_id`, `machine_id`),
  INDEX `fk_cc_publish_configuration_id_idx` (`configuration_id` ASC),
  INDEX `fk_cc_publish_machine_id_idx` (`machine_id` ASC),
  CONSTRAINT `fk_cc_publish_machine_id`
  FOREIGN KEY (`machine_id`)
  REFERENCES `config_center`.`cc_machine` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_publish_configuration_id`
  FOREIGN KEY (`configuration_id`)
  REFERENCES `config_center`.`cc_configuration` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_user` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(64) NOT NULL,
  `password` VARCHAR(64) NOT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `updated` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `email` VARCHAR(64) NULL,
  `telephone` VARCHAR(32) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_user_business`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_user_business` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_user_business` (
  `business_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
  `role` INT NOT NULL DEFAULT 0,
  `created` DATETIME NOT NULL,
  PRIMARY KEY (`business_id`, `user_id`),
  INDEX `fk_cc_user_business_user_idx` (`user_id` ASC),
  INDEX `fk_cc_user_business_business_idx` (`business_id` ASC),
  CONSTRAINT `fk_cc_user_business_business_id`
  FOREIGN KEY (`business_id`)
  REFERENCES `config_center`.`cc_business` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_user_business_user_id`
  FOREIGN KEY (`user_id`)
  REFERENCES `config_center`.`cc_user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `config_center`.`cc_subscriber_server`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `config_center`.`cc_subscriber_server` ;

CREATE TABLE IF NOT EXISTS `config_center`.`cc_subscriber_server` (
  `subscriber_id` BIGINT NOT NULL,
  `server_id` BIGINT NOT NULL,
  `status` INT NOT NULL DEFAULT 0,
  `token` VARCHAR(64) NOT NULL,
  `created` DATETIME NOT NULL,
  `comment` VARCHAR(1024) NULL,
  INDEX `fk_cc_subscriber_server_server_idx` (`server_id` ASC),
  INDEX `fk_cc_subscriber_server_subscriber_idx` (`subscriber_id` ASC),
  PRIMARY KEY (`subscriber_id`, `server_id`),
  INDEX `fk_cc_subscriber_server_token_idx` (`token` ASC),
  CONSTRAINT `fk_cc_subscriber_server_subscriber_id`
  FOREIGN KEY (`subscriber_id`)
  REFERENCES `config_center`.`cc_server` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cc_subscriber_server_server_id`
  FOREIGN KEY (`server_id`)
  REFERENCES `config_center`.`cc_server` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
  ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
