-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           8.0.30 - MySQL Community Server - GPL
-- SE du serveur:                Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour sessions
CREATE DATABASE IF NOT EXISTS `sessions` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sessions`;

-- Listage de la structure de table sessions. categorie
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.categorie : ~4 rows (environ)
INSERT INTO `categorie` (`id`, `nom_categorie`) VALUES
	(2, 'Bureautique'),
	(3, 'Marketing'),
	(8, 'Informatique'),
	(12, 'Art et créativité');

-- Listage de la structure de table sessions. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.doctrine_migration_versions : ~2 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20230411100005', '2023-04-14 07:52:17', 1169),
	('DoctrineMigrations\\Version20230414075040', '2023-04-14 07:57:19', 122);

-- Listage de la structure de table sessions. formateur
CREATE TABLE IF NOT EXISTS `formateur` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_formateur` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `prenom_formateur` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email_formateur` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.formateur : ~6 rows (environ)
INSERT INTO `formateur` (`id`, `nom_formateur`, `prenom_formateur`, `email_formateur`) VALUES
	(1, 'Laux', 'Paul', 'formateur@former.fr'),
	(3, 'Bourdon', 'Didier', 'dider@bourdon.fr'),
	(4, 'Auclair', 'Damiane', 'DamianeAuclair@rhyta.com'),
	(5, 'Pariseau', 'Huon', 'HuonPariseau@dayrep.com'),
	(6, 'Dupond', 'Bernard', 'bd@dp.fr'),
	(14, 'test', 'tes', 't@t.fr');

-- Listage de la structure de table sessions. formation
CREATE TABLE IF NOT EXISTS `formation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_formation` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.formation : ~5 rows (environ)
INSERT INTO `formation` (`id`, `nom_formation`) VALUES
	(1, 'Développeur web'),
	(2, 'Designer web'),
	(3, 'Commerce'),
	(5, 'Art plastique'),
	(8, 'teste');

-- Listage de la structure de table sessions. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `headers` longtext CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `queue_name` varchar(190) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.messenger_messages : ~0 rows (environ)

-- Listage de la structure de table sessions. module
CREATE TABLE IF NOT EXISTS `module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categorie_id` int NOT NULL,
  `nom_module` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C242628BCF5E72D` (`categorie_id`),
  CONSTRAINT `FK_C242628BCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.module : ~6 rows (environ)
INSERT INTO `module` (`id`, `categorie_id`, `nom_module`) VALUES
	(3, 2, 'PowerPoint'),
	(4, 3, 'Technique de vente'),
	(6, 8, 'HTML'),
	(7, 8, 'PHP'),
	(8, 2, 'Excel'),
	(11, 12, 'Peinture');

-- Listage de la structure de table sessions. programme
CREATE TABLE IF NOT EXISTS `programme` (
  `id` int NOT NULL AUTO_INCREMENT,
  `session_id` int NOT NULL,
  `module_id` int NOT NULL,
  `nb_jour_module` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3DDCB9FF613FECDF` (`session_id`),
  KEY `IDX_3DDCB9FFAFC2B591` (`module_id`),
  CONSTRAINT `FK_3DDCB9FF613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`),
  CONSTRAINT `FK_3DDCB9FFAFC2B591` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.programme : ~11 rows (environ)
INSERT INTO `programme` (`id`, `session_id`, `module_id`, `nb_jour_module`) VALUES
	(2, 1, 7, 6),
	(8, 1, 6, 4),
	(22, 6, 8, 2),
	(24, 6, 4, 6),
	(27, 6, 3, 4),
	(29, 1, 3, 4),
	(30, 2, 4, 3),
	(31, 2, 8, 2),
	(32, 3, 6, 3),
	(36, 9, 11, 3),
	(38, 1, 4, 2);

