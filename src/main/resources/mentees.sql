-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
show tables;
-- -----------------------------------------------------
-- Schema mentees
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mentees` DEFAULT CHARACTER SET utf8 ;
USE `mentees` ;

drop table if exists feed;
drop table if exists feedback;
drop table if exists comment;
drop table if exists reserve;
drop table if exists likes;
drop table if exists recommend;
drop table if exists product;
drop table if exists member;

-- -----------------------------------------------------
-- Table `mentees`.`member`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mentees`.`member` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `cover` VARCHAR(100) NULL DEFAULT '/resources/img/cover/sample.jpg',
  `name` VARCHAR(45) NOT NULL,
  `jumin` VARCHAR(45) NOT NULL,
  `id` VARCHAR(45) NOT NULL,
  `pw` VARCHAR(45) NOT NULL,
  `msg` TEXT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NULL,
  `zip` INT NULL,
  `gender` INT NOT NULL DEFAULT 0,
  `interest` TEXT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updates` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `jumin_UNIQUE` (`jumin` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mentees`.`recommend`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mentees`.`recommend` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `recommender` INT NOT NULL,
  `referral` INT NOT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`),
  INDEX `fk_recommand_member1_idx` (`recommender` ASC) VISIBLE,
  CONSTRAINT `fk_recommand_member1`
    FOREIGN KEY (`recommender`)
    REFERENCES `mentees`.`member` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mentees`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mentees`.`product` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `tags` TEXT NULL,
  `cover` VARCHAR(45) NULL DEFAULT '/resources/img/cover/sample.jpg',
  `address` VARCHAR(120) NOT NULL DEFAULT '온라인',
  `view` INT NOT NULL DEFAULT 0,
  `type` VARCHAR(45) NOT NULL DEFAULT 'seminar',
  `id` VARCHAR(45) NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `capacity` INT NOT NULL,
  `start` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `until` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updates` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mentees`.`likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mentees`.`likes` (
  `mnum` INT NOT NULL,
  `pnum` INT NOT NULL,
  PRIMARY KEY (`mnum`, `pnum`),
  CONSTRAINT `fk_likes_mnum`
    FOREIGN KEY (`mnum`)
    REFERENCES `mentees`.`member` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_likes_pnum`
    FOREIGN KEY (`pnum`)
    REFERENCES `mentees`.`product` (`num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mentees`.`feedback`
-- -----------------------------------------------------
drop table feedback;
CREATE TABLE IF NOT EXISTS `mentees`.`feedback` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `view` INT NOT NULL DEFAULT 0,
  `title` VARCHAR(100) NOT NULL,
  `content` LONGTEXT NOT NULL,
  `author` VARCHAR(45) NOT NULL,
  `tags` TEXT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updates` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`),
  INDEX `author_idx` (`author` ASC) VISIBLE,
  CONSTRAINT `author`
    FOREIGN KEY (`author`)
    REFERENCES `mentees`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mentees`.`feed`
-- -----------------------------------------------------
drop table feed;
CREATE TABLE IF NOT EXISTS `mentees`.`feed` (
  `mnum` INT NOT NULL,
  `fnum` INT NOT NULL,
  PRIMARY KEY (`mnum`, `fnum`),
  CONSTRAINT `fk_feed_mnum`
    FOREIGN KEY (`mnum`)
    REFERENCES `mentees`.`member` (`num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_feed_fnum`
    FOREIGN KEY (`fnum`)
    REFERENCES `mentees`.`feedback` (`num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mentees`.`reserve`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mentees`.`reserve` (
  `mnum` INT NOT NULL,
  `pnum` INT NOT NULL,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`mnum`, `pnum`),
  CONSTRAINT `fk_reserve_mnum`
    FOREIGN KEY (`mnum`)
    REFERENCES `mentees`.`member` (`num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_reserve_pnum`
    FOREIGN KEY (`pnum`)
    REFERENCES `mentees`.`product` (`num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `mentees`.`comment`
-- -----------------------------------------------------
-- drop table comment;
CREATE TABLE IF NOT EXISTS `mentees`.`comment` (
  `num` INT NOT NULL AUTO_INCREMENT,
  `pnum` INT NOT NULL,
  `cnum` INT NOT NULL DEFAULT 0,
  `order` INT NOT NULL DEFAULT 0,
  `layer` INT NOT NULL DEFAULT 0,
  `author` VARCHAR(45) NOT NULL,
  `content` TEXT NOT NULL,
  `visible` TINYINT NOT NULL DEFAULT 1,
  `regdate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`num`),
  INDEX `fk_comment_mnum_idx` (`author` ASC) VISIBLE,
  INDEX `fk_comment_pnum_num_idx` (`pnum` ASC) VISIBLE,
  CONSTRAINT `fk_comment_mnum_id`
    FOREIGN KEY (`author`)
    REFERENCES `mentees`.`member` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comment_pnum_num`
    FOREIGN KEY (`pnum`)
    REFERENCES `mentees`.`product` (`num`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- special
select * from product where num in (select pnum from likes where mnum=2);

select * from member;
select * from product;
select * from likes;
select * from recommend;
select * from feedback;
select * from feed;
select * from reserve;
select * from comment;
select * from comment where pnum=4 order by cnum desc, `order`, regdate desc;
update comment set `order` = `order`+1 where cnum=2 and `order`>0;
SELECT product.* FROM product left join reserve on reserve.pnum = product.num WHERE reserve.mnum=2 ORDER BY regdate DESC;
select feedback.* from feedback left join feed on feed.fnum = feedback.num where mnum = 2;
select * from feedback order by num desc;
select referral from recommend where referral=25;
select * from recommend where referral = 25;
insert into feed values(2,4);
SELECT * FROM product ORDER BY regdate DESC LIMIT 0,5;
delete from feed where mnum=2 and fnum=3;
SELECT * FROM likes WHERE mnum = 2 AND pnum = 1;
select member.* from recommend left join member on member.num = recommend.referral where referral=25;
select member.* from recommend left join member on member.num = recommend.recommender where referral=25;
select * from member where num = (select referral from recommend where referral=25);

desc product;
insert into reserve (mnum, pnum) values (2, 3);
insert into member (name, jumin, id, pw, email, address, zip, gender, interest) values ("김이박","931125-1234567","kkn1125",1234,"chaplet01@gmail.com","진주시",12345	,0,"파이썬_자바_스프링");
insert into member (name, jumin, id, pw, email, address, zip, gender, interest) values ("킴슨","931125-1234566","kimson",1234,"kimson@naver.com","진주시 상봉동",	12345,0,"파이썬_교육_알고리즘");
insert into product (tags, cover, type, id, title, content, capacity, start, end, until) 
			values ("웹개발_백앤드_퍼블리셔", default, "seminar", "kimson","개발자 입문자를 위한 세미나", "This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer....", 10, current_timestamp(),current_timestamp(),current_timestamp());
insert into recommend (recommender, referral) values (1,2);
insert into likes (mnum, pnum) values(2, 1);
select * from product where address="온라인 ""상시";
-- update product set address='온라인 ''상시' where num=1;
-- delete from likes where mnum = 2 and pnum = 5;
select * from member where email='chaplet01\@gmail\.com';
show tables;