-- MySQL dump 10.13  Distrib 5.7.27, for Linux (x86_64)
--
-- Host: localhost    Database: microBlog
-- ------------------------------------------------------
-- Server version	5.7.27-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户唯一ID',
  `username` varchar(30) NOT NULL COMMENT '用户名',
  `password` varchar(50) NOT NULL COMMENT '密码',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `phone_num` varchar(15) DEFAULT NULL COMMENT '手机号',
  `create_time` timestamp NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `credit` int(11) NOT NULL COMMENT '积分',
  `avatar` varchar(100) DEFAULT NULL COMMENT '头像url',
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '用户类型,0为普通用户,1为管理员',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (32,'Java天下第一','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13430008084','2019-06-03 02:46:22','2019-09-12 07:51:48',80,'resources/images/avatar-default-7.png',0),(33,'Cici','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13430008084','2019-06-03 03:25:42','2019-09-12 08:00:11',46,'resources/images/avatar-default-7.png',0),(34,'java','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13430008084','2019-06-03 03:37:06','2019-09-12 08:03:39',22,'resources/images/avatar-default-7.png',0),(35,'xixi','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13430008084','2019-06-06 02:45:25','2019-09-12 07:53:21',69,'resources/images/avatar-default-7.png',0),(36,'123','202cb962ac59075b964b07152d234b70','1013171543@qq.com','13430008084','2019-06-23 07:10:31','2019-09-12 07:53:21',10,'resources/images/avatar-default-7.png',0),(37,'admin','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13430008084','2019-06-24 02:33:47','2019-09-12 07:53:21',1,'resources/images/avatar-default-7.png',0),(38,'789','68053af2923e00204c3ca7c6a3150cf7','1013171543@qq.com','13430008084','2019-06-24 02:44:20','2019-09-12 07:53:21',2,'resources/images/avatar-default-7.png',0),(39,'abc','e10adc3949ba59abbe56e057f20f883e','1013171543@qq.com','13421158302','2019-08-01 06:00:50','2019-09-12 08:04:40',2,'resources/images/avatar-default-7.png',0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-09-12 16:21:50
