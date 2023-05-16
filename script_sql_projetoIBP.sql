-- MySQL Script generated by MySQL Workbench
-- Mon May 15 23:01:10 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ibp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ibp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ibp` DEFAULT CHARACTER SET utf8 ;
USE `ibp` ;

-- -----------------------------------------------------
-- Table `ibp`.`area`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`area` ;

CREATE TABLE IF NOT EXISTS `ibp`.`area` (
  `code_area` INT NOT NULL AUTO_INCREMENT,
  `area` VARCHAR(145) NOT NULL,
  PRIMARY KEY (`code_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`regiao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`regiao` ;

CREATE TABLE IF NOT EXISTS `ibp`.`regiao` (
  `code_regiao` INT NOT NULL,
  `regio` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`code_regiao`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`financiamento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`financiamento` ;

CREATE TABLE IF NOT EXISTS `ibp`.`financiamento` (
  `code_financiamento` VARCHAR(1) NOT NULL,
  `financiamento` VARCHAR(10) NULL,
  PRIMARY KEY (`code_financiamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`projetos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`projetos` ;

CREATE TABLE IF NOT EXISTS `ibp`.`projetos` (
  `code_projeto` VARCHAR(10) NOT NULL,
  `titulo` VARCHAR(250) NOT NULL,
  `code_area` INT NOT NULL,
  `horas` INT NOT NULL,
  `data_Inicio` DATE NOT NULL,
  `data_Fim` DATE NULL,
  `code_financiamento` VARCHAR(1) NOT NULL,
  `costo` FLOAT NOT NULL,
  `code_regiao` INT NOT NULL,
  PRIMARY KEY (`code_projeto`, `code_area`, `code_financiamento`, `code_regiao`),
  INDEX `fk_projetos_table11_idx` (`code_area` ASC) VISIBLE,
  INDEX `fk_projetos_regiao1_idx` (`code_regiao` ASC) VISIBLE,
  INDEX `fk_projetos_financiamento1_idx` (`code_financiamento` ASC) VISIBLE,
  CONSTRAINT `fk_projetos_area`
    FOREIGN KEY (`code_area`)
    REFERENCES `ibp`.`area` (`code_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projetos_regiao`
    FOREIGN KEY (`code_regiao`)
    REFERENCES `ibp`.`regiao` (`code_regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_projetos_financiamento`
    FOREIGN KEY (`code_financiamento`)
    REFERENCES `ibp`.`financiamento` (`code_financiamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`sexo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`sexo` ;

CREATE TABLE IF NOT EXISTS `ibp`.`sexo` (
  `code_sexo` INT NOT NULL,
  `sexo` VARCHAR(10) NULL,
  PRIMARY KEY (`code_sexo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`cientistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`cientistas` ;

CREATE TABLE IF NOT EXISTS `ibp`.`cientistas` (
  `cpf` VARCHAR(14) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `code_regiao` INT NOT NULL,
  `code_sexo` INT NOT NULL,
  PRIMARY KEY (`cpf`, `code_regiao`, `code_sexo`),
  INDEX `fk_cientistas_regiao_idx` (`code_regiao` ASC) VISIBLE,
  INDEX `fk_cientistas_sexo1_idx` (`code_sexo` ASC) VISIBLE,
  CONSTRAINT `fk_cientistas_regiao`
    FOREIGN KEY (`code_regiao`)
    REFERENCES `ibp`.`regiao` (`code_regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cientistas_sexo`
    FOREIGN KEY (`code_sexo`)
    REFERENCES `ibp`.`sexo` (`code_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ibp`.`atribuicao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `ibp`.`atribuicao` ;

CREATE TABLE IF NOT EXISTS `ibp`.`atribuicao` (
  `id_atribuicao` INT NOT NULL,
  `cpf` VARCHAR(14) NOT NULL,
  `code_regiao` INT NOT NULL,
  `code_sexo` INT NOT NULL,
  `code_projeto` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_atribuicao`, `cpf`, `code_regiao`, `code_sexo`, `code_projeto`),
  INDEX `fk_atribuicao_cientistas1_idx` (`cpf` ASC, `code_regiao` ASC, `code_sexo` ASC) VISIBLE,
  INDEX `fk_atribuicao_projetos1_idx` (`code_projeto` ASC) VISIBLE,
  CONSTRAINT `fk_atribuicao_cientistas`
    FOREIGN KEY (`cpf` , `code_regiao` , `code_sexo`)
    REFERENCES `ibp`.`cientistas` (`cpf` , `code_regiao` , `code_sexo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_atribuicao_projetos`
    FOREIGN KEY (`code_projeto`)
    REFERENCES `ibp`.`projetos` (`code_projeto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
