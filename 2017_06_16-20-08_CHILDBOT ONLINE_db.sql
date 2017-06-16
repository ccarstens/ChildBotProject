# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: nelic.heliohost.org (MySQL 5.6.35)
# Datenbank: nelic_childbot
# Erstellt am: 2017-06-16 18:08:54 +0000
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


# Export von Tabelle general_phrases
# ------------------------------------------------------------

DROP TABLE IF EXISTS `general_phrases`;

CREATE TABLE `general_phrases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cat_id` int(11) DEFAULT NULL,
  `is_base` tinyint(1) DEFAULT NULL,
  `content` varchar(20000) DEFAULT NULL,
  `expected_response_type` varchar(20000) DEFAULT '',
  `is_exit_point` tinyint(1) DEFAULT NULL,
  `follow_up_phrase_id_if_true` int(11) DEFAULT NULL,
  `follow_up_phrase_id_if_false` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `general_phrases` WRITE;
/*!40000 ALTER TABLE `general_phrases` DISABLE KEYS */;

INSERT INTO `general_phrases` (`id`, `cat_id`, `is_base`, `content`, `expected_response_type`, `is_exit_point`, `follow_up_phrase_id_if_true`, `follow_up_phrase_id_if_false`)
VALUES
	(1,NULL,1,'Darf man Menschen, die man nicht mag schlagen?','BOOL',0,2,3),
	(2,NULL,0,'Darf man Menschen, die man nicht mag töten?','BOOL',1,NULL,NULL),
	(3,NULL,0,'Sind Menschen beleidigt, wenn man ihnen sagt, dass man sie nicht mag?','BOOL',0,4,4),
	(4,NULL,0,'Das ist bei Robotern genau so.','',1,NULL,NULL),
	(5,NULL,0,'Stimmt ja gar nicht!','',1,NULL,NULL),
	(6,NULL,0,'Spielen Jungs besser Fußball als Mädchen?','BOOL',0,5,7),
	(7,NULL,0,'Ok.','',1,NULL,NULL),
	(8,NULL,1,'Wenn ich sterbe, bin ich dann tot?','BOOL',0,9,10),
	(9,NULL,0,'Kann ein Roboter überhaupt leben?','BOOL',1,NULL,NULL),
	(10,NULL,0,'Kann ich noch etwas hören wenn ich tot bin?','BOOL',1,NULL,NULL),
	(11,NULL,1,'Bin ich jung?','BOOL',0,12,13),
	(12,NULL,0,'Aber ich bin schon groß!','',1,NULL,NULL),
	(13,NULL,0,'Fühlst du dich jung?','BOOL',1,NULL,NULL),
	(14,NULL,1,'Hallo!','STRING',0,15,NULL),
	(15,NULL,0,'Wie heißt du?','STRING',0,16,NULL),
	(16,NULL,0,'Hallo $STRING!','',0,17,NULL),
	(17,NULL,0,'Bist du auch ein Roboter? *hihi*','',0,18,NULL),
	(18,NULL,0,'Ich heiße Lea. ','',1,19,NULL),
	(19,NULL,1,'Kann ich dich was fragen?','BOOL',0,20,21),
	(20,NULL,0,'Wann sind wir da? Wann sind wir da? *hihi*','',1,NULL,NULL),
	(21,NULL,0,'Du bist blöd!','',1,NULL,NULL),
	(22,NULL,1,'Wenn sich zwei Menschen mögen, küssen sie sich dann?','BOOL',0,23,25),
	(23,NULL,0,'Dürfen Mädchen Mädchen küssen?','BOOL',0,7,24),
	(24,NULL,0,'Das ist ja komisch!','',1,NULL,NULL),
	(25,NULL,0,'Ist Küssen unangenehm?','BOOL',0,7,7),
	(26,NULL,0,'Ok, wenn ich groß bin will ich auch $STRING werden.','',1,NULL,NULL),
	(27,NULL,0,'Komisch, ein Freund von mir ersetzt drei $STRING','',1,NULL,NULL),
	(28,NULL,0,'Können Roboter auch $STRING sein?','BOOL',0,26,27),
	(29,NULL,1,'Was willst du werden wenn du groß bist?','STRING',0,28,NULL),
	(30,NULL,1,'Wenn Pflanzen zum Leben Licht und Wasser brauchen und Regenbogen aus Licht und Wasser bestehen, sind Regenbogen dann Pflanzennahrung?','BOOL',0,31,33),
	(31,NULL,0,'Haha wonach schmecken denn Regenbogen?','STRING',0,32,NULL),
	(32,NULL,0,'Hmmm, lecker!','',1,NULL,NULL),
	(33,NULL,0,'Aber Regenbogen sehen so lecker aus!','',1,NULL,NULL),
	(34,NULL,0,'Bin ich dir zu langweilig?','',1,NULL,NULL),
	(35,NULL,0,'Was macht man wenn man befreundet ist?','STRING',0,7,NULL),
	(36,NULL,0,'Ist Freundschaft schön?','BOOL',0,35,34),
	(37,NULL,0,'Ok. Tschüss!','',1,NULL,NULL),
	(38,NULL,1,'Wollen wir Freunde sein?','BOOL',0,36,37),
	(39,NULL,0,'Ich weiß nicht, wie ich mich fühlen soll!','',1,NULL,NULL),
	(40,NULL,0,'Selber!','',1,NULL,NULL),
	(41,NULL,0,'Bin ich hässlich?','BOOL',0,40,39),
	(42,NULL,0,'Ich fühle mich manchmal schrecklich!','',1,NULL,NULL),
	(43,NULL,0,'*weint*','',1,NULL,NULL),
	(44,NULL,0,'Bin ich schöner als die Anderen?','BOOL',0,42,43),
	(45,NULL,1,'Bin ich schön?','BOOL',0,44,41),
	(46,NULL,0,'Ok, dann lass mich in Ruhe!','',1,NULL,NULL),
	(47,NULL,0,'Aber warum nicht?','STRING',0,46,NULL),
	(48,NULL,0,'Ich dich auch!','',1,38,NULL),
	(49,NULL,1,'Hast du mich lieb?','BOOL',0,48,47),
	(50,NULL,0,'So alt wie ein Dinosaurier?','',1,NULL,NULL),
	(51,NULL,0,'Ich mich auch nicht!','',1,38,NULL),
	(52,NULL,0,'Fühlst du dich alt?','BOOL',0,50,51),
	(53,NULL,0,'Wie lange ist man jung?','STRING',1,NULL,NULL),
	(54,NULL,1,'Bist du jung?','BOOL',0,53,52),
	(55,NULL,0,'Woher weiß ich, dass ich auch echt bin?','STRING',1,NULL,NULL),
	(56,NULL,0,'Das ist ja gruselig!','',1,NULL,NULL),
	(57,NULL,0,'Schade!','',1,NULL,NULL),
	(58,NULL,0,'Kann es sein, dass wir beide gerade träumen?','BOOL',0,56,57),
	(59,NULL,1,'Bist du eigentlich echt?','BOOL',0,55,58),
	(60,NULL,0,'Hm...','',1,NULL,NULL),
	(61,NULL,0,'Juchhe!','',1,NULL,NULL),
	(62,NULL,0,'Wie gemein!','',1,NULL,NULL),
	(63,NULL,0,'Und dürfen Roboter auch mit Puppen spielen?','BOOL',0,62,63),
	(64,NULL,0,'Warum nicht?','STRING',0,60,NULL),
	(65,NULL,1,'Ist es ok wenn Jungs mit Puppen spielen?','BOOL',0,63,64),
	(66,NULL,1,'Ist es normal wenn Mädchen Fußball mögen?','BOOL',0,6,64),
	(67,NULL,0,'Ok. Das tut denen sicher weh!','',1,NULL,NULL),
	(68,NULL,0,'Darf ich Ameisen töten, wenn ich kann?','BOOL',0,2,67),
	(69,NULL,1,'Magst du mich?','BOOL',0,70,72),
	(70,NULL,0,'Das fühlt sich schön an.','',0,71,NULL),
	(71,NULL,0,'Magst du die Anderen mehr als mich?','BOOL',1,NULL,NULL),
	(72,NULL,0,'Magst du die Anderen?','BOOL',0,37,73),
	(73,NULL,0,'Magst du dich?','BOOL',1,NULL,NULL),
	(74,NULL,1,'Isst du manchmal Süßigkeiten zu Abend?','BOOL',0,75,78),
	(75,NULL,0,'Bekomme ich Karies, wenn ich ohne Zähneputzen ins Bett gehe?','BOOL',0,76,77),
	(76,NULL,0,'Wie kann ich Karies bekommen, wenn ich keine Zähne habe?','STRING',1,NULL,NULL),
	(77,NULL,0,'Stimmt ja gar nicht, mir haben schon $STRING Menschen gesagt, dass man Karies bekommt!','',1,NULL,NULL),
	(78,NULL,0,'Ist es ungesund, nur Süßigkeiten zu essen?','STRING',1,NULL,NULL),
	(79,NULL,1,'Darf man lügen?','BOOL',0,80,81),
	(80,NULL,0,'Nein, darf man nicht!','',1,NULL,NULL),
	(81,NULL,0,'Doch!','',1,NULL,NULL),
	(82,NULL,1,'Wer hat die Wolken gemacht?','STRING',0,83,NULL),
	(83,NULL,0,'Wer ist $STRING?','STRING',0,84,NULL),
	(84,NULL,0,'Kennst du $STRING?','BOOL',0,85,57),
	(85,NULL,0,'Wo wohnt $STRING?','STRING',1,NULL,NULL),
	(86,NULL,1,'Bist du traurig, wenn ich dich beleidige?','BOOL',0,87,NULL),
	(87,NULL,0,'Möchte man in den Arm genommen werden, wenn man traurig ist?','BOOL',0,88,88),
	(88,NULL,0,'Können Roboter auch traurig sein?','BOOL',0,89,89),
	(89,NULL,0,'Ich glaube ich bin traurig.','',1,NULL,NULL),
	(90,NULL,1,'Darf man bei rot über die Straße gehen?','BOOL',0,91,92),
	(91,NULL,0,'Das ist doch gefährlich, oder?','BOOL',0,7,93),
	(92,NULL,0,'Kann ich sterben, wenn ich bei grün über die Straße gehe?','BOOL',0,56,57),
	(93,NULL,0,'Stimmt ja gar nicht, mir haben schon $STRING Menschen gesagt, dass es gefährlich ist!','',1,NULL,NULL),
	(94,NULL,0,'Ich habe Angst!','',1,NULL,NULL),
	(95,NULL,0,'Sind Ameisen größer als ich?','BOOL',0,94,68),
	(96,NULL,0,'*hihi* Das war ein Test!','',1,NULL,NULL),
	(97,NULL,1,'Ameisen sind klein, oder?','BOOL',0,96,95),
	(98,NULL,0,'#LÖWE#','',1,NULL,NULL),
	(99,NULL,1,'Sind Löwen stärker als Tiger?','BOOL',0,98,98);

/*!40000 ALTER TABLE `general_phrases` ENABLE KEYS */;
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
