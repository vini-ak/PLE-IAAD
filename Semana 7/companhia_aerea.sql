-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Companhia_aerea
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Companhia_aerea
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Companhia_aerea` ;
-- -----------------------------------------------------
-- Schema BD_Startup
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_Startup
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_Startup` DEFAULT CHARACTER SET latin1 ;
USE `Companhia_aerea` ;

-- -----------------------------------------------------
-- Table `Companhia_aerea`.`AEROPORTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`AEROPORTO` (
  `Codigo_aeroporto` INT NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Cidade` VARCHAR(45) NOT NULL,
  `Estado` CHAR(2) NOT NULL,
  PRIMARY KEY (`Codigo_aeroporto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`VOO` (
  `Numero_voo` INT NOT NULL,
  `Companhia_aerea` VARCHAR(30) NOT NULL,
  `Dia_semana` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`Numero_voo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`TRECHO_VOO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`TRECHO_VOO` (
  `Numero_trecho` INT NOT NULL AUTO_INCREMENT,
  `Numero_voo` INT NOT NULL,
  `Codigo_aeroporto_partida` INT NOT NULL,
  `Codigo_aeroporto_chegada` INT NOT NULL,
  `Horario_partida_previsto` DATETIME NOT NULL,
  `Horario_chegada_previsto` DATETIME NOT NULL,
  PRIMARY KEY (`Numero_trecho`, `Numero_voo`),
  INDEX `Numero_voo_idx` (`Numero_voo` ASC),
  INDEX `Codigo_aeroporto_partida_idx` (`Codigo_aeroporto_partida` ASC),
  INDEX `Codigo_aeroporto_chegada_idx` (`Codigo_aeroporto_chegada` ASC),
  CONSTRAINT `Numero_voo`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `Companhia_aerea`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto_partida`
    FOREIGN KEY (`Codigo_aeroporto_partida`)
    REFERENCES `Companhia_aerea`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto_chegada`
    FOREIGN KEY (`Codigo_aeroporto_chegada`)
    REFERENCES `Companhia_aerea`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`TIPO_AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`TIPO_AERONAVE` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Qtd_max_assentos` INT NOT NULL,
  `Companhia` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`AERONAVE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`AERONAVE` (
  `Codigo_aeronave` INT NOT NULL,
  `Numero_total_assentos` INT NULL,
  `Tipo_aeronave` VARCHAR(45) NULL,
  PRIMARY KEY (`Codigo_aeronave`),
  INDEX `Tipo_aeronave_idx` (`Tipo_aeronave` ASC),
  CONSTRAINT `Tipo_aeronave`
    FOREIGN KEY (`Tipo_aeronave`)
    REFERENCES `Companhia_aerea`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`INSTANCIA_TRECHO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`INSTANCIA_TRECHO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATE NOT NULL,
  `Numero_assentos_disponiveis` INT NULL,
  `Codigo_aeronave` INT NOT NULL,
  `Codigo_aeroporto_partida` INT NOT NULL,
  `Horario_partida` TIME NOT NULL,
  `Codigo_aeroporto_chegada` INT NOT NULL,
  `Horario_chegada` TIME NOT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`),
  INDEX `Numero_trecho_idx` (`Numero_trecho` ASC),
  INDEX `Codigo_aeroporto_partida_idx` (`Codigo_aeroporto_partida` ASC),
  INDEX `Codigo_aeronave_idx` (`Codigo_aeronave` ASC),
  INDEX `Codigo_aeroporto_chegada_idx` (`Codigo_aeroporto_chegada` ASC),
  CONSTRAINT `Numero_voo_it`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `Companhia_aerea`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Numero_trecho_it`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `Companhia_aerea`.`TRECHO_VOO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto_partida_it`
    FOREIGN KEY (`Codigo_aeroporto_partida`)
    REFERENCES `Companhia_aerea`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeronave_it`
    FOREIGN KEY (`Codigo_aeronave`)
    REFERENCES `Companhia_aerea`.`AERONAVE` (`Codigo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto_chegada_it`
    FOREIGN KEY (`Codigo_aeroporto_chegada`)
    REFERENCES `Companhia_aerea`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`TARIFA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`TARIFA` (
  `Numero_voo` INT NOT NULL,
  `Codigo_tarifa` INT NOT NULL,
  `Quantidade` INT NULL DEFAULT 0,
  `Restricoes` VARCHAR(45) NULL,
  PRIMARY KEY (`Numero_voo`, `Codigo_tarifa`),
  CONSTRAINT `Numero_voo_tarifa`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `Companhia_aerea`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`PODE_POUSAR`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`PODE_POUSAR` (
  `Nome_tipo_aeronave` VARCHAR(45) NOT NULL,
  `Codigo_aeroporto` INT NOT NULL,
  PRIMARY KEY (`Nome_tipo_aeronave`, `Codigo_aeroporto`),
  INDEX `Codigo_aeroporto_idx` (`Codigo_aeroporto` ASC),
  CONSTRAINT `Nome_tipo_aeronave_pp`
    FOREIGN KEY (`Nome_tipo_aeronave`)
    REFERENCES `Companhia_aerea`.`TIPO_AERONAVE` (`Nome_tipo_aeronave`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Codigo_aeroporto_pp`
    FOREIGN KEY (`Codigo_aeroporto`)
    REFERENCES `Companhia_aerea`.`AEROPORTO` (`Codigo_aeroporto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Companhia_aerea`.`RESERVA_ASSENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Companhia_aerea`.`RESERVA_ASSENTO` (
  `Numero_voo` INT NOT NULL,
  `Numero_trecho` INT NOT NULL,
  `Data` DATETIME NOT NULL,
  `Numero_assento` INT NOT NULL,
  `Nome_cliente` VARCHAR(80) NOT NULL,
  `Telefone_cliente` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`Numero_voo`, `Numero_trecho`, `Data`, `Numero_assento`),
  INDEX `Numero_trecho_idx` (`Numero_trecho` ASC),
  CONSTRAINT `Numero_voo_ra`
    FOREIGN KEY (`Numero_voo`)
    REFERENCES `Companhia_aerea`.`VOO` (`Numero_voo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Numero_trecho_ra`
    FOREIGN KEY (`Numero_trecho`)
    REFERENCES `Companhia_aerea`.`TRECHO_VOO` (`Numero_trecho`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `BD_Startup` ;

-- -----------------------------------------------------
-- Table `BD_Startup`.`Linguagem_Programacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Startup`.`Linguagem_Programacao` (
  `id_linguagem` INT(11) NOT NULL AUTO_INCREMENT,
  `linguagem` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`id_linguagem`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BD_Startup`.`Startup`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Startup`.`Startup` (
  `id_startup` INT(11) NOT NULL AUTO_INCREMENT,
  `nome_startup` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_startup`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BD_Startup`.`Programador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Startup`.`Programador` (
  `id_programador` INT(11) NOT NULL AUTO_INCREMENT,
  `id_startup` INT(11) NOT NULL,
  `nome_programador` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_programador`),
  INDEX `id_startup` (`id_startup` ASC),
  CONSTRAINT `Programador_ibfk_1`
    FOREIGN KEY (`id_startup`)
    REFERENCES `BD_Startup`.`Startup` (`id_startup`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `BD_Startup`.`Programador_Linguagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_Startup`.`Programador_Linguagem` (
  `id_programador` INT(11) NOT NULL,
  `id_linguagem` INT(11) NOT NULL,
  PRIMARY KEY (`id_programador`, `id_linguagem`),
  INDEX `id_linguagem` (`id_linguagem` ASC),
  CONSTRAINT `Programador_Linguagem_ibfk_1`
    FOREIGN KEY (`id_programador`)
    REFERENCES `BD_Startup`.`Programador` (`id_programador`),
  CONSTRAINT `Programador_Linguagem_ibfk_2`
    FOREIGN KEY (`id_linguagem`)
    REFERENCES `BD_Startup`.`Linguagem_Programacao` (`id_linguagem`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
