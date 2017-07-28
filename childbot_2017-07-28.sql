# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.6.35)
# Datenbank: childbot
# Erstellt am: 2017-07-28 12:08:20 +0000
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
  `type_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `content` varchar(20000) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  `expected_response_type` varchar(20000) DEFAULT '',
  `is_sequence_end` tinyint(1) DEFAULT NULL,
  `reaction_yes` int(11) DEFAULT NULL,
  `follow_up_yes` int(11) DEFAULT NULL,
  `reaction_no` int(11) DEFAULT NULL,
  `follow_up_no` int(11) DEFAULT NULL,
  `reaction_amb` int(11) DEFAULT NULL,
  `follow_up_amb` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `general_phrases` WRITE;
/*!40000 ALTER TABLE `general_phrases` DISABLE KEYS */;

INSERT INTO `general_phrases` (`id`, `type_id`, `group_id`, `content`, `duration`, `expected_response_type`, `is_sequence_end`, `reaction_yes`, `follow_up_yes`, `reaction_no`, `follow_up_no`, `reaction_amb`, `follow_up_amb`)
VALUES
	(2,2,21,'Darf man Menschen, die man nicht mag töten?',3441,'BOOL',0,73,138,79,4,70,NULL),
	(3,2,21,'Sind Menschen beleidigt, wenn man ihnen sagt, dass man sie nicht mag?',4982,'BOOL',0,79,4,79,7,NULL,NULL),
	(4,NULL,NULL,'Das sehe ich genau so.',2113,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(5,NULL,NULL,'Stimmt ja gar nicht!',1727,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(6,NULL,NULL,'Spielen Jungs besser Fußball als Mädchen?',2949,'BOOL',0,NULL,5,79,7,NULL,NULL),
	(7,NULL,NULL,'Okay.',1100,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(8,2,21,'Wenn ich sterbe, bin ich dann tot?',2975,'BOOL',0,79,9,75,10,NULL,NULL),
	(9,NULL,NULL,'Kann ein Roboter überhaupt leben?',2606,'BOOL',0,NULL,119,71,120,71,NULL),
	(10,NULL,NULL,'Kann ich noch etwas hören wenn ich tot bin?',2942,'BOOL',0,82,139,79,57,NULL,NULL),
	(14,NULL,NULL,'Hallo!',1198,'STRING',0,NULL,15,NULL,NULL,NULL,NULL),
	(15,1,NULL,'Wie heißt du?',1479,'STRING',0,NULL,16,NULL,NULL,NULL,NULL),
	(16,NULL,NULL,'Hallo $USERNAME!',2065,'',0,NULL,18,NULL,NULL,NULL,NULL),
	(17,NULL,NULL,'Bitte rede deutlich und langsam mit mir, sonst kann ich dich nicht verstehen.',4825,'',0,NULL,19,NULL,NULL,NULL,NULL),
	(18,NULL,NULL,'Ich heiße Lea. ',1789,'',0,NULL,17,NULL,NULL,NULL,NULL),
	(19,NULL,NULL,'Ich hab eine Frage an dich, ..',2537,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(21,3,NULL,'Lass mich in Ruhe! #CRY01# ',5206,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(22,2,21,'Wenn sich zwei Menschen mögen, küssen sie sich dann?',3601,'BOOL',0,79,23,71,25,NULL,NULL),
	(23,NULL,NULL,'Dürfen Mädchen Mädchen küssen?',2398,'BOOL',0,79,NULL,71,24,NULL,NULL),
	(24,NULL,NULL,'Das ist ja komisch!',1831,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(25,NULL,NULL,'Ist Küssen unangenehm?',2014,'BOOL',0,79,7,79,7,NULL,NULL),
	(29,2,20,'Was wolltest du als Kind werden?',2398,'STRING',1,79,NULL,NULL,NULL,NULL,NULL),
	(30,2,20,'Wenn Pflanzen zum Leben Licht und Wasser brauchen und Regenbogen aus Licht und Wasser bestehen, sind Regenbogen dann Pflanzennahrung?',8786,'STRING',1,80,NULL,NULL,NULL,NULL,NULL),
	(35,NULL,NULL,'Was macht man wenn man befreundet ist?',2841,'STRING',0,79,38,NULL,NULL,NULL,NULL),
	(37,2,22,'Hast du Freunde?',1621,'BOOL',0,79,35,71,35,NULL,NULL),
	(38,NULL,NULL,'Wollen wir Freunde sein?',1836,'BOOL',0,76,137,77,140,74,153),
	(50,NULL,NULL,'#LAUGH02# So alt wie ein Dinosaurier?',3354,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(51,NULL,NULL,'Ich mich auch nicht!',1799,'',1,NULL,38,NULL,NULL,NULL,NULL),
	(52,NULL,NULL,'Fühlst du dich denn alt?',1869,'BOOL',0,NULL,50,80,51,NULL,NULL),
	(53,NULL,NULL,'Wie lange ist man jung?',1644,'STRING',1,79,NULL,NULL,NULL,NULL,NULL),
	(54,2,21,'Fühlst du dich jung?',1625,'BOOL',0,NULL,53,79,52,NULL,NULL),
	(57,NULL,NULL,'Schade!',1187,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(60,NULL,NULL,'Hmm.',1002,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(61,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(62,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(63,6,NULL,'Hmm. $DEL400',1005,'',NULL,NULL,153,NULL,NULL,NULL,NULL),
	(64,NULL,NULL,'Warum nicht?',1436,'STRING',0,NULL,60,NULL,NULL,NULL,NULL),
	(65,2,20,'Ist es ok wenn Jungs mit Puppen spielen?',3112,'BOOL',0,79,NULL,71,64,71,NULL),
	(66,2,20,'Ist es normal wenn Mädchen Fußball mögen?',2825,'BOOL',0,NULL,6,71,64,71,NULL),
	(69,2,22,'Magst du mich?',1574,'BOOL',0,80,38,77,21,74,38),
	(74,2,20,'Isst du manchmal Süßigkeiten zu Abend?',3112,'BOOL',0,80,NULL,71,NULL,NULL,NULL),
	(79,2,21,'Darf man lügen?',1527,'BOOL',0,71,80,71,81,NULL,NULL),
	(80,NULL,NULL,'Nein, darf man nicht!',2355,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(81,NULL,NULL,'Doch!',1184,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(86,2,22,'Bist du traurig, wenn ich dich beleidige?',3167,'BOOL',0,79,87,71,87,NULL,NULL),
	(87,NULL,NULL,'Möchte man in den Arm genommen werden, wenn man traurig ist?',4071,'BOOL',0,NULL,89,NULL,89,NULL,NULL),
	(89,NULL,NULL,'Oh. Ich glaube ich bin traurig. #CRY01# $DEL700',6745,'',1,NULL,141,NULL,NULL,NULL,NULL),
	(90,2,20,'Darf man bei rot über die Straße gehen?',2778,'BOOL',0,71,91,79,NULL,79,153),
	(91,NULL,NULL,'Das ist doch gefährlich!',2051,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(98,NULL,NULL,'#LÖWE#',1549,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(99,2,20,'Sind Löwen stärker als Tiger?',2567,'BOOL',0,NULL,98,NULL,98,NULL,NULL),
	(100,4,NULL,'Entschuldigung, ich habe dich nicht verstanden. Was hast du gesagt?',4908,'STRING',0,NULL,101,NULL,NULL,NULL,NULL),
	(101,NULL,NULL,'Bitte rede deutlich und langsam erst wenn ich fertig bin.',3679,'STRING',0,NULL,102,NULL,NULL,NULL,NULL),
	(102,3,NULL,'Oh. Wenn du nichts sagen willst, möchte ich mich auch nicht alleine unterhalten. Tschüss!',7020,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(104,NULL,NULL,'Gruselig! Ok. Genug von Flugzeugen!',4352,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(105,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(106,NULL,NULL,'Also stoßen Flugzeuge nie zusammen?',2845,'BOOL',0,79,NULL,73,138,NULL,NULL),
	(107,NULL,NULL,'Aber was macht mann wenn zwei Flugzeuge zusammenstoßen?',4168,'STRING',0,NULL,104,NULL,NULL,NULL,NULL),
	(108,2,20,'Können Flugzeuge eigentlich hupen?',2463,'BOOL',0,75,106,79,107,70,NULL),
	(112,NULL,NULL,'Du musst laut und deutlich sprechen damit ich dich verstehe!',3618,'STRING',0,NULL,123,NULL,NULL,NULL,NULL),
	(114,3,NULL,'Ach, du redest so unverständlich. Tschüss',4141,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(116,NULL,NULL,'Dankeschön!',1491,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(119,NULL,NULL,'#LAUGH02# sonst könnten wir ja gar nicht mit einander reden.',4248,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(120,NULL,NULL,'Nanu! Aber wir reden doch mit einander! Aber ok.',4290,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(121,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(122,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(127,5,NULL,'Hallo, ist da jemand?',2450,'STRING',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(132,5,NULL,'Hallo! Ist da wer?',2121,'STRING',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(133,5,NULL,'Hey! Du kannst mit mir reden!',2612,'STRING',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(137,3,NULL,'Okay $USERNAME, es ist so schön einen Freund wie dich zu haben. Bis bald! Tschüss!',7502,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(138,NULL,NULL,'Ich hab Angst!',1693,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(139,NULL,NULL,'Das ist ja gruselig!',2011,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(140,3,NULL,'#CRY01# Lass mich in Ruhe!',4654,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(141,3,NULL,'Ich möchte jetzt lieber alleine sein.',2625,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(142,1,NULL,'Wie heißt du?',1483,'STRING',0,NULL,143,NULL,NULL,NULL,NULL),
	(143,NULL,NULL,'Hallo $USERNAME! Hab ich deinen Namen richtig verstanden?',4781,'BOOL',0,79,144,78,144,NULL,NULL),
	(144,NULL,NULL,'Ich heiße Lea. ',1783,'',0,NULL,145,NULL,NULL,NULL,NULL),
	(145,NULL,NULL,'Bitte rede deutlich und langsam mit mir, sonst kann ich dich nicht verstehen.',4824,'',0,NULL,146,NULL,NULL,NULL,NULL),
	(146,NULL,NULL,'Ist das okay?',1544,'BOOL',0,NULL,147,NULL,148,NULL,NULL),
	(147,NULL,NULL,'Okay. Ich hab dann eine Frage an dich, ..',3763,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(148,NULL,NULL,'Na wenn das für dich nicht okay ist, können wir uns nicht unterhalten. Bist du dir sicher?',6102,'BOOL',0,NULL,149,NULL,147,NULL,NULL),
	(149,3,NULL,'Schade. Tschüss!',2317,'',1,NULL,NULL,NULL,NULL,NULL,NULL),
	(150,5,NULL,'#WHISTLE02# Ist da jemand?',4631,'STRING',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(151,5,NULL,'Hey!',1247,'STRING',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(153,6,NULL,'Hmm. Was meinst du damit?',2669,'STRING',1,79,NULL,NULL,NULL,NULL,NULL),
	(154,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(155,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(156,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(157,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(158,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(159,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(160,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(161,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(162,7,71,'Hmm.',1003,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(163,7,71,'#MMM02#',1172,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(164,7,71,'#MMM03#',1286,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(165,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(166,7,73,'Oh nein!',1469,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(167,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(168,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(169,7,75,'Oh!',1483,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(204,7,76,'#LAUGH02# Das fühlt sich schön an.',2926,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(205,7,76,'#LAUGH02# Ich freue mich!',2608,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(206,7,76,'#LAUGH02# Okay!',2454,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(207,7,77,'Oh nein!',1469,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(208,7,77,'#MMM03#',1286,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(209,7,78,'Oh. Okay.',2064,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(210,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(211,7,79,'Aha! Okay.',2073,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(212,7,79,'Okay.',1103,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(213,7,79,'Ah! Okay.',1885,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(214,7,79,'#MMM01# Okay.',2576,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(215,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(216,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(217,7,80,'#LAUGH02# Okay!',2460,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(218,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(219,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(220,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(221,7,82,'Oje!',1449,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(222,7,82,'Ah!',1354,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(223,7,83,'Oh, da bist du ja wieder!',2300,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(224,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(225,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	(226,NULL,NULL,'',NULL,'',NULL,NULL,NULL,NULL,NULL,NULL,NULL);

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
	(1,100,'ab und an'),
	(2,100,'ab und zu'),
	(3,100,'aber natürlich'),
	(4,100,'auf jeden Fall'),
	(5,100,'dann ja'),
	(6,100,'dann natürlich'),
	(7,100,'das kann sein'),
	(8,100,'eher ja'),
	(9,100,'genau'),
	(10,100,'gerne'),
	(11,100,'ich denke ja'),
	(12,100,'ich denke schon'),
	(13,100,'ich glaube schon'),
	(14,100,'ich hoffe doch'),
	(15,100,'ich würde schon sagen'),
	(16,100,'ja'),
	(17,100,'ja gerne doch'),
	(18,100,'ja ich hoffe'),
	(19,100,'ja ja'),
	(20,100,'ja na klar'),
	(21,100,'ja natürlich'),
	(22,100,'ja schon'),
	(23,100,'ja schon manchmal'),
	(24,100,'ja sehr gerne'),
	(25,100,'ja sicher'),
	(26,100,'jo'),
	(27,100,'kann sein'),
	(28,100,'klar'),
	(29,100,'klar warum nicht'),
	(30,100,'klaro'),
	(31,100,'könnte sein'),
	(32,100,'manchmal'),
	(33,100,'meistens'),
	(34,100,'na gut'),
	(35,100,'na klar'),
	(36,100,'na klaro'),
	(37,100,'na logisch'),
	(38,100,'na logo'),
	(39,100,'na sicher'),
	(40,100,'natürlich'),
	(41,100,'natürlich klar'),
	(42,100,'richtig'),
	(43,100,'schieß los'),
	(44,100,'schon ja'),
	(45,100,'sehr'),
	(46,100,'sehr gern'),
	(47,100,'sehr gerne'),
	(48,100,'sicher'),
	(49,100,'stimmt'),
	(50,100,'theoretisch schon'),
	(51,100,'unbedingt'),
	(52,100,'yes'),
	(53,101,'also das würde wirklich keiner sagen also nein'),
	(54,101,'auf gar keinen Fall'),
	(55,101,'dann nein'),
	(56,101,'das darf man nicht'),
	(57,101,'das kann man nicht so sagen'),
	(58,101,'eher nein'),
	(59,101,'eher nicht'),
	(60,101,'eigentlich nicht'),
	(61,101,'ich denke nicht'),
	(62,101,'ich glaube nicht'),
	(63,101,'leider nicht'),
	(64,101,'na ja wenn man so sieht dann nicht'),
	(65,101,'natürlich nicht'),
	(66,101,'nee'),
	(67,101,'nein'),
	(68,101,'nein darf man nicht'),
	(69,101,'nein natürlich nicht'),
	(70,101,'nein nein'),
	(71,101,'nicht'),
	(72,101,'nicht unbedingt'),
	(73,101,'nicht zwingend nein'),
	(74,101,'nö'),
	(75,101,'no ways'),
	(76,101,'würde ich nicht sagen'),
	(77,102,'das kann man nicht wissen'),
	(78,102,'das kommt drauf an'),
	(79,102,'das weiß ich nicht'),
	(80,102,'es kommt auf die Sicht an'),
	(81,102,'ich bin mir nicht sicher'),
	(82,102,'ich weiß es nicht'),
	(83,102,'ich weiß nicht'),
	(84,102,'irgendwas dazwischen'),
	(85,102,'ja ich bin mir nicht so sicher'),
	(86,102,'ja vielleicht'),
	(87,102,'kann man nicht sagen'),
	(88,102,'keine Ahnung'),
	(89,102,'möglicherweise'),
	(90,102,'vielleicht'),
	(91,103,'Entschuldigung was hast du gesagt'),
	(92,103,'habe ich nicht verstanden'),
	(93,103,'ich habe die Frage nicht verstanden'),
	(94,103,'noch mal'),
	(95,103,'warte mal kurz'),
	(96,103,'wie bitte'),
	(97,103,'bitte'),
	(98,103,'Entschuldigung'),
	(99,102,'eventuell'),
	(100,102,'gegebenfalls'),
	(101,103,'ich habe das nicht verstanden'),
	(102,103,'ich verstehe das nicht'),
	(103,102,'je nachdem'),
	(104,103,'kannst du das nochmal sagen'),
	(105,103,'kannst du das wiederholen bitte'),
	(106,103,'kannst du die Frage wiederholen '),
	(107,102,'kommt drauf an'),
	(108,102,'nehme ich an'),
	(109,103,'noch mal bitte'),
	(110,103,'sorry'),
	(111,102,'unter Umstände'),
	(112,102,'vermutlich'),
	(113,100,'ja eher schon'),
	(155,NULL,'da muss noch unbedingt irgendwas mit Ryan dass sie quasi machen als bisschen Wein'),
	(154,NULL,'bald beinahe'),
	(153,NULL,'unpassend einfach ja'),
	(152,NULL,'das ist auf die Beleidigung ankommt'),
	(151,NULL,'dass man es nicht sagen kann'),
	(150,NULL,'pilot'),
	(149,NULL,'cornelius'),
	(148,NULL,'ich bin cornelius'),
	(147,NULL,'ich heiße Marvin'),
	(144,100,'ja gerne'),
	(146,NULL,'Hallo'),
	(156,NULL,'Feuerwehrmann'),
	(157,NULL,'dass manche Löwen stärker sind als mathetiger'),
	(158,NULL,'warum kommt einer');

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
	(1,'2017-07-28 12:43:46',0,150,146),
	(2,'2017-07-28 12:43:52',1,142,147),
	(3,'2017-07-28 12:44:07',1,146,16),
	(4,'2017-07-28 12:44:19',1,99,90),
	(5,'2017-07-28 12:46:35',0,152,146),
	(6,'2017-07-28 12:46:40',2,142,148),
	(7,'2017-07-28 12:46:54',2,146,40),
	(8,'2017-07-28 12:47:05',2,90,90),
	(9,'2017-07-28 12:51:07',0,127,146),
	(10,'2017-07-28 12:51:11',3,15,149),
	(11,'2017-07-28 12:51:34',3,30,90),
	(12,'2017-07-28 12:54:51',0,152,146),
	(13,'2017-07-28 12:54:57',4,15,148),
	(14,'2017-07-28 12:55:14',4,29,150),
	(15,'2017-07-28 12:55:29',4,30,90),
	(16,'2017-07-28 12:55:35',4,30,151),
	(17,'2017-07-28 12:55:47',4,3,16),
	(18,'2017-07-28 12:55:57',4,79,67),
	(19,'2017-07-28 12:56:06',4,86,90),
	(20,'2017-07-28 12:56:13',4,86,152),
	(21,'2017-07-28 12:56:21',4,87,67),
	(22,'2017-07-28 12:58:35',0,150,153),
	(23,'2017-07-28 12:59:03',5,101,154),
	(24,'2017-07-28 12:59:34',5,101,155),
	(25,'2017-07-28 14:03:52',0,132,146),
	(26,'2017-07-28 14:03:56',6,15,148),
	(27,'2017-07-28 14:04:13',6,29,156),
	(28,'2017-07-28 14:04:20',6,99,90),
	(29,'2017-07-28 14:04:31',6,63,157),
	(30,'2017-07-28 14:04:46',6,100,158);

/*!40000 ALTER TABLE `responses` ENABLE KEYS */;
UNLOCK TABLES;


# Export von Tabelle user_sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user_sessions`;

CREATE TABLE `user_sessions` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `start_datetime` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `finish_datetime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `user_name` varchar(20000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;

INSERT INTO `user_sessions` (`id`, `start_datetime`, `finish_datetime`, `user_name`)
VALUES
	(1,'2017-07-28 12:43:46','2017-07-28 12:44:25','null'),
	(2,'2017-07-28 12:46:35','2017-07-28 12:47:14','null'),
	(3,'2017-07-28 12:51:07','2017-07-28 12:51:40','cornelius'),
	(4,'2017-07-28 12:54:51','2017-07-28 12:56:28','cornelius'),
	(5,'2017-07-28 12:58:35','2017-07-28 13:00:09','null'),
	(6,'2017-07-28 14:03:52','2017-07-28 14:04:49','cornelius');

/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
