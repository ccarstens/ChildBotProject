# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: nelic.heliohost.org (MySQL 5.6.35)
# Datenbank: nelic_childbot
# Erstellt am: 2017-06-11 18:06:27 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


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
  `expected_answer` varchar(20000) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `general_questions` WRITE;
/*!40000 ALTER TABLE `general_questions` DISABLE KEYS */;

INSERT INTO `general_questions` (`id`, `q`, `expected_answer`)
VALUES
	(1,'Bin ich ein Mädchen?',''),
	(2,'Bin ich schön?',''),
	(3,'Bin ich gut?',''),
	(4,'Bin ich hässlich?',''),
	(5,'Werde ich für Böse gehalten?',''),
	(6,'Woher weiß ich, dass ich real bin?',''),
	(7,'Gehöre ich zur Welt?',''),
	(8,'Gehört mir die Welt?',''),
	(9,'Darf ich Menschen, die ich nicht mag töten?',''),
	(10,'Wenn ich zu einem Stein Arschloch sage, ist er dann traurig?',''),
	(11,'Bist du traurig, wenn ich dich beleidige?',''),
	(12,'Wenn Pflanzen zum leben Licht und Wasser brauchen und Regenbogen aus Licht und Wasser bestehen, sind Regenbogen dann Pflanzennahrung?',''),
	(13,'Hast du mich lieb?',''),
	(14,'Darf man bei Rot über die Straße gehen?',''),
	(15,'Darf man sich auf der Straße ausziehen?',''),
	(16,'Dürfen Jungen Jungen küssen?',''),
	(17,'Dürfen Mädchen Mädchen küssen?',''),
	(18,'Hast du du gerade die Mundwinkel hochgezogen?',''),
	(19,'Macht es Spaß die Mundwinkel hochzuziehen?',''),
	(20,'Warum legen wir unsere Handschuhe nie ins Handschuhfach?',''),
	(21,'Haben Mädchen einen Penis?',''),
	(22,'Sind Menschen sterblich? Bin ich auch?\n',''),
	(23,'Ist Liebe schön?',''),
	(24,'Habe ich eine Mutter?',''),
	(25,'Hast du eine Seele? Habe ich auch eine?',''),
	(26,'Bin ich jung? Bin ich alt? Du siehst alt aus. Fühlst du dich alt?',''),
	(27,'Träumst du oft? Ich habe manchmal komische Träume. Können Träume wahr werden?',''),
	(28,'Ist es normal, sich einsam zu fühlen?',''),
	(29,'',''),
	(30,'',''),
	(31,'',''),
	(32,'',''),
	(33,'','');

/*!40000 ALTER TABLE `general_questions` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle results
# ------------------------------------------------------------

DROP TABLE IF EXISTS `results`;

CREATE TABLE `results` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `session_id` int(11) DEFAULT NULL,
  `phrase_id` int(11) DEFAULT NULL,
  `response_id` int(11) DEFAULT NULL,
  `variable_response_content` varchar(20000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



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
