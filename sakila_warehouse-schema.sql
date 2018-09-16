-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sakila_warehouse
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sakila_warehouse` ;

-- -----------------------------------------------------
-- Schema sakila_warehouse
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sakila_warehouse` ;
USE `sakila_warehouse` ;

-- -----------------------------------------------------
-- Table `sakila_warehouse`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`customer` (
  `customer_id` SMALLINT UNSIGNED NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT TRUE,
  `create_date` DATETIME NOT NULL,
  PRIMARY KEY (`customer_id`),
  INDEX `idx_last_name` (`last_name` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Table storing all customers. Holds foreign keys to the address table and the store table where this customer is registered.\n\nBasic information about the customer like first and last name are stored in the table itself. Same for the date the record was created and when the information was last updated.';


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`film`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`film` (
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `title` VARCHAR(255) NOT NULL,
  `replacement_cost` DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  `category_name` VARCHAR(25) NOT NULL,
  INDEX `idx_title` (`title` ASC),
  PRIMARY KEY (`film_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`date` (
  `date_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `year` DECIMAL(4) NOT NULL,
  `month` DECIMAL(2) NOT NULL,
  `day` DECIMAL(2) NOT NULL,
  `weekday` VARCHAR(45) NOT NULL,
  `holiday` TINYINT(1) NOT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`location` (
  `location_id` INT UNSIGNED NOT NULL,
  `district` VARCHAR(20) NULL,
  `city_name` VARCHAR(50) NULL,
  `country_name` VARCHAR(50) NULL,
  `postal_code` VARCHAR(10) NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`rental`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`rental` (
  `rental_id` INT UNSIGNED NOT NULL,
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `customer_id` SMALLINT UNSIGNED NOT NULL,
  `store_location` INT UNSIGNED NOT NULL,
  `customer_location` INT UNSIGNED NOT NULL DEFAULT 0,
  `rental_date` INT UNSIGNED NOT NULL,
  `return_date` INT UNSIGNED NOT NULL,
  `store_id` INT NOT NULL,
  `count_rent` INT UNSIGNED NOT NULL,
  `count_days_rent` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`rental_id`),
  INDEX `fk_rental_film_idx` (`film_id` ASC),
  INDEX `fk_rental_date_idx` (`rental_date` ASC),
  INDEX `fk_rental_customer_idx` (`customer_id` ASC),
  INDEX `fk_rental_store_location_idx` (`store_location` ASC),
  INDEX `fk_return_date_idx` (`return_date` ASC),
  INDEX `fk_rental_customer_location_idx` (`customer_location` ASC),
  CONSTRAINT `fk_rental_film_id`
    FOREIGN KEY (`film_id`)
    REFERENCES `sakila_warehouse`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_date_id`
    FOREIGN KEY (`rental_date`)
    REFERENCES `sakila_warehouse`.`date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sakila_warehouse`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_store_location_id`
    FOREIGN KEY (`store_location`)
    REFERENCES `sakila_warehouse`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_return_date_id`
    FOREIGN KEY (`return_date`)
    REFERENCES `sakila_warehouse`.`date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rental_customer_location_id`
    FOREIGN KEY (`customer_location`)
    REFERENCES `sakila_warehouse`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `sakila_warehouse`.`sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sakila_warehouse`.`sale` (
  `sale_id` INT NOT NULL AUTO_INCREMENT,
  `date_id` INT UNSIGNED NOT NULL,
  `customer_id` SMALLINT UNSIGNED NOT NULL,
  `film_id` SMALLINT UNSIGNED NOT NULL,
  `customer_location` INT UNSIGNED NOT NULL,
  `store_location` INT UNSIGNED NOT NULL,
  `store_id` TINYINT UNSIGNED NOT NULL,
  `sale_amount` DECIMAL(5,2) UNSIGNED NOT NULL,
  INDEX `fk_sale_date_idx` (`date_id` ASC),
  INDEX `fk_sale_film_idx` (`film_id` ASC),
  INDEX `fk_sale_customer_idx` (`customer_id` ASC),
  INDEX `fk_sale_location_idx` (`store_location` ASC),
  PRIMARY KEY (`sale_id`),
  INDEX `fk_sale_location_customer_id_idx` (`customer_location` ASC),
  CONSTRAINT `fk_sale_date_id`
    FOREIGN KEY (`date_id`)
    REFERENCES `sakila_warehouse`.`date` (`date_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_film_id`
    FOREIGN KEY (`film_id`)
    REFERENCES `sakila_warehouse`.`film` (`film_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `sakila_warehouse`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_location_id`
    FOREIGN KEY (`store_location`)
    REFERENCES `sakila_warehouse`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sale_location_customer_id`
    FOREIGN KEY (`customer_location`)
    REFERENCES `sakila_warehouse`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'Manages the facts related with payements';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
