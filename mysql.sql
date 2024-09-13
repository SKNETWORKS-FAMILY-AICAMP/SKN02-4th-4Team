-- MySQL dump 10.13  Distrib 8.0.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: test
-- ------------------------------------------------------
-- Server version	8.0.17

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add chat history',7,'add_chathistory'),(26,'Can change chat history',7,'change_chathistory'),(27,'Can delete chat history',7,'delete_chathistory'),(28,'Can view chat history',7,'view_chathistory'),(29,'Can add message',8,'add_message'),(30,'Can change message',8,'change_message'),(31,'Can delete message',8,'delete_message'),(32,'Can view message',8,'view_message'),(33,'Can add chat',9,'add_chat'),(34,'Can change chat',9,'change_chat'),(35,'Can delete chat',9,'delete_chat'),(36,'Can view chat',9,'view_chat');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$600000$Scyyk6FM30FKUOYmGQ0b9z$TZN3fn9SiJE7OHCzwitA34/gScQ1ui05UH4T76g7X2k=','2024-09-13 07:15:19.336208',1,'root','','','root@roor.com',1,1,'2024-09-12 07:56:19.252981'),(2,'pbkdf2_sha256$600000$RN0fUdZ6Vudm89XnVbHIGl$T0jM1k+MTKMTYd+j3bLltQRlFzWuAKxyAkIc3YbxlxA=','2024-09-13 05:00:24.714299',1,'skn','','','akn@akn.com',1,1,'2024-09-13 04:59:45.987403');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_chat`
--

DROP TABLE IF EXISTS `chat_chat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_chat` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_chat_user_id_bbe8a5b9_fk_auth_user_id` (`user_id`),
  CONSTRAINT `chat_chat_user_id_bbe8a5b9_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_chat`
--

LOCK TABLES `chat_chat` WRITE;
/*!40000 ALTER TABLE `chat_chat` DISABLE KEYS */;
INSERT INTO `chat_chat` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `chat_chat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chat_message`
--

