-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: futbol
-- ------------------------------------------------------
-- Server version	8.4.4

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `codemast`
--

DROP TABLE IF EXISTS `codemast`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `codemast` (
  `Type` varchar(10) NOT NULL DEFAULT '',
  `Code` varchar(10) NOT NULL DEFAULT '',
  `Description` varchar(30) NOT NULL DEFAULT '',
  PRIMARY KEY (`Type`,`Code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codemast`
--

LOCK TABLES `codemast` WRITE;
/*!40000 ALTER TABLE `codemast` DISABLE KEYS */;
INSERT INTO `codemast` VALUES ('DEVICETYPE','D','Desktop'),('DEVICETYPE','M','Mobile'),('DEVICETYPE','ML','Mobile Landscape'),('DEVICETYPE','MP','Mobile Portrait'),('DEVICETYPE','T','Tablet'),('DEVICETYPE','TL','Tablet Landscape'),('DEVICETYPE','TP','Tablet Portrait');
/*!40000 ALTER TABLE `codemast` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codetype`
--

DROP TABLE IF EXISTS `codetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `codetype` (
  `Type` varchar(10) NOT NULL DEFAULT '',
  `Description` varchar(30) NOT NULL DEFAULT '',
  `Comment` mediumtext,
  PRIMARY KEY (`Type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codetype`
--

LOCK TABLES `codetype` WRITE;
/*!40000 ALTER TABLE `codetype` DISABLE KEYS */;
INSERT INTO `codetype` VALUES ('DEVICETYPE','Tipo de dispositivo','');
/*!40000 ALTER TABLE `codetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entrenador`
--

DROP TABLE IF EXISTS `entrenador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrenador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL,
  `EquipoID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqEntrenadorEquipo` (`EquipoID`),
  KEY `IDX_entrenador_Apellido_ID` (`Apellido`,`ID`) USING BTREE,
  CONSTRAINT `fk_entrenador_equipo` FOREIGN KEY (`EquipoID`) REFERENCES `equipo` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entrenador`
--

LOCK TABLES `entrenador` WRITE;
/*!40000 ALTER TABLE `entrenador` DISABLE KEYS */;
INSERT INTO `entrenador` VALUES (1,'Carlo','Ancelotti','Italiano',1),(2,'Hansi','Flick','Alemán',2),(3,'Diego','Simeone','Argentino',3),(4,'Pep','Guardiola','Español',4),(5,'Arne','Slot','Neerlandés',5),(6,'Mikel','Arteta','Español',6),(7,'Alvaro','Arbeloa','Español',NULL);
/*!40000 ALTER TABLE `entrenador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(120) NOT NULL,
  `LigaID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqEquipoNombreLiga` (`LigaID`,`Nombre`),
  CONSTRAINT `fk_Equipo_LigaID` FOREIGN KEY (`LigaID`) REFERENCES `liga` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (3,'Atlético de Madrid',1),(2,'FC Barcelona',1),(1,'Real Madrid',1),(6,'Arsenal FC',2),(5,'Liverpool FC',2),(4,'Manchester City',2);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hijoentrenador`
--

DROP TABLE IF EXISTS `hijoentrenador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hijoentrenador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `entrenadorID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `hijoEntrenador_entrenador_FK` (`entrenadorID`),
  KEY `hijoentrenador_Name_IDX` (`Name`,`ID`) USING BTREE,
  CONSTRAINT `hijoEntrenador_entrenador_FK` FOREIGN KEY (`entrenadorID`) REFERENCES `entrenador` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hijoentrenador`
--

LOCK TABLES `hijoentrenador` WRITE;
/*!40000 ALTER TABLE `hijoentrenador` DISABLE KEYS */;
INSERT INTO `hijoentrenador` VALUES (1,'HijoHansi',2),(2,'HijoArteta',6);
/*!40000 ALTER TABLE `hijoentrenador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `hijojugador`
--

DROP TABLE IF EXISTS `hijojugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `hijojugador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `jugadorID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `hijojugador_jugador_FK` (`jugadorID`),
  KEY `hijojugador_Name_IDX` (`Name`,`ID`),
  CONSTRAINT `hijojugador_jugador_FK` FOREIGN KEY (`jugadorID`) REFERENCES `jugador` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `hijojugador`
--

LOCK TABLES `hijojugador` WRITE;
/*!40000 ALTER TABLE `hijojugador` DISABLE KEYS */;
INSERT INTO `hijojugador` VALUES (1,'hijoCourtois',1),(2,'HijoJulianAlvarez',30);
/*!40000 ALTER TABLE `hijojugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(60) NOT NULL,
  `Apellido` varchar(60) NOT NULL,
  `Nacionalidad` varchar(50) DEFAULT NULL,
  `EquipoID` int DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `fkJugadorEquipo` (`EquipoID`),
  KEY `IDX_jugador_Apellido_ID` (`Apellido`,`ID`) USING BTREE,
  CONSTRAINT `fkJugadorEquipo` FOREIGN KEY (`EquipoID`) REFERENCES `equipo` (`ID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugador`
--

LOCK TABLES `jugador` WRITE;
/*!40000 ALTER TABLE `jugador` DISABLE KEYS */;
INSERT INTO `jugador` VALUES (1,'Thibaut','Courtois','Belga',1),(2,'Dani','Carvajal','Español',1),(3,'Antonio','Rüdiger','Alemán',1),(4,'Éder','Militão','Brasileño',1),(5,'Ferland','Mendy','Francés',1),(6,'Federico','Valverde','Uruguayo',1),(7,'Jude','Bellingham','Inglés',1),(8,'Eduardo','Camavinga','Francés',1),(9,'Vinícius','Junior','Brasileño',1),(10,'Kylian','Mbappé','Francés',1),(11,'Marc-André','ter Stegen','Alemán',2),(12,'Jules','Koundé','Francés',2),(13,'Pau','Cubarsí','Español',2),(14,'Alejandro','Balde','Español',2),(15,'Pedri','González','Español',2),(16,'Gavi','Páez','Español',2),(17,'Frenkie','de Jong','Neerlandés',2),(18,'Lamine','Yamal','Español',2),(19,'Robert','Lewandowski','Polaco',2),(20,'Raphinha','Dias','Brasileño',2),(21,'Jan','Oblak','Esloveno',3),(22,'Nahuel','Molina','Argentino',3),(23,'Robin','Le Normand','Español',3),(24,'José María','Giménez','Uruguayo',3),(25,'Reinildo','Mandava','Mozambiqueño',3),(26,'Koke','Resurrección','Español',3),(27,'Rodrigo','De Paul','Argentino',3),(28,'Marcos','Llorente','Español',3),(29,'Antoine','Griezmann','Francés',3),(30,'Julián','Álvarez','Argentino',3),(31,'Ederson','Moraes','Brasileño',4),(32,'Kyle','Walker','Inglés',4),(33,'Ruben','Dias','Portugués',4),(34,'John','Stones','Inglés',4),(35,'Rodri','Hernández','Español',4),(36,'Kevin','De Bruyne','Belga',4),(37,'Bernardo','Silva','Portugués',4),(38,'Phil','Foden','Inglés',4),(39,'Jack','Grealish','Inglés',4),(40,'Erling','Haaland','Noruego',4),(41,'Alisson','Becker','Brasileño',5),(42,'Trent','Alexander-Arnold','Inglés',5),(43,'Virgil','van Dijk','Neerlandés',5),(44,'Ibrahima','Konaté','Francés',5),(45,'Andrew','Robertson','Escocés',5),(46,'Alexis','Mac Allister','Argentino',5),(47,'Dominik','Szoboszlai','Húngaro',5),(48,'Luis','Díaz','Colombiano',5),(49,'Mohamed','Salah','Egipcio',5),(50,'Darwin','Núñez','Uruguayo',5),(51,'David','Raya','Español',6),(52,'Ben','White','Inglés',6),(53,'William','Saliba','Francés',6),(54,'Gabriel','Magalhães','Brasileño',6),(55,'Declan','Rice','Inglés',6),(56,'Martin','Ødegaard','Noruego',6),(57,'Mikel','Merino','Español',6),(58,'Bukayo','Saka','Inglés',6),(59,'Gabriel','Martinelli','Brasileño',6),(60,'Kai','Havertz','Alemán',6);
/*!40000 ALTER TABLE `jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugadorposicion`
--

DROP TABLE IF EXISTS `jugadorposicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugadorposicion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `JugadorID` int NOT NULL,
  `PosicionID` int NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqJugadorPosicion` (`JugadorID`,`PosicionID`),
  KEY `fkJPPosicion` (`PosicionID`),
  CONSTRAINT `fkJPJugador` FOREIGN KEY (`JugadorID`) REFERENCES `jugador` (`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fkJPPosicion` FOREIGN KEY (`PosicionID`) REFERENCES `posicion` (`ID`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugadorposicion`
--

LOCK TABLES `jugadorposicion` WRITE;
/*!40000 ALTER TABLE `jugadorposicion` DISABLE KEYS */;
/*!40000 ALTER TABLE `jugadorposicion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `liga`
--

DROP TABLE IF EXISTS `liga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liga` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(100) NOT NULL,
  `Pais` varchar(50) NOT NULL,
  `Equipos` int NOT NULL DEFAULT '0',
  `EquiposMax` int NOT NULL DEFAULT '20',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqLigaNombrePais` (`Nombre`,`Pais`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `liga`
--

LOCK TABLES `liga` WRITE;
/*!40000 ALTER TABLE `liga` DISABLE KEYS */;
INSERT INTO `liga` VALUES (1,'LaLiga','España',3,20),(2,'Premier League','Inglaterra',3,20);
/*!40000 ALTER TABLE `liga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nietodehijos`
--

DROP TABLE IF EXISTS `nietodehijos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nietodehijos` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `hijoJugadorID` int NOT NULL,
  `hijoEntrenadorID` int NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `NietoDeHijos_hijojugador_FK` (`hijoJugadorID`),
  KEY `NietoDeHijos_hijoentrenador_FK` (`hijoEntrenadorID`),
  CONSTRAINT `NietoDeHijos_hijoentrenador_FK` FOREIGN KEY (`hijoEntrenadorID`) REFERENCES `hijoentrenador` (`ID`),
  CONSTRAINT `NietoDeHijos_hijojugador_FK` FOREIGN KEY (`hijoJugadorID`) REFERENCES `hijojugador` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nietodehijos`
--

LOCK TABLES `nietodehijos` WRITE;
/*!40000 ALTER TABLE `nietodehijos` DISABLE KEYS */;
INSERT INTO `nietodehijos` VALUES (1,'NIetoCourtoisHansi',1,1),(2,'Nuevo nieto',1,1),(3,'otro mas',2,1);
/*!40000 ALTER TABLE `nietodehijos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posicion`
--

DROP TABLE IF EXISTS `posicion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posicion` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `uqPosicionNombre` (`Nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posicion`
--

LOCK TABLES `posicion` WRITE;
/*!40000 ALTER TABLE `posicion` DISABLE KEYS */;
INSERT INTO `posicion` VALUES (3,'Centrocampista'),(2,'Defensa'),(4,'Delantero'),(6,'Manolito'),(5,'Pepito'),(1,'Portero');
/*!40000 ALTER TABLE `posicion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `webappsession`
--

DROP TABLE IF EXISTS `webappsession`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `webappsession` (
  `SessionKey` varchar(36) NOT NULL DEFAULT '',
  `CreateDate` date NOT NULL DEFAULT '0001-01-01',
  `CreateTime` varchar(8) NOT NULL DEFAULT '',
  `LastAccessDate` date NOT NULL DEFAULT '0001-01-01',
  `LastAccessTime` varchar(8) NOT NULL DEFAULT '',
  `UseCount` int NOT NULL DEFAULT '0',
  `RemoteAddress` varchar(57) NOT NULL DEFAULT '',
  `LoginName` varchar(20) NOT NULL DEFAULT '',
  `Active` varchar(1) NOT NULL DEFAULT '',
  PRIMARY KEY (`SessionKey`),
  UNIQUE KEY `WebAppSession002` (`CreateDate`,`CreateTime`,`SessionKey`),
  UNIQUE KEY `WebAppSession003` (`LastAccessDate`,`LastAccessTime`,`SessionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `webappsession`
--

LOCK TABLES `webappsession` WRITE;
/*!40000 ALTER TABLE `webappsession` DISABLE KEYS */;
INSERT INTO `webappsession` VALUES ('0nAukJwKkYIoJEtsDPlCEWWxpPYVKvIJvhzr','2026-03-13','14:08:08','2026-03-13','14:30:53',54,'::1','Daniel','Y'),('12Eoj2AAwIvBbL0HCMOcN6E2XGPmE7zbEUMZ','2026-03-13','11:34:48','2026-03-13','11:35:29',14,'::1','Daniel','Y'),('3AkNVB0Jo1LEYxUXRqOyfIB5MbMMOK83QAdw','2026-03-11','11:35:37','2026-03-11','11:48:21',69,'::1','Daniel','Y'),('41A9Bn6DWHP6blIJWcdcRm7J3wRAPRMU0tut','2026-03-09','12:01:14','2026-03-09','12:01:22',8,'::1','Daniel','Y'),('5E0jdi5t6hMJxbawGl1l6IgsbE85uFjoK1ZO','2026-03-12','15:10:33','2026-03-12','16:28:45',96,'::1','Daniel','Y'),('6K9tOcNzGbpEbY2c8GDFj8FNcNg4EKPsKYv1','2026-03-11','16:21:11','2026-03-11','17:02:43',31,'::1','Daniel','Y'),('bQ1yiKnJhf4jALEsEXwAwFevHC2OMH0cX90F','2026-03-13','14:02:23','2026-03-13','14:07:45',18,'::1','Daniel','Y'),('c3J476LsdBqCJD4UW5VW12AAg7sHxwpVa5qx','2026-03-18','12:19:26','2026-03-18','12:21:17',11,'::1','Daniel','Y'),('c4QM26dVwbTbR1Ii4MCzOGB0rRZDGOUPVEvZ','2026-03-13','14:00:28','2026-03-13','14:00:39',6,'::1','Daniel','Y'),('dsk0vqAh52Odzc5TKkog0GrfOXNLd0wJ2xFA','2026-03-19','13:01:25','2026-03-19','13:08:41',53,'::1','Daniel','Y'),('hUIzOkj7aTCvVghAnz6ULqcwLvI4A52PQjiA','2026-03-16','11:11:37','2026-03-16','12:01:44',43,'::1','Daniel','Y'),('jsfZ8lm2lYplpAo2hwyvwHvTKMU7N1qCgGBe','2026-03-13','14:31:59','2026-03-13','15:28:32',107,'::1','Daniel','Y'),('Lb6XzOXnJgANFmnPzmQJQugbpxt0KPVAKdZb','2026-03-09','11:55:47','2026-03-09','11:55:47',1,'::1','','Y'),('lLHTEhy5nzAjKMfAUq0CcEVxTXzEpHKFpium','2026-03-09','12:03:59','2026-03-09','12:14:54',49,'::1','Daniel','Y'),('nTKKj6ixFca2ExzFOZvJEcf60V9FKzwNXzUn','2026-03-10','16:54:18','2026-03-10','16:54:26',8,'::1','Daniel','Y'),('PvHs3S8OjNvUM7wCY1yEDlqkAL2DQL3XnI8n','2026-03-13','14:31:15','2026-03-13','14:31:43',12,'::1','Daniel','Y'),('qJW6r4JcVVFTbZreMMRdIPxNGVuZMRXgskpO','2026-03-16','14:43:40','2026-03-16','15:01:05',17,'::1','admin','Y'),('RHr7ConPdVmtOrn5UeeQU84dDXbe48tGyv8O','2026-03-20','11:30:06','2026-03-20','12:04:29',157,'::1','Daniel','Y'),('SE31vdCgZmwMie78vRAl0ir1IdHVFpptUCCM','2026-03-19','10:42:03','2026-03-19','12:37:38',212,'::1','Daniel','Y'),('sEh7t5VbEq66qtt9jJR0nYf9YGuIgX4FOKfY','2026-03-09','11:56:42','2026-03-09','11:59:52',37,'::1','Daniel','Y'),('T6IB2X4v9RgZPlHWUKIUVYlsfz4gsPpOgC93','2026-03-16','16:21:32','2026-03-16','16:22:26',15,'::1','Daniel','Y'),('TDpRToqL10fdTJfNBiDtdb1sAvHkKleulsTW','2026-03-19','13:31:52','2026-03-19','13:33:58',18,'::1','Daniel','Y'),('uoiKHf1SNzlPsBfq5dj20lj0J6UunJFbOaM1','2026-03-16','13:32:13','2026-03-16','16:01:42',242,'::1','Daniel','Y'),('ZJxplzjcBprEci76e6rJ36Hm86vRZByFdWYj','2026-03-16','16:32:16','2026-03-16','16:46:04',53,'::1','Daniel','Y');
/*!40000 ALTER TABLE `webappsession` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'futbol'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-20 12:42:30
