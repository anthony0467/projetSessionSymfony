-- --------------------------------------------------------
-- Hôte:                         127.0.0.1
-- Version du serveur:           5.7.33 - MySQL Community Server (GPL)
-- SE du serveur:                Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Listage de la structure de la base pour sessions
CREATE DATABASE IF NOT EXISTS `sessions` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `sessions`;

-- Listage de la structure de la table sessions. categorie
CREATE TABLE IF NOT EXISTS `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_categorie` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.categorie : ~0 rows (environ)
/*!40000 ALTER TABLE `categorie` DISABLE KEYS */;
INSERT INTO `categorie` (`id`, `nom_categorie`) VALUES
	(2, 'Bureautique'),
	(3, 'Marketing'),
	(4, 'Art et créativité'),
	(8, 'Informatique');
/*!40000 ALTER TABLE `categorie` ENABLE KEYS */;

-- Listage de la structure de la table sessions. doctrine_migration_versions
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Listage des données de la table sessions.doctrine_migration_versions : ~2 rows (environ)
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20230411100005', '2023-04-14 07:52:17', 1169),
	('DoctrineMigrations\\Version20230414075040', '2023-04-14 07:57:19', 122);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;

-- Listage de la structure de la table sessions. formateur
CREATE TABLE IF NOT EXISTS `formateur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_formateur` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom_formateur` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_formateur` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.formateur : ~0 rows (environ)
/*!40000 ALTER TABLE `formateur` DISABLE KEYS */;
INSERT INTO `formateur` (`id`, `nom_formateur`, `prenom_formateur`, `email_formateur`) VALUES
	(1, 'Monsieur', 'Formateur', 'formateur@former.fr'),
	(3, 'Bourdon', 'Didier', 'dider@bourdon.fr');
/*!40000 ALTER TABLE `formateur` ENABLE KEYS */;

-- Listage de la structure de la table sessions. formation
CREATE TABLE IF NOT EXISTS `formation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_formation` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.formation : ~0 rows (environ)
/*!40000 ALTER TABLE `formation` DISABLE KEYS */;
INSERT INTO `formation` (`id`, `nom_formation`) VALUES
	(1, 'Développeur web'),
	(2, 'Designer web'),
	(3, 'Commerce'),
	(4, 'Secrétariat'),
	(5, 'Art plastique');
/*!40000 ALTER TABLE `formation` ENABLE KEYS */;

