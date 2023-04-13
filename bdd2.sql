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

-- Listage des données de la table sessions.categorie : ~4 rows (environ)
INSERT INTO `categorie` (`id`, `nom_categorie`) VALUES
	(2, 'Bureautique'),
	(3, 'Marketing'),
	(4, 'Art et créativité'),
	(8, 'Informatique');

-- Listage des données de la table sessions.doctrine_migration_versions : ~0 rows (environ)
INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
	('DoctrineMigrations\\Version20230411100005', '2023-04-11 10:00:42', 363);

-- Listage des données de la table sessions.formateur : ~2 rows (environ)
INSERT INTO `formateur` (`id`, `nom_formateur`, `prenom_formateur`, `email_formateur`) VALUES
	(1, 'Monsieur', 'Formateur', 'formateur@former.fr'),
	(3, 'Bourdon', 'Didier', 'dider@bourdon.fr');

-- Listage des données de la table sessions.formation : ~4 rows (environ)
INSERT INTO `formation` (`id`, `nom_formation`) VALUES
	(1, 'Développeur web'),
	(2, 'Designer web'),
	(3, 'Commerce'),
	(4, 'Secrétariat');

-- Listage des données de la table sessions.messenger_messages : ~0 rows (environ)

-- Listage des données de la table sessions.module : ~5 rows (environ)
INSERT INTO `module` (`id`, `categorie_id`, `nom_module`) VALUES
	(3, 2, 'PowerPoint'),
	(4, 3, 'Technique de vente'),
	(5, 4, 'Peinture'),
	(6, 8, 'HTML'),
	(7, 8, 'PHP');

-- Listage des données de la table sessions.programme : ~5 rows (environ)
INSERT INTO `programme` (`id`, `session_id`, `module_id`, `nb_jour_module`) VALUES
	(2, 1, 7, 6),
	(3, 2, 4, 3),
	(4, 6, 4, 2),
	(5, 4, 3, 2);

-- Listage des données de la table sessions.session : ~7 rows (environ)
INSERT INTO `session` (`id`, `formation_id`, `formateur_id`, `nom_session`, `date_fin`, `date_debut`, `nb_place`) VALUES
	(1, 1, 3, 'Developpeur web', '2023-10-13 14:31:16', '2023-02-06 14:31:16', 5),
	(2, 3, 1, 'Marketing', '2024-04-12 14:32:27', '2023-12-12 14:32:39', 5),
	(3, 2, 3, 'Designer Web', '2022-04-12 14:45:02', '2021-04-12 14:45:08', 3),
	(4, 4, 1, 'Assistant(e) Secrétariat', '2023-12-21 16:10:52', '2023-04-02 16:11:08', 4),
	(5, 1, 3, 'Developpeur web', '2023-01-12 16:37:52', '2022-04-12 16:38:00', 6),
	(6, 3, 3, 'assistant commecial', '2023-11-11 00:00:00', '2023-03-18 00:00:00', 10),
	(7, 2, 3, 'Designer web', '2024-02-06 00:00:00', '2023-06-18 00:00:00', 5);

-- Listage des données de la table sessions.stagiaire : ~9 rows (environ)
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

-- Listage des données de la table sessions.stagiaire_session : ~7 rows (environ)
INSERT INTO `stagiaire_session` (`stagiaire_id`, `session_id`) VALUES
	(1, 1),
	(6, 2),
	(11, 1),
	(12, 1),
	(13, 1),
	(13, 2),
	(14, 6),
	(16, 1);

-- Listage des données de la table sessions.user : ~2 rows (environ)
INSERT INTO `user` (`id`, `email`, `roles`, `password`, `is_verified`, `identifiant`) VALUES
	(2, 'antho04100m@gmail.com', '[]', '$2y$13$mZVsUR4o/HdSWFvFAQoCLeKyzBtCOhwcPTdtgmtBetfkZsJXxPYTm', 1, 'Anthony'),
	(3, 'admin@test.fr', '["ROLE_ADMIN"]', '$2y$13$tQ68Nw2lXeqDMBL/RMBYDe2i1hvDGyRYCp543R4saHT0p6/CAJkoG', 1, 'admin');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
