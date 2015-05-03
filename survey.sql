SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

DROP SCHEMA IF EXISTS `survey_001_models_from_tables` ;
CREATE SCHEMA IF NOT EXISTS `survey_001_models_from_tables` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci ;
USE `survey_001_models_from_tables` ;

-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`organizations`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`organizations` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`organizations` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `organization_name` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`organization_name` ASC) )
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`survey_headers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`survey_headers` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`survey_headers` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `organization_id` INT(11) NOT NULL ,
  `survey_name` VARCHAR(80) NULL ,
  `instructions` VARCHAR(4096) NULL ,
  `other_header_info` VARCHAR(255) NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`survey_name` ASC) ,
  INDEX `fk_surveys_organizations1` (`organization_id` ASC) ,
  CONSTRAINT `fk_surveys_organizations1`
    FOREIGN KEY (`organization_id` )
    REFERENCES `survey_001_models_from_tables`.`organizations` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`input_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`input_types` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`input_types` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `input_type_name` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`input_type_name` ASC) )
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`survey_sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`survey_sections` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`survey_sections` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `survey_header_id` INT NULL ,
  `section_name` VARCHAR(80) NULL ,
  `section_title` VARCHAR(45) NULL ,
  `section_subheading` VARCHAR(45) NULL ,
  `section_required_yn` TINYINT(1) NOT NULL DEFAULT 1 ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`section_name` ASC) ,
  INDEX `fk_survey_sections_surveys1` (`survey_header_id` ASC) ,
  CONSTRAINT `fk_survey_sections_surveys1`
    FOREIGN KEY (`survey_header_id` )
    REFERENCES `survey_001_models_from_tables`.`survey_headers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`option_groups`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`option_groups` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`option_groups` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `option_group_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`questions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`questions` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`questions` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `parent_id` INT NULL ,
  `survey_section_id` INT NOT NULL ,
  `input_type_id` INT NOT NULL ,
  `question_name` VARCHAR(255) NOT NULL ,
  `question_subtext` VARCHAR(500) NULL ,
  `question_required_yn` TINYINT(1) NULL ,
  `answer_required_yn` TINYINT(1) NULL DEFAULT 1 ,
  `option_group_id` INT NULL ,
  `allow_mutiple_option_answers_yn` TINYINT(1) NULL DEFAULT 0 ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_questions_question_types1` (`input_type_id` ASC) ,
  INDEX `fk_questions_survey_sections1` (`survey_section_id` ASC) ,
  INDEX `fk_questions_option_type_group1` (`option_group_id` ASC) ,
  UNIQUE INDEX `allow_mutiple_option_answers_yn_UNIQUE` (`allow_mutiple_option_answers_yn` ASC) ,
  CONSTRAINT `fk_questions_question_types1`
    FOREIGN KEY (`input_type_id` )
    REFERENCES `survey_001_models_from_tables`.`input_types` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questions_survey_sections1`
    FOREIGN KEY (`survey_section_id` )
    REFERENCES `survey_001_models_from_tables`.`survey_sections` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questions_option_type_group1`
    FOREIGN KEY (`option_group_id` )
    REFERENCES `survey_001_models_from_tables`.`option_groups` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This is are our questions';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`users` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `username` VARCHAR(80) NOT NULL ,
  `password_hashed` VARCHAR(255) NULL ,
  `email` VARCHAR(45) NOT NULL ,
  `admin` TINYINT(1) NULL ,
  `invite_dt` DATETIME NULL ,
  `last_login_dt` DATETIME NULL ,
  `inviter_user_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`username` ASC) ,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`unit_of_measures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`unit_of_measures` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`unit_of_measures` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `unit_of_measures_name` VARCHAR(80) NOT NULL ,
  PRIMARY KEY (`id`) ,
  UNIQUE INDEX `survey_name_UNIQUE` (`unit_of_measures_name` ASC) )
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`option_choices`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`option_choices` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`option_choices` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `option_group_id` INT NOT NULL ,
  `option_choice_name` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_option_type_choices_option_type_group1` (`option_group_id` ASC) ,
  CONSTRAINT `fk_option_type_choices_option_type_group1`
    FOREIGN KEY (`option_group_id` )
    REFERENCES `survey_001_models_from_tables`.`option_groups` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This is our survey tool.';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`question_options`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`question_options` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`question_options` (
  `id` INT NOT NULL ,
  `question_id` VARCHAR(45) NOT NULL ,
  `option_choice_id` INT NOT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_question_options_questions1` (`question_id` ASC) ,
  INDEX `fk_question_options_option_choices1` (`option_choice_id` ASC) ,
  CONSTRAINT `fk_question_options_questions1`
    FOREIGN KEY (`question_id` )
    REFERENCES `survey_001_models_from_tables`.`questions` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_question_options_option_choices1`
    FOREIGN KEY (`option_choice_id` )
    REFERENCES `survey_001_models_from_tables`.`option_choices` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`answers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`answers` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`answers` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `question_option_id` INT NOT NULL ,
  `answer_numeric` INT NULL ,
  `answer_text` VARCHAR(255) NULL ,
  `answer_yn` TINYINT(1) NULL ,
  `unit_of_measure_id` INT NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_answers_surveyees1` (`user_id` ASC) ,
  INDEX `fk_answers_unit_of_measure1` (`unit_of_measure_id` ASC) ,
  INDEX `fk_answers_question_options1` (`question_option_id` ASC) ,
  CONSTRAINT `fk_answers_surveyees1`
    FOREIGN KEY (`user_id` )
    REFERENCES `survey_001_models_from_tables`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answers_unit_of_measure1`
    FOREIGN KEY (`unit_of_measure_id` )
    REFERENCES `survey_001_models_from_tables`.`unit_of_measures` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_answers_question_options1`
    FOREIGN KEY (`question_option_id` )
    REFERENCES `survey_001_models_from_tables`.`question_options` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'This is are our answers';


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`survey_comments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`survey_comments` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`survey_comments` (
  `id` INT NOT NULL ,
  `survey_header_id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `comments` VARCHAR(4096) NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_survey_comments_users1` (`user_id` ASC) ,
  INDEX `fk_survey_comments_surveys1` (`survey_header_id` ASC) ,
  CONSTRAINT `fk_survey_comments_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `survey_001_models_from_tables`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_survey_comments_surveys1`
    FOREIGN KEY (`survey_header_id` )
    REFERENCES `survey_001_models_from_tables`.`survey_headers` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `survey_001_models_from_tables`.`user_survey_sections`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `survey_001_models_from_tables`.`user_survey_sections` ;

CREATE  TABLE IF NOT EXISTS `survey_001_models_from_tables`.`user_survey_sections` (
  `id` INT NOT NULL ,
  `user_id` INT NOT NULL ,
  `survey_section_id` INT NOT NULL ,
  `completed_on` DATETIME NULL ,
  PRIMARY KEY (`id`) ,
  INDEX `fk_user_survey_sections_survey_sections1` (`survey_section_id` ASC) ,
  INDEX `fk_user_survey_sections_users1` (`user_id` ASC) ,
  CONSTRAINT `fk_user_survey_sections_survey_sections1`
    FOREIGN KEY (`survey_section_id` )
    REFERENCES `survey_001_models_from_tables`.`survey_sections` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_survey_sections_users1`
    FOREIGN KEY (`user_id` )
    REFERENCES `survey_001_models_from_tables`.`users` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
