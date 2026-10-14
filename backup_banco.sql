Enter password: 
-- MySQL dump 10.13  Distrib 8.0.46, for Linux (x86_64)
--
-- Host: localhost    Database: Restaurante
-- ------------------------------------------------------
-- Server version	8.0.46

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
-- Table structure for table `itens_pedido`
--

DROP TABLE IF EXISTS `itens_pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itens_pedido` (
  `id_item` int NOT NULL AUTO_INCREMENT,
  `id_pedido` int NOT NULL,
  `id_prato` int NOT NULL,
  `quantidade` int NOT NULL,
  PRIMARY KEY (`id_item`),
  KEY `id_pedido` (`id_pedido`),
  KEY `id_prato` (`id_prato`),
  CONSTRAINT `itens_pedido_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id_pedido`),
  CONSTRAINT `itens_pedido_ibfk_2` FOREIGN KEY (`id_prato`) REFERENCES `pratos` (`id_prato`),
  CONSTRAINT `itens_pedido_chk_1` CHECK ((`quantidade` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itens_pedido`
--

LOCK TABLES `itens_pedido` WRITE;
/*!40000 ALTER TABLE `itens_pedido` DISABLE KEYS */;
INSERT INTO `itens_pedido` VALUES (1,1,1,1),(2,1,15,2),(3,2,7,1),(4,2,28,1),(5,3,9,2),(6,3,16,2),(7,4,3,1),(8,4,33,2),(9,5,42,1),(10,5,17,1),(11,6,20,1),(12,6,18,2),(13,7,48,1),(14,8,5,1),(15,8,29,2),(16,9,10,1),(17,9,34,1),(18,10,8,1),(19,10,19,2),(20,11,44,2),(21,12,21,1),(22,12,35,1),(23,13,11,2),(24,14,46,1),(25,15,26,1),(26,15,30,2),(27,16,12,1),(28,17,22,1),(29,17,36,1),(30,18,50,1),(31,19,23,1),(32,19,37,2),(33,20,13,1),(34,21,43,1),(35,22,24,1),(36,22,38,1),(37,23,6,1),(38,24,49,1),(39,25,25,1),(40,25,39,2),(41,26,14,1),(42,27,45,2),(43,28,2,1),(44,28,40,1),(45,29,51,1),(46,30,27,1),(47,30,41,2);
/*!40000 ALTER TABLE `itens_pedido` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mesas`
--

DROP TABLE IF EXISTS `mesas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mesas` (
  `id_mesa` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_mesa`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mesas`
--

LOCK TABLES `mesas` WRITE;
/*!40000 ALTER TABLE `mesas` DISABLE KEYS */;
INSERT INTO `mesas` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20);
/*!40000 ALTER TABLE `mesas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `id_pedido` int NOT NULL AUTO_INCREMENT,
  `id_mesa` int NOT NULL,
  `data_hora_pedido` datetime NOT NULL,
  `tempo_preparo_minutos` decimal(6,2) NOT NULL,
  PRIMARY KEY (`id_pedido`),
  KEY `id_mesa` (`id_mesa`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_mesa`) REFERENCES `mesas` (`id_mesa`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,'2026-05-01 12:00:00',15.50),(2,2,'2026-05-01 12:05:00',22.00),(3,3,'2026-05-01 12:10:00',18.20),(4,4,'2026-05-01 12:12:00',30.00),(5,5,'2026-05-01 12:15:00',12.00),(6,6,'2026-05-01 12:20:00',25.40),(7,7,'2026-05-01 12:22:00',14.10),(8,8,'2026-05-01 12:25:00',35.00),(9,9,'2026-05-01 12:30:00',19.80),(10,10,'2026-05-01 12:32:00',28.50),(11,11,'2026-05-01 12:35:00',16.00),(12,12,'2026-05-01 12:40:00',21.30),(13,13,'2026-05-01 12:42:00',24.00),(14,14,'2026-05-01 12:45:00',13.50),(15,15,'2026-05-01 12:50:00',32.10),(16,16,'2026-05-01 12:52:00',17.60),(17,17,'2026-05-01 12:55:00',29.00),(18,18,'2026-05-01 13:00:00',20.40),(19,19,'2026-05-01 13:02:00',26.80),(20,20,'2026-05-01 13:05:00',15.00),(21,1,'2026-05-01 13:10:00',23.50),(22,2,'2026-05-01 13:12:00',18.90),(23,3,'2026-05-01 13:15:00',31.00),(24,4,'2026-05-01 13:20:00',14.50),(25,5,'2026-05-01 13:22:00',27.20),(26,6,'2026-05-01 13:25:00',21.00),(27,7,'2026-05-01 13:30:00',16.80),(28,8,'2026-05-01 13:32:00',34.50),(29,9,'2026-05-01 13:35:00',22.10),(30,10,'2026-05-01 13:40:00',19.40),(31,11,'2026-05-01 13:42:00',25.00),(32,12,'2026-05-01 13:45:00',13.00),(33,13,'2026-05-01 13:50:00',28.30),(34,14,'2026-05-01 13:52:00',17.20),(35,15,'2026-05-01 13:55:00',33.00),(36,16,'2026-05-01 14:00:00',20.90),(37,17,'2026-05-01 14:02:00',24.50),(38,18,'2026-05-01 14:05:00',15.80),(39,19,'2026-05-01 14:10:00',29.70),(40,20,'2026-05-01 14:12:00',22.40),(41,1,'2026-05-01 14:15:00',18.00),(42,2,'2026-05-01 14:20:00',26.50),(43,3,'2026-05-01 14:22:00',14.90),(44,4,'2026-05-01 14:25:00',31.20),(45,5,'2026-05-01 14:30:00',21.80),(46,6,'2026-05-01 14:32:00',16.50);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pratos`
--

DROP TABLE IF EXISTS `pratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pratos` (
  `id_prato` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(150) NOT NULL,
  `categoria` varchar(50) DEFAULT NULL,
  `complexidade` int NOT NULL,
  `tempo_base_min` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id_prato`),
  CONSTRAINT `pratos_chk_1` CHECK ((`complexidade` between 1 and 5))
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pratos`
--

LOCK TABLES `pratos` WRITE;
/*!40000 ALTER TABLE `pratos` DISABLE KEYS */;
INSERT INTO `pratos` VALUES (1,'Picanha Inteira','Churrasco',5,30.00),(2,'Picanha Meia','Churrasco',3,18.00),(3,'Cupim Inteiro','Churrasco',5,35.00),(4,'Cupim Meio','Churrasco',3,20.00),(5,'Costela na Parrilha','Churrasco',5,40.00),(6,'Frango Desossado','Churrasco',4,25.00),(7,'File de Frango a Parmegiana','Pratos Principais',4,22.00),(8,'File Mignon a Parmegiana','Pratos Principais',5,28.00),(9,'Hambrguer Brutus','Hamburguer',3,15.00),(10,'Hambrguer Favorito','Hamburguer',3,15.00),(11,'Hambrguer Brasa Cheddar','Hamburguer',3,16.00),(12,'Hambrguer Bacon Tropical','Hamburguer',4,18.00),(13,'Hambrguer Hulk','Hamburguer',4,20.00),(14,'Hambrguer Barbie','Hamburguer',3,15.00),(15,'Coca-Cola KS','Bebidas',1,2.00),(16,'Coca-Cola Lata','Bebidas',1,2.00),(17,'Sprite Lata','Bebidas',1,2.00),(18,'Schweppes Lata','Bebidas',1,2.00),(19,'Suco Natural','Bebidas',2,6.00),(20,'Executivo de File Mignon a Parmegiana','Executivos',4,20.00),(21,'Executivo de File de Frango a Parmegiana','Executivos',3,16.00),(22,'Executivo de Sobrecoxa Desossada','Executivos',3,18.00),(23,'Executivo de Cupim na Parrilla','Executivos',4,22.00),(24,'Executivo de Picanha na Parrilla','Executivos',4,22.00),(25,'Executivo de Bife Ancho','Executivos',4,20.00),(26,'Carneiro no Espeto Inteiro','Churrasco',5,40.00),(27,'Carneiro no Espeto Meio','Churrasco',3,25.00),(28,'Rio Parnaiba','Drinks',2,5.00),(29,'Tropical Gin','Drinks',2,5.00),(30,'Pink Gin','Drinks',2,5.00),(31,'Gin Tanqueray','Drinks',2,5.00),(32,'Gin Tonica Classica','Drinks',2,4.00),(33,'Caipirinha de Limao','Drinks',2,4.00),(34,'Caipirinha de Morango','Drinks',2,5.00),(35,'Caipirinha de Kiwi','Drinks',2,5.00),(36,'Caipirinha de Tangerina','Drinks',2,5.00),(37,'Caipirinha de Maracuja','Drinks',2,5.00),(38,'Caipifruta de Kiwi','Drinks',2,5.00),(39,'Caipifruta de Morango','Drinks',2,5.00),(40,'Caipifruta de Tangerina','Drinks',2,5.00),(41,'Caipifruta de Maracuja','Drinks',2,5.00),(42,'File com Fritas','Entradas',3,15.00),(43,'Carne de Sol Acebolada na Cachaca','Entradas',3,18.00),(44,'Bolinho de Costela','Entradas',2,12.00),(45,'Pasteis','Entradas',2,10.00),(46,'Isca de File de Tilapia','Entradas',3,14.00),(47,'Isca de Frango Frito','Entradas',2,12.00),(48,'Batata Frita','Entradas',1,8.00),(49,'Batata Frita com Cheddar e Bacon','Entradas',2,10.00),(50,'Trio de Pao de Alho','Entradas',1,6.00),(51,'Trio de Mini Hamburguer','Entradas',3,15.00),(52,'Picanha Fatiada com Batata Frita','Entradas',4,22.00);
/*!40000 ALTER TABLE `pratos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-10-14  2:10:27