DROP TABLE IF EXISTS `chat_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_message` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message` longtext NOT NULL,
  `is_user` tinyint(1) NOT NULL,
  `chat_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `chat_message_chat_id_21483fa7_fk_chat_chat_id` (`chat_id`),
  CONSTRAINT `chat_message_chat_id_21483fa7_fk_chat_chat_id` FOREIGN KEY (`chat_id`) REFERENCES `chat_chat` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_message`
--

LOCK TABLES `chat_message` WRITE;
/*!40000 ALTER TABLE `chat_message` DISABLE KEYS */;
INSERT INTO `chat_message` VALUES (1,'캐스퍼는 험한길에서 주행 어떻게 해야해',1,1),(2,'캐스퍼는 험한 길에서 주행할 때 몇 가지 주의사항이 있습니다. \n\n1. **속도 조절**: 험한 길에서는 속도를 줄이고, 주행 상황에 맞게 조절하는 것이 중요합니다. 급격한 가속이나 감속은 차량의 안정성을 해칠 수 있습니다.\n\n2. **타이어 상태 확인**: 험한 길에서는 타이어의 상태가 매우 중요합니다. 적절한 공기압과 마모 상태를 확인하고, 필요시 교체하세요.\n\n3. **주행 모드 선택**: 캐스퍼의 경우, 주행 모드가 있다면 험한 길에 적합한 모드를 선택하세요. 이는 차량의 성능을 최적화하는 데 도움이 됩니다.\n\n4. **장애물 주의**: 도로에 있는 장애물이나 구덩이를 미리 인지하고, 피할 수 있도록 주의 깊게 운전하세요.\n\n5. **안전 거리 유지**: 앞차와의 안전 거리를 충분히 유지하여 예기치 않은 상황에 대처할 수 있도록 합니다.\n\n6. **브레이크 사용**: 험한 길에서는 브레이크를 부드럽게 사용하여 차량의 균형을 유지하세요.\n\n이 외에도 차량의 매뉴얼을 참고하여 험한 길 주행에 대한 구체적인 조언을 확인하는 것이 좋습니다. 추가적인 질문이 있다면 말씀해 주세요!',0,1),(3,'캐스퍼는 험한길에서 주행 어떻게 해야해',1,1),(4,'캐스퍼는 험한 길에서 주행할 때 몇 가지 주의사항이 있습니다. \n\n1. **속도 조절**: 험한 길에서는 속도를 줄이고, 주행 상황에 맞게 조절하는 것이 중요합니다. 급격한 가속이나 감속은 차량의 안정성을 해칠 수 있습니다.\n\n2. **타이어 상태 확인**: 험한 길에서는 타이어의 상태가 매우 중요합니다. 적절한 공기압과 마모 상태를 확인하고, 필요시 교체하세요.\n\n3. **주행 모드 선택**: 캐스퍼의 경우, 주행 모드가 있다면 험한 길에 적합한 모드를 선택하세요. 이는 차량의 성능을 최적화하는 데 도움이 됩니다.\n\n4. **장애물 주의**: 도로에 있는 장애물이나 구덩이를 미리 인지하고, 피할 수 있도록 주의 깊게 운전하세요.\n\n5. **안전 거리 유지**: 앞차와의 안전 거리를 충분히 유지하여 예기치 않은 상황에 대처할 수 있도록 합니다.\n\n6. **브레이크 사용**: 험한 길에서는 브레이크를 부드럽게 사용하여 차량의 균형을 유지하세요.\n\n이 외에도 차량의 매뉴얼을 참고하여 험한 길 주행에 대한 구체적인 조언을 확인하는 것이 좋습니다. 추가적인 질문이 있다면 말씀해 주세요!',0,1),(5,'아반떼의 스마트키 배터리가 없을 때 어떻게 차문을 열어야해?',1,1),(6,'아반떼의 스마트키 배터리가 방전되었을 때 차문을 여는 방법은 다음과 같습니다:\n\n1. **스마트키의 물리적 키 사용**: 대부분의 아반떼 스마트키에는 물리적인 키가 내장되어 있습니다. 스마트키의 측면이나 뒷면에 있는 버튼을 눌러 물리적 키를 꺼내세요.\n\n2. **차문 열기**: 꺼낸 물리적 키를 사용하여 운전석 도어의 잠금을 해제합니다. 일반적으로 키를 잠금 장치에 삽입하고 돌리면 문이 열립니다.\n\n3. **스마트키 배터리 교체**: 문을 연 후에는 스마트키의 배터리를 교체하여 다시 정상적으로 사용할 수 있도록 합니다.\n\n이 방법으로도 문제가 해결되지 않거나 추가적인 도움이 필요하다면, 차량 매뉴얼을 참조하거나 가까운 서비스 센터에 문의하시기 바랍니다.',0,1);
/*!40000 ALTER TABLE `chat_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatbot_chathistory`
--

DROP TABLE IF EXISTS `chatbot_chathistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatbot_chathistory` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_input` longtext NOT NULL,
  `bot_response` longtext NOT NULL,
  `timestamp` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatbot_chathistory`
--

LOCK TABLES `chatbot_chathistory` WRITE;
/*!40000 ALTER TABLE `chatbot_chathistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `chatbot_chathistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(9,'chat','chat'),(8,'chat','message'),(7,'chatbot','chathistory'),(5,'contenttypes','contenttype'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2024-09-12 14:39:19.640499'),(2,'auth','0001_initial','2024-09-12 14:39:20.352272'),(3,'admin','0001_initial','2024-09-12 14:39:20.514316'),(4,'admin','0002_logentry_remove_auto_add','2024-09-12 14:39:20.527856'),(5,'admin','0003_logentry_add_action_flag_choices','2024-09-12 14:39:20.540397'),(6,'contenttypes','0002_remove_content_type_name','2024-09-12 14:39:20.679857'),(7,'auth','0002_alter_permission_name_max_length','2024-09-12 14:39:20.764159'),(8,'auth','0003_alter_user_email_max_length','2024-09-12 14:39:20.801791'),(9,'auth','0004_alter_user_username_opts','2024-09-12 14:39:20.814311'),(10,'auth','0005_alter_user_last_login_null','2024-09-12 14:39:20.902155'),(11,'auth','0006_require_contenttypes_0002','2024-09-12 14:39:20.907154'),(12,'auth','0007_alter_validators_add_error_messages','2024-09-12 14:39:20.921748'),(13,'auth','0008_alter_user_username_max_length','2024-09-12 14:39:21.009580'),(14,'auth','0009_alter_user_last_name_max_length','2024-09-12 14:39:21.117966'),(15,'auth','0010_alter_group_name_max_length','2024-09-12 14:39:21.147094'),(16,'auth','0011_update_proxy_permissions','2024-09-12 14:39:21.160654'),(17,'auth','0012_alter_user_first_name_max_length','2024-09-12 14:39:21.244444'),(18,'chatbot','0001_initial','2024-09-12 14:39:21.270553'),(19,'chatbot','0002_chathistory_delete_conversation','2024-09-12 14:39:21.311681'),(20,'chatbot','0003_alter_chathistory_user_input','2024-09-12 14:39:21.360891'),(21,'sessions','0001_initial','2024-09-12 14:39:21.406045'),(22,'chat','0001_initial','2024-09-12 07:55:00.758972');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('1hz888g4e3yf3hp2yg8fbimj1gn1osru','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sp0WV:jDP1677LXdL_kw2H76xL5xV01eghK0Ytn9v_FwSFU0I','2024-09-27 07:15:19.344207'),('8t2tc7j4ozlruo0masd9hmk0xwz8f1f6','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sowRe:vACDf6DI8MxDuGnEo7rpRSV4WDWZYksYXZkG0MbGv5c','2024-09-27 02:54:02.061926'),('k6mnkb941j6r5d8fnhlzze5281qtzzv4','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1soehD:shE0CrDKH4xUXM7eTp0dA0JgjvKzK8oXYP8Ptv0omqI','2024-09-26 07:56:55.494148'),('kjgdlwzcizctf4bdwc8vznqu536e0y6u','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sow4T:mS2FfxJ6CRG8ehgIAUtaGqO-q9ts7GoyhJ0SKHNTMxE','2024-09-27 02:30:05.158738'),('me3ryihhijf47e38c1f3gblm2gtdwx2g','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sp07T:A3voRi8rvwDmKG92qVQJGLrNFNmsejS-a5B4MNwhtZ4','2024-09-27 06:49:27.341271'),('mq3emtrfw6hb3j3nih5sehultudovah3','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1soyN4:JGAZQgXqyy_K3Qfx-rGgskoXTRKFHlrNxox6W8gsaHc','2024-09-27 04:57:26.932716'),('ouam8bgz2bw2ss3otjnritmkwcax0aob','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sp05q:6JNaJUZJtJ_mX7OaHeN5r00f9kA1tUIFlo2S8pnHedY','2024-09-27 06:47:46.295645'),('t6iidipsous2lye7enbimvkdm1vsuk4a','.eJxVjEEOwiAQRe_C2pCBgoBL9z0DgZlBqqZNSrsy3l1JutDtf-_9l4hp32rcG69xInERWpx-t5zwwXMHdE_zbZG4zNs6ZdkVedAmx4X4eT3cv4OaWv3WoFh7tjBYjwMhZwfZQ0lOqUAaFMKZc9Ym2IBUStFsEhApg6YHTrw_5Lo4Tg:1soyPw:byVUD0-NOxMuAsSTsa13UCZy8GI71zK717uOU6vmC4k','2024-09-27 05:00:24.718818'),('w120mzgeup0edz8pq6gmt8zusoqbgwao','.eJxVjDsOwjAQBe_iGlkx_oaSnjNYu_YuDiBbipMKcXcSKQW0b2beW0RYlxLXTnOcsrgIJU6_G0J6Ut1BfkC9N5laXeYJ5a7Ig3Z5a5le18P9OyjQy1YPjs8JQtajszAAeoujcoGDJ43BpqQ9eqYQsiVkwwY5EW8NKq9MNuLzBfsiOQg:1sox6L:A39zWl-gDmRz-zL60Vp6TbcCG_7ojJi73OpxI8VuNeA','2024-09-27 03:36:05.718956');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'test'
--

--
-- Dumping routines for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-09-13 17:40:45