-- Listage de la structure de la table sessions. messenger_messages
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `available_at` datetime NOT NULL,
  `delivered_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.messenger_messages : ~0 rows (environ)
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;

-- Listage de la structure de la table sessions. module
CREATE TABLE IF NOT EXISTS `module` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categorie_id` int(11) NOT NULL,
  `nom_module` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_C242628BCF5E72D` (`categorie_id`),
  CONSTRAINT `FK_C242628BCF5E72D` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.module : ~0 rows (environ)
/*!40000 ALTER TABLE `module` DISABLE KEYS */;
INSERT INTO `module` (`id`, `categorie_id`, `nom_module`) VALUES
	(3, 2, 'PowerPoint'),
	(4, 3, 'Technique de vente'),
	(5, 4, 'Peinture'),
	(6, 8, 'HTML'),
	(7, 8, 'PHP');
/*!40000 ALTER TABLE `module` ENABLE KEYS */;

-- Listage de la structure de la table sessions. programme
CREATE TABLE IF NOT EXISTS `programme` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` int(11) NOT NULL,
  `module_id` int(11) NOT NULL,
  `nb_jour_module` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_3DDCB9FF613FECDF` (`session_id`),
  KEY `IDX_3DDCB9FFAFC2B591` (`module_id`),
  CONSTRAINT `FK_3DDCB9FF613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`),
  CONSTRAINT `FK_3DDCB9FFAFC2B591` FOREIGN KEY (`module_id`) REFERENCES `module` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.programme : ~0 rows (environ)
/*!40000 ALTER TABLE `programme` DISABLE KEYS */;
INSERT INTO `programme` (`id`, `session_id`, `module_id`, `nb_jour_module`) VALUES
	(2, 1, 7, 6),
	(8, 1, 6, 4),
	(13, 1, 3, 4),
	(16, 4, 3, 2);
/*!40000 ALTER TABLE `programme` ENABLE KEYS */;

-- Listage de la structure de la table sessions. session
CREATE TABLE IF NOT EXISTS `session` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formation_id` int(11) NOT NULL,
  `formateur_id` int(11) DEFAULT NULL,
  `nom_session` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_fin` datetime NOT NULL,
  `date_debut` datetime NOT NULL,
  `nb_place` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D044D5D45200282E` (`formation_id`),
  KEY `IDX_D044D5D4155D8F51` (`formateur_id`),
  CONSTRAINT `FK_D044D5D4155D8F51` FOREIGN KEY (`formateur_id`) REFERENCES `formateur` (`id`),
  CONSTRAINT `FK_D044D5D45200282E` FOREIGN KEY (`formation_id`) REFERENCES `formation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.session : ~0 rows (environ)
/*!40000 ALTER TABLE `session` DISABLE KEYS */;
INSERT INTO `session` (`id`, `formation_id`, `formateur_id`, `nom_session`, `date_fin`, `date_debut`, `nb_place`) VALUES
	(1, 1, 3, 'Developpeur web', '2023-10-13 14:31:16', '2023-02-06 14:31:16', 5),
	(2, 3, 1, 'Marketing', '2024-04-12 14:32:27', '2023-12-12 14:32:39', 5),
	(3, 2, 3, 'Designer Web', '2022-04-12 00:00:00', '2021-04-12 00:00:00', 5),
	(4, 4, 1, 'Assistant(e) Secrétariat', '2023-12-21 16:10:52', '2023-04-02 16:11:08', 4),
	(5, 1, 3, 'Developpeur web', '2023-01-12 16:37:52', '2022-04-12 16:38:00', 6),
	(6, 3, 3, 'assistant commecial', '2023-11-11 00:00:00', '2023-03-18 00:00:00', 10),
	(7, 2, 3, 'Designer web', '2024-02-06 00:00:00', '2023-06-18 00:00:00', 5),
	(9, 5, 1, 'Art plastique', '2021-02-02 00:00:00', '2020-05-12 00:00:00', 3);
/*!40000 ALTER TABLE `session` ENABLE KEYS */;

-- Listage de la structure de la table sessions. stagiaire
CREATE TABLE IF NOT EXISTS `stagiaire` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom_stagiaire` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `prenom_stagiaire` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_stagiaire` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_naissance` datetime DEFAULT NULL,
  `telephone` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `adresse` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ville` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.stagiaire : ~0 rows (environ)
/*!40000 ALTER TABLE `stagiaire` DISABLE KEYS */;
INSERT INTO `stagiaire` (`id`, `nom_stagiaire`, `prenom_stagiaire`, `email_stagiaire`, `date_naissance`, `telephone`, `adresse`, `ville`) VALUES
	(1, 'Spiteri', 'Anthony', 'antho@antho.fr', '1989-04-24 17:20:49', '0600660606', '37a avenue de stras', 'Strasbourg'),
	(6, 'Dupond', 'Jean', 'jean@dupond.fr', '2002-01-20 00:00:00', '0606600606', 'rue de l\'orange', 'brumath'),
	(9, 'test', 'test', 'test@test.fr', '2001-01-12 00:00:00', '060606006', 'rue', 'Brumath'),
	(10, 'test', 'Teste', 'toto@t.fr', '2000-02-12 00:00:00', '06606060', 'sff', 'Brumath'),
	(11, 'fef', 'Anthefefeony', 'dq@gmail.com', '2005-12-24 00:00:00', '0621127258', '04100', 'Manosque'),
	(12, 'tes', 'qqce', 'ant100m@gmail.com', '2000-05-12 00:00:00', '0621127258', '04100', 'Manosque'),
	(13, 'toto', 'titi', 'titi@toto.fr', '2012-12-12 00:00:00', '0606060606', 'rue de la rue', 'Strasbourg'),
	(14, 'Campan', 'Bernard', 'cd@cd.fr', '1968-05-18 00:00:00', '0606060606', 'rue de la paix', 'paris'),
	(16, 'etst', 'test', 'tes@test', '0110-12-31 00:00:00', '0000000000', '00', '00'),
	(17, 'Noninscrit', 'PasdeSession', 'p@fr.fr', '2020-12-12 00:00:00', '060660606', 'terrg', 'strasbourg');
/*!40000 ALTER TABLE `stagiaire` ENABLE KEYS */;

-- Listage de la structure de la table sessions. stagiaire_session
CREATE TABLE IF NOT EXISTS `stagiaire_session` (
  `stagiaire_id` int(11) NOT NULL,
  `session_id` int(11) NOT NULL,
  PRIMARY KEY (`stagiaire_id`,`session_id`),
  KEY `IDX_D32D02D4BBA93DD6` (`stagiaire_id`),
  KEY `IDX_D32D02D4613FECDF` (`session_id`),
  CONSTRAINT `FK_D32D02D4613FECDF` FOREIGN KEY (`session_id`) REFERENCES `session` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_D32D02D4BBA93DD6` FOREIGN KEY (`stagiaire_id`) REFERENCES `stagiaire` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.stagiaire_session : ~0 rows (environ)
/*!40000 ALTER TABLE `stagiaire_session` DISABLE KEYS */;
INSERT INTO `stagiaire_session` (`stagiaire_id`, `session_id`) VALUES
	(1, 1),
	(6, 2),
	(6, 4),
	(10, 4),
	(11, 1),
	(12, 1),
	(13, 1),
	(13, 2),
	(13, 4),
	(14, 6),
	(16, 1),
	(16, 4);
/*!40000 ALTER TABLE `stagiaire_session` ENABLE KEYS */;

-- Listage de la structure de la table sessions. user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `identifiant` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Listage des données de la table sessions.user : ~0 rows (environ)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `identifiant`) VALUES
	(2, 'antho04100m@gmail.com', '[]', '$2y$13$mZVsUR4o/HdSWFvFAQoCLeKyzBtCOhwcPTdtgmtBetfkZsJXxPYTm', 1, 'Anthony'),
	(3, 'admin@test.fr', '["ROLE_ADMIN"]', '$2y$13$tQ68Nw2lXeqDMBL/RMBYDe2i1hvDGyRYCp543R4saHT0p6/CAJkoG', 1, 'admin');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
