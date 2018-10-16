-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema saber11_dw
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `saber11_dw` ;

-- -----------------------------------------------------
-- Schema saber11_dw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `saber11_dw` DEFAULT CHARACTER SET utf8 ;
USE `saber11_dw` ;

-- -----------------------------------------------------
-- Table `saber11_dw`.`Geografia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`Geografia` (
  `idGeografia` INT NOT NULL,
  `pais` VARCHAR(45) NULL,
  `departamento` VARCHAR(45) NULL,
  `municipio` VARCHAR(45) NULL,
  PRIMARY KEY (`idGeografia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saber11_dw`.`Periodo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`Periodo` (
  `idPeriodo` INT NOT NULL,
  `anio` INT NOT NULL,
  `periodo` INT NOT NULL,
  PRIMARY KEY (`idPeriodo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saber11_dw`.`Familia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`Familia` (
  `idFamilia` INT NOT NULL,
  PRIMARY KEY (`idFamilia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saber11_dw`.`Colegio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`Colegio` (
  `idColegio` INT NOT NULL,
  `daneEstablecimiento` VARCHAR(12) NOT NULL,
  `nombreEstablecimiento` VARCHAR(200) NOT NULL,
  `genero` VARCHAR(10) NOT NULL,
  `naturaleza` VARCHAR(10) NOT NULL,
  `calendario` VARCHAR(4) NOT NULL,
  `bilingue` TINYINT(1) NOT NULL,
  `daneSede` VARCHAR(12) NOT NULL,
  `nombreSede` VARCHAR(200) NOT NULL,
  `zona` VARCHAR(6) NOT NULL,
  `jornada` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idColegio`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saber11_dw`.`Estudiante`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`Estudiante` (
  `idEstudiante` INT NOT NULL,
  `tipoDocumento` VARCHAR(2) NOT NULL,
  `nacionalidad` VARCHAR(100) NOT NULL,
  `genero` VARCHAR(10) NOT NULL,
  `estrato` INT NOT NULL,
  `inse` DECIMAL(2,2) NOT NULL,
  PRIMARY KEY (`idEstudiante`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saber11_dw`.`ResultadoFact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saber11_dw`.`ResultadoFact` (
  `idExamen` INT NOT NULL,
  `idPeriodo` INT NOT NULL,
  `idFamilia` INT NOT NULL,
  `idColegio` INT NOT NULL,
  `idEstudiante` INT NOT NULL,
  `idGeografia` INT NOT NULL,
  `idGeografiaColegio` INT NOT NULL,
  `idGeografiaEstudiante` INT NOT NULL,
  `puntajeLecturaCritica` INT NOT NULL,
  `puntajeMatematicas` INT NOT NULL,
  `puntajeCienciasNaturales` INT NOT NULL,
  `puntajeSocialesCiudadanas` INT NULL,
  `puntajeIngles` INT NOT NULL,
  `nivelIngles` VARCHAR(2) NOT NULL,
  `puntajeGlobal` INT NOT NULL,
  `percentilGlobal` INT NOT NULL,
  PRIMARY KEY (`idExamen`),
  INDEX `fk_Examen_Fact_Geografia_idx` (`idGeografia` ASC),
  INDEX `fk_Examen_Fact_Periodo1_idx` (`idPeriodo` ASC),
  INDEX `fk_Examen_Fact_Familia1_idx` (`idFamilia` ASC),
  INDEX `fk_Examen_Fact_Colegio1_idx` (`idColegio` ASC),
  INDEX `fk_Examen_Fact_Estudiante1_idx` (`idEstudiante` ASC),
  INDEX `fk_Examen_Fact_Geografia1_idx` (`idGeografiaColegio` ASC),
  INDEX `fk_ResultadoFact_Geografia1_idx` (`idGeografiaEstudiante` ASC),
  CONSTRAINT `fk_Examen_Fact_Geografia`
    FOREIGN KEY (`idGeografia`)
    REFERENCES `saber11_dw`.`Geografia` (`idGeografia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examen_Fact_Periodo1`
    FOREIGN KEY (`idPeriodo`)
    REFERENCES `saber11_dw`.`Periodo` (`idPeriodo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examen_Fact_Familia1`
    FOREIGN KEY (`idFamilia`)
    REFERENCES `saber11_dw`.`Familia` (`idFamilia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examen_Fact_Colegio1`
    FOREIGN KEY (`idColegio`)
    REFERENCES `saber11_dw`.`Colegio` (`idColegio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examen_Fact_Estudiante1`
    FOREIGN KEY (`idEstudiante`)
    REFERENCES `saber11_dw`.`Estudiante` (`idEstudiante`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examen_Fact_Geografia1`
    FOREIGN KEY (`idGeografiaColegio`)
    REFERENCES `saber11_dw`.`Geografia` (`idGeografia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResultadoFact_Geografia1`
    FOREIGN KEY (`idGeografiaEstudiante`)
    REFERENCES `saber11_dw`.`Geografia` (`idGeografia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
