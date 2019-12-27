-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema cLEInics
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema cLEInics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cLEInics` DEFAULT CHARACTER SET utf8 ;
USE `cLEInics` ;

-- -----------------------------------------------------
-- Table `cLEInics`.`Modalidade`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cLEInics`.`Modalidade` (
	`idModalidade` INT NOT NULL AUTO_INCREMENT,
    `Modalidade` VARCHAR(32) NOT NULL,
    PRIMARY KEY (`idModalidade`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cLEInics`.`Atleta`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cLEInics`.`Atleta` (
	`idAtleta` INT NOT NULL AUTO_INCREMENT,
	`Nome` VARCHAR(32) NOT NULL,
	`Escalao` VARCHAR(10) NOT NULL,
	`Telemovel` INT NOT NULL,
	`Email` VARCHAR(45) NOT NULL,
	`Modalidade_idModalidade` INT NOT NULL,
	PRIMARY KEY (`idAtleta`),
	INDEX `fk_Atleta_Modalidade1_idx` (`Modalidade_idModalidade` ASC),
	CONSTRAINT `fk_Atleta_Modalidade1`
	FOREIGN KEY (`Modalidade_idModalidade`)
	REFERENCES `cLEInics`.`Modalidade` (`idModalidade`)
	ON DELETE NO ACTION
	ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cLEInics`.`Medico`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cLEInics`.`Medico` (
	`idMedico` INT NOT NULL AUTO_INCREMENT,
    `Nome` VARCHAR(32) NOT NULL,
    `Especialidade` VARCHAR(20) NOT NULL,
    `Reputacao` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`idMedico`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `cLEInics`.`Consulta`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `cLEInics`.`Consulta` (
	`idConsulta` INT NOT NULL AUTO_INCREMENT,
    `Descricao` VARCHAR(45) NOT NULL,
    `Horario` DATETIME(0) NOT NULL,
    `Duracao` TIME(0) NOT NULL,
    `Custo` DECIMAL(5,2) NOT NULL,
    `Pago` BINARY(1) NOT NULL,
    `Atleta_idAtleta` INT NOT NULL,
    `Medico_idMedico` INT NOT NULL,
    PRIMARY KEY (`idConsulta`),
	INDEX `fk_Consulta_Atleta1_idx` (`Atleta_idAtleta` ASC),
	INDEX `fk_Consulta_Medico1_idx` (`Medico_idMedico` ASC),
	CONSTRAINT `fk_Consulta_Atleta1`
    FOREIGN KEY (`Atleta_idAtleta`)
    REFERENCES `cLEInics`.`Atleta` (`idAtleta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consulta_Medico1`
    FOREIGN KEY (`Medico_idMedico`)
    REFERENCES `cLEInics`.`Medico` (`idMedico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;