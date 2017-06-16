# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.6.25)
# Datenbank: childbot
# Erstellt am: 2017-06-16 17:49:42 +0000
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
	(1,1),
	(2,2),
	(3,6),
	(4,14),
	(5,17),
	(6,4),
	(7,23);

/*!40000 ALTER TABLE `conversation_1` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle general_questions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `general_questions`;

CREATE TABLE `general_questions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `content` varchar(20000) DEFAULT NULL,
  `expected_response` varchar(20000) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `general_questions` WRITE;
/*!40000 ALTER TABLE `general_questions` DISABLE KEYS */;

INSERT INTO `general_questions` (`id`, `content`, `expected_response`)
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


# Export von Tabelle response_phrases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `response_phrases`;

CREATE TABLE `response_phrases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `meaning_id` int(11) DEFAULT NULL,
  `content` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `response_phrases` WRITE;
/*!40000 ALTER TABLE `response_phrases` DISABLE KEYS */;

INSERT INTO `response_phrases` (`id`, `meaning_id`, `content`)
VALUES
	(1,100,'ja'),
	(2,100,'jo'),
	(3,100,'yes'),
	(4,100,'genau'),
	(5,100,'stimmt'),
	(6,101,'nein'),
	(7,101,'no ways'),
	(8,101,'nö'),
	(9,101,'nicht'),
	(10,101,'eher nicht'),
	(11,100,'ja schon'),
	(12,101,'ja eher nicht'),
	(13,NULL,'ich bin mir nicht sicher'),
	(14,NULL,'ja ich bin mir nicht so sicher'),
	(15,NULL,'frag mal deine Mutter bitte'),
	(16,NULL,'na ja wenn man so sieht dann nicht'),
	(17,100,'da kannst du aber von ausgehen'),
	(18,101,'also das würde wirklich keiner sagen also nein'),
	(19,100,'klar habe ich dich lieb'),
	(20,100,'klar'),
	(21,100,'na logisch'),
	(22,NULL,'habe ich nicht verstanden'),
	(23,NULL,'komische Frage'),
	(24,100,'na sicher'),
	(25,101,'natürlich nicht'),
	(26,NULL,'schau mal nach'),
	(27,100,'na klaro'),
	(28,NULL,'nur mit einem Messer'),
	(29,NULL,'ja vielleicht'),
	(30,NULL,'vielleicht'),
	(31,100,'na klar'),
	(32,100,'sicher'),
	(33,100,'na logo');

/*!40000 ALTER TABLE `response_phrases` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle responses
# ------------------------------------------------------------

DROP TABLE IF EXISTS `responses`;

CREATE TABLE `responses` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `session_id` int(11) DEFAULT NULL,
  `phrase_id` int(11) DEFAULT NULL,
  `response_phrase_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `responses` WRITE;
/*!40000 ALTER TABLE `responses` DISABLE KEYS */;

INSERT INTO `responses` (`id`, `time`, `session_id`, `phrase_id`, `response_phrase_id`)
VALUES
	(1,'2017-06-12 05:37:18',1,3,1),
	(2,'2017-06-12 05:37:26',1,9,1),
	(3,'2017-06-12 05:37:34',1,13,29),
	(4,'2017-06-12 05:37:43',1,21,25),
	(5,'2017-06-12 05:37:52',1,22,23),
	(6,'2017-06-12 05:38:01',1,23,21),
	(7,'2017-06-12 05:38:10',1,2,30),
	(8,'2017-06-12 05:41:45',2,3,21),
	(9,'2017-06-12 05:41:55',2,9,25),
	(10,'2017-06-13 00:52:47',4,3,1),
	(11,'2017-06-13 00:52:57',4,9,25),
	(12,'2017-06-13 00:53:01',4,13,20),
	(13,'2017-06-13 00:53:08',4,21,6),
	(14,'2017-06-14 21:00:14',5,3,1),
	(15,'2017-06-14 21:00:22',5,9,31),
	(16,'2017-06-14 21:00:31',5,13,32),
	(17,'2017-06-14 21:00:38',5,21,33),
	(18,'2017-06-14 21:02:07',6,3,31),
	(19,'2017-06-14 21:02:15',6,9,32),
	(20,'2017-06-14 21:02:22',6,13,25),
	(21,'2017-06-14 21:02:28',6,21,33);

/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle user_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_sessions`;

CREATE TABLE `user_sessions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `finish_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `u` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;

INSERT INTO `user_sessions` (`id`, `start_datetime`, `finish_datetime`, `u`)
VALUES
	(1,'2017-06-12 05:37:08','2017-06-12 05:38:10',1),
	(2,'2017-06-12 05:41:36','2017-06-12 05:41:56',1),
	(3,'2017-06-13 00:52:24','2017-06-13 00:52:33',1),
	(4,'2017-06-13 00:52:38','2017-06-13 00:53:15',1),
	(5,'2017-06-14 21:00:04','2017-06-14 21:00:44',1),
	(6,'2017-06-14 21:01:56','2017-06-14 21:02:31',1);

/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
