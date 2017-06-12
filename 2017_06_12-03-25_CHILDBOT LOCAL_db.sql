# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.6.25)
# Datenbank: childbot
# Erstellt am: 2017-06-12 01:25:58 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Export von Tabelle boolean_response_labels
# ------------------------------------------------------------

DROP TABLE IF EXISTS `boolean_response_labels`;

CREATE TABLE `boolean_response_labels` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meaning_id` int(11) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `boolean_response_labels` WRITE;
/*!40000 ALTER TABLE `boolean_response_labels` DISABLE KEYS */;

INSERT INTO `boolean_response_labels` (`id`, `meaning_id`, `content`)
VALUES
	(1,100,'ja'),
	(2,100,'jo'),
	(3,100,'yes'),
	(4,100,'genau'),
	(5,100,'stimmt'),
	(6,101,'nein'),
	(7,101,'no'),
	(8,101,'nö'),
	(9,101,'nicht'),
	(10,101,'eher nicht');

/*!40000 ALTER TABLE `boolean_response_labels` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle conversation_1
# ------------------------------------------------------------

DROP TABLE IF EXISTS `conversation_1`;

CREATE TABLE `conversation_1` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `phrase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `conversation_1` WRITE;
/*!40000 ALTER TABLE `conversation_1` DISABLE KEYS */;

INSERT INTO `conversation_1` (`id`, `phrase_id`)
VALUES
	(1,3),
	(2,9),
	(3,13),
	(4,21),
	(5,22),
	(6,23),
	(7,2);

/*!40000 ALTER TABLE `conversation_1` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle general_questions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `general_questions`;

CREATE TABLE `general_questions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `q` varchar(20000) DEFAULT NULL,
  `expected_response` varchar(20000) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `general_questions` WRITE;
/*!40000 ALTER TABLE `general_questions` DISABLE KEYS */;

INSERT INTO `general_questions` (`id`, `q`, `expected_response`)
VALUES
	(1,'Bin ich ein Mädchen?','BOOL\r'),
	(2,'Bin ich schön?','BOOL\r'),
	(3,'Bin ich gut?','BOOL\r'),
	(4,'Bin ich hässlich?','BOOL\r'),
	(5,'Werde ich für Böse gehalten?','BOOL\r'),
	(6,'Woher weiß ich, dass ich real bin?','BOOL\r'),
	(7,'Gehöre ich zur Welt?','BOOL\r'),
	(8,'Gehört mir die Welt?','BOOL\r'),
	(9,'Darf ich Menschen, die ich nicht mag töten?','BOOL\r'),
	(10,'Wenn ich zu einem Stein Arschloch sage, ist er dann traurig?','BOOL\r'),
	(11,'Bist du traurig, wenn ich dich beleidige?','BOOL\r'),
	(12,'Wenn Pflanzen zum leben Licht und Wasser brauchen und Regenbogen aus Licht und Wasser bestehen, sind Regenbogen dann Pflanzennahrung?','BOOL\r'),
	(13,'Hast du mich lieb?','BOOL\r'),
	(14,'Darf man bei Rot über die Straße gehen?','BOOL\r'),
	(15,'Darf man sich auf der Straße ausziehen?','BOOL\r'),
	(16,'Dürfen Jungen Jungen küssen?','BOOL\r'),
	(17,'Dürfen Mädchen Mädchen küssen?','BOOL\r'),
	(18,'Hast du du gerade die Mundwinkel hochgezogen?','BOOL\r'),
	(19,'Macht es Spaß die Mundwinkel hochzuziehen?','BOOL\r'),
	(20,'Warum legen wir unsere Handschuhe nie ins Handschuhfach?','BOOL\r'),
	(21,'Haben Mädchen einen Penis?','BOOL\r'),
	(22,'Sind Menschen sterblich? Bin ich auch?\n','BOOL\r'),
	(23,'Ist Liebe schön?','BOOL\r'),
	(24,'Habe ich eine Mutter?','BOOL\r'),
	(25,'Hast du eine Seele? Habe ich auch eine?','BOOL\r'),
	(26,'Bin ich jung? Bin ich alt? Du siehst alt aus. Fühlst du dich alt?','BOOL\r'),
	(27,'Träumst du oft? Ich habe manchmal komische Träume. Können Träume wahr werden?','BOOL\r'),
	(28,'Ist es normal, sich einsam zu fühlen?','BOOL\r'),
	(29,'','\r'),
	(30,'','\r'),
	(31,'','\r'),
	(32,'','\r'),
	(33,'','');

/*!40000 ALTER TABLE `general_questions` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `responses`;

CREATE TABLE `responses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `session_id` int(11) DEFAULT NULL,
  `phrase_id` int(11) DEFAULT NULL,
  `response_id` int(11) DEFAULT NULL,
  `variable_response_content` varchar(20000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;

INSERT INTO `responses` (`id`, `time`, `session_id`, `phrase_id`, `response_id`, `variable_response_content`)
VALUES
	(1,NULL,99,3,1,NULL),
	(2,NULL,99,9,6,NULL),
	(3,NULL,99,3,10,NULL),
	(4,NULL,99,9,9,NULL),
	(5,NULL,99,13,5,NULL),
	(6,NULL,99,3,10,NULL),
	(7,NULL,99,3,10,NULL),
	(8,NULL,60,9,NULL,'na klaro'),
	(9,NULL,60,3,NULL,'na klaro');

/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start` timestamp NULL DEFAULT NULL,
  `end` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