-- Listage de la structure de table sessions. session
CREATE TABLE IF NOT EXISTS `session` (
  `id` int NOT NULL AUTO_INCREMENT,
  `formation_id` int NOT NULL,
  `nom_session` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `date_fin` datetime NOT NULL,
  `date_debut` datetime NOT NULL,
  `nb_place` int NOT NULL,
  `formateur_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D044D5D45200282E` (`formation_id`),
  KEY `IDX_D044D5D4155D8F51` (`formateur_id`),
  CONSTRAINT `FK_D044D5D4155D8F51` FOREIGN KEY (`formateur_id`) REFERENCES `formateur` (`id`),
  CONSTRAINT `FK_D044D5D45200282E` FOREIGN KEY (`formation_id`) REFERENCES `formation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.session : ~9 rows (environ)
INSERT INTO `session` (`id`, `formation_id`, `nom_session`, `date_fin`, `date_debut`, `nb_place`, `formateur_id`) VALUES
	(1, 1, 'Developpeur web', '2023-10-13 14:31:16', '2023-02-06 14:31:16', 5, NULL),
	(2, 3, 'Marketing', '2024-04-12 14:32:27', '2023-12-12 14:32:39', 5, NULL),
	(3, 2, 'Designer Web', '2022-04-12 00:00:00', '2021-04-12 00:00:00', 5, NULL),
	(5, 1, 'Developpeur web', '2023-01-12 16:37:52', '2022-04-12 16:38:00', 6, NULL),
	(6, 3, 'assistant commercial', '2023-11-11 00:00:00', '2023-03-18 00:00:00', 10, NULL),
	(7, 2, 'Designer web', '2024-02-06 00:00:00', '2023-06-18 00:00:00', 5, NULL),
	(9, 5, 'Art plastique', '2021-02-02 00:00:00', '2020-05-12 00:00:00', 3, NULL),
	(20, 8, 'teste', '2023-11-11 00:00:00', '2023-04-17 00:00:00', 5, 14),
	(21, 8, 'teste 2', '2024-11-11 00:00:00', '2023-10-01 00:00:00', 3, 1);

-- Listage de la structure de table sessions. stagiaire
CREATE TABLE IF NOT EXISTS `stagiaire` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom_stagiaire` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `prenom_stagiaire` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `email_stagiaire` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `date_naissance` datetime DEFAULT NULL,
  `telephone` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `adresse` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT NULL,
  `ville` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.stagiaire : ~10 rows (environ)
INSERT INTO `stagiaire` (`id`, `nom_stagiaire`, `prenom_stagiaire`, `email_stagiaire`, `date_naissance`, `telephone`, `adresse`, `ville`) VALUES
	(1, 'Spiteri', 'Anthony', 'antho@antho.fr', '1989-04-24 17:20:49', '0600660606', '37a avenue de stras', 'Strasbourg'),
	(6, 'Dupond', 'Jean', 'jean@dupond.fr', '2002-01-20 00:00:00', '0606600606', 'rue de l\'orange', 'brumath'),
	(9, 'Bellemare', 'Pierrette', 'test@test.fr', '2001-01-12 00:00:00', '0606060065', '40 avenue de la provence', 'VALLAURIS'),
	(10, 'Parizeau', 'Faye', 'toto@t.fr', '2000-02-12 00:00:00', '0660606012', '91, rue de Lille', 'Brumath'),
	(11, 'Hervieux', 'Florismart', 'dq@gmail.com', '2005-12-24 00:00:00', '0621127258', '78 Boulevard de Normandie', 'FONTENAY-SOUS-BOIS'),
	(12, 'Saindon', 'Colette', 'ant100m@gmail.com', '2000-05-12 00:00:00', '0621127258', '9, Place de la Madeleine', 'Paris'),
	(13, 'Durepos', 'Mathilde', 'titi@toto.fr', '2012-12-12 00:00:00', '0606060606', '24, Rue Bonnet', 'Wattrelos'),
	(14, 'Campan', 'Bernard', 'cd@cd.fr', '1968-05-18 00:00:00', '0606060606', 'rue de la paix', 'paris'),
	(16, 'Chateaub', 'Fabrice', 'tes@test', '0110-12-31 00:00:00', '0606020003', '30 rue Gustave Eiffel', 'RIS-ORANGIS'),
	(17, 'Noninscrit', 'PasdeSession', 'p@fr.fr', '2020-12-12 00:00:00', '0606606061', 'terrg', 'strasbourg');

-- Listage de la structure de table sessions. stagiaire_session
CREATE TABLE IF NOT EXISTS `stagiaire_session` (
  `stagiaire_id` int NOT NULL,
  `session_id` int NOT NULL,
  PRIMARY KEY (`stagiaire_id`,`session_id`),
  KEY `IDX_D32D02D4BBA93DD6` (`stagiaire_id`),
  KEY `IDX_D32D02D4613FECDF` (`session_id`),
  CONSTRAINT `FK_D32D02D4613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D32D02D4BBA93DD6` FOREIGN KEY (`stagiaire_id`) REFERENCES `stagiaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.stagiaire_session : ~16 rows (environ)
INSERT INTO `stagiaire_session` (`stagiaire_id`, `session_id`) VALUES
	(1, 1),
	(1, 6),
	(6, 2),
	(9, 1),
	(9, 9),
	(10, 2),
	(11, 2),
	(12, 2),
	(12, 9),
	(13, 1),
	(13, 2),
	(13, 9),
	(14, 1),
	(14, 6),
	(16, 1),
	(16, 6);

-- Listage de la structure de table sessions. user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `identifiant` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Listage des données de la table sessions.user : ~2 rows (environ)
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `identifiant`) VALUES
	(2, 'antho04100m@gmail.com', '[]', '$2y$13$mZVsUR4o/HdSWFvFAQoCLeKyzBtCOhwcPTdtgmtBetfkZsJXxPYTm', 1, 'Anthony'),
	(3, 'admin@test.fr', '["ROLE_ADMIN"]', '$2y$13$tQ68Nw2lXeqDMBL/RMBYDe2i1hvDGyRYCp543R4saHT0p6/CAJkoG', 1, 'admin');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
