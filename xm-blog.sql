# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.20)
# Database: xm-blog
# Generation Time: 2024-06-16 20:35:28 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of item
# ------------------------------------------------------------

DROP TABLE IF EXISTS `item`;

CREATE TABLE `item` (
                        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                        `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'item Name',
                        `descr` varchar(1000) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'item Description',
                        `content` longtext COLLATE utf8mb4_unicode_ci COMMENT 'item Content',
                        `time` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'Found/Lost time',
                        `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Found/Lost Location',
                        `custodian` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Custodian',
                        `read_count` int(11) DEFAULT '0' COMMENT 'Reads',
                        `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Cover',
                        PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='item';

LOCK TABLES `item` WRITE;

INSERT INTO `item` (`id`, `name`, `descr`, `content`, `time`, `address`, `custodian`, `read_count`, `cover`)
VALUES
    (1,'Wallet','black','student id named tom inside', '2023-12-06','Cambie 139','Front-desk',0,'http://localhost:9090/files/1718569314516-istockphoto-1345542613-612x612.jpeg');

UNLOCK TABLES;


# Dump of table item_sign
# ------------------------------------------------------------

# Dump of table item_sign
# ------------------------------------------------------------

DROP TABLE IF EXISTS `item_sign`;
CREATE TABLE `item_sign` (
                             `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                             `item_id` int(11) DEFAULT NULL COMMENT 'item ID',
                             `user_id` int(11) DEFAULT NULL COMMENT 'User ID',
                             `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Register time',
                             PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='item_sign';

LOCK TABLES `item_sign` WRITE;
/*!40000 ALTER TABLE `item_sign` DISABLE KEYS */;

INSERT INTO `item_sign` (`id`, `item_id`, `user_id`, `time`)
VALUES
    (4,7,4,'2023-12-12 12:15:28'),
    (5,9,5,'2023-12-12 15:40:11'),
    (6,8,5,'2023-12-12 16:44:59'),
    (7,7,5,'2023-12-12 16:45:02'),
    (8,5,5,'2023-12-12 16:45:05');

/*!40000 ALTER TABLE `item_sign` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table admin
# ------------------------------------------------------------

UNLOCK TABLES;
LOCK TABLES `admin` WRITE;
DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
                         `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                         `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'UserName',
                         `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Password',
                         `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name',
                         `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Avatar',
                         `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Role tag',
                         `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Phone',
                         `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='admin';

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;

INSERT INTO `admin` (`id`, `username`, `password`, `name`, `avatar`, `role`, `phone`, `email`)
VALUES
    (1,'admin','admin','Admin','http://localhost:9090/files/1697438073596-avatar.png','ADMIN','6725586896','admin@hotmail.com');

/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table post
# ------------------------------------------------------------

DROP TABLE IF EXISTS `post`;

CREATE TABLE `post` (
                        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                        `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title',
                        `content` longtext COLLATE utf8mb4_unicode_ci COMMENT 'Content',
                        `descr` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Description',
                        `cover` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Cover',
                        `tags` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Tags',
                        `user_id` int(11) DEFAULT NULL COMMENT 'Creator ID',
                        `date` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Publishment time',
                        `read_count` int(11) DEFAULT '0' COMMENT 'Reads',
                        `category_id` int(11) DEFAULT NULL COMMENT 'Category ID',
                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='blog';

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;

INSERT INTO `post` (`id`, `title`, `content`, `descr`, `cover`, `tags`, `user_id`, `date`, `read_count`, `category_id`)
VALUES
    (1,'Brand new xbox','<p>Welcome to Fairleigh Dickinson University’s Metropolitan Campus, located in the suburban communities of Teaneck and Hackensack, New Jersey, just six miles from the George Washington Bridge leading into Manhattan. Metro Campus students have the opportunity to enjoy everything that New York City has to offer, as well as the best of Northern New Jersey, from world-class shopping malls to rural farming communities and everything in between.</p><p>Offering a wide range of majors that lead to Associate, Bachelor, Masters, and Doctoral degrees, the campus hosts students from throughout the United States and the world, including international students from over 80 countries. There are study abroad opportunities at FDU campuses in Wroxton, England and Vancouver, Canada, and at its many partner institutions throughout the world.</p><p>With the objective of providing students a holistic, engaging, and enriching academic, social, and cultural experience, the campus offers 70 student organizations and over 2,000 events and activities annually. As a Division I NCAA institution, the Metropolitan Campus offers 18 separate sports, as well as a wide range of intramural athletics.</p>','I am Ok','http://localhost:9090/files/1701833847024-微信截图_20231117155458.png','[\"Algorithm\"]',4,'2023-11-17',109,1);

/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table category
# ------------------------------------------------------------

UNLOCK TABLES;
LOCK TABLES `category` WRITE;
DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
                            `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                            `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'CategoryName',
                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='category';

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;

INSERT INTO `category` (`id`, `name`)
VALUES
    (1,'Market Place'),
    (2,'Job Opportunities'),
    (3,'Study Experiences');

/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;


DROP TABLE IF EXISTS `collect`;

CREATE TABLE `collect` (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `fid` int(11) DEFAULT NULL COMMENT 'RelatedID',
                           `user_id` int(11) DEFAULT NULL COMMENT 'Like User-ID',
                           `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Module',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='collect';

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;

INSERT INTO `collect` (`id`, `fid`, `user_id`, `module`)
VALUES
    (26,26,5,'post'),
    (31,26,4,'post'),
    (42,9,4,'item'),
    (43,28,5,'post'),
    (44,4,5,'post'),
    (45,10,5,'item'),
    (46,5,5,'item'),
    (47,9,5,'item'),
    (48,29,12,'post'),
    (49,8,12,'item');

/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table comment
# ------------------------------------------------------------

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
                           `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                           `content` varchar(500) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Content',
                           `user_id` int(11) DEFAULT NULL COMMENT 'Viewer Id',
                           `pid` int(11) DEFAULT NULL COMMENT 'Parent ID',
                           `root_id` int(11) DEFAULT NULL COMMENT 'Root ID',
                           `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Comment time',
                           `fid` int(11) DEFAULT NULL COMMENT 'Related ID',
                           `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Module',
                           PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='comment';



# Dump of table likes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `likes`;

CREATE TABLE `likes` (
                         `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                         `fid` int(11) DEFAULT NULL COMMENT 'Related ID',
                         `user_id` int(11) DEFAULT NULL COMMENT 'Likes ID',
                         `module` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Module',
                         PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='likes';

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;

INSERT INTO `likes` (`id`, `fid`, `user_id`, `module`)
VALUES
    (25,3,5,'post'),
    (26,4,5,'post'),
    (27,26,5,'post'),
    (30,25,4,'post'),
    (31,3,4,'post'),
    (33,26,1,'post'),
    (41,26,4,'post'),
    (53,9,4,'item'),
    (55,28,5,'post'),
    (56,8,5,'item'),
    (59,9,5,'item'),
    (60,29,12,'post'),
    (61,8,12,'item');

/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table notice
# ------------------------------------------------------------

DROP TABLE IF EXISTS `notice`;

CREATE TABLE `notice` (
                          `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                          `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Title',
                          `content` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Content',
                          `time` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Creat time',
                          `user` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Creator',
                          PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='notice';

LOCK TABLES `notice` WRITE;
/*!40000 ALTER TABLE `notice` DISABLE KEYS */;

INSERT INTO `notice` (`id`, `title`, `content`, `time`, `user`)
VALUES
    (1,'The systerm is going on, start to test.','The systerm is going on, start to test.','2023-09-05','admin'),
    (2,'All finished, you can work it!','All finished, you can work it!','2023-09-05','admin');

/*!40000 ALTER TABLE `notice` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table user
# ------------------------------------------------------------

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
                        `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'ID',
                        `username` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'User Name',
                        `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Password',
                        `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Name',
                        `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Avatar',
                        `role` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Role tag',
                        `sex` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Gender',
                        `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Phone',
                        `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Email',
                        `info` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Description',
                        `birth` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Birthday',
                        PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='user';

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;

INSERT INTO `user` (`id`, `username`, `password`, `name`, `avatar`, `role`, `sex`, `phone`, `email`, `info`, `birth`)
VALUES
    (4,'ccc','123','Andony','http://localhost:9090/files/1702263503066-微信截图_20231114162559.png','USER','Female','1398899778',NULL,'I am a good person and handsome.',NULL),
    (5,'aaa','123','aaa','http://localhost:9090/files/1702263511014-微信截图_20231018172251.png','USER',NULL,'13899887788','aaa@xm.com','',NULL),
    (9,'vvv','123','vvv','http://localhost:9090/files/1701672091418-微信截图_20231114162516.png','USER','Male','13988776689','vvv@xm.com','You can add me.','2000-12-01'),
    (10,'acc','123','acc','http://localhost:9090/files/1702263517115-微信截图_20231018172452.png','USER',NULL,NULL,NULL,NULL,NULL),
    (11,'abc','1234','abc','http://localhost:9090/files/1701745246171-微信截图_20231114162404.png','USER',NULL,'13899887799',NULL,NULL,NULL),
    (12,'aff','123','aff','http://localhost:9090/files/1702376508412-微信截图_20231018172452.png','USER',NULL,NULL,NULL,NULL,NULL),
    (13,'test','123456','test',NULL,'USER',NULL,NULL,NULL,NULL,NULL);

/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
