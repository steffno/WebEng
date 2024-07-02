-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Lug 02, 2022 alle 19:55
-- Versione del server: 10.4.24-MariaDB
-- Versione PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `collectorsite`
--
CREATE DATABASE IF NOT EXISTS `collectorsite` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `collectorsite`;

-- --------------------------------------------------------

--
-- Struttura della tabella `collezione`
--

DROP TABLE IF EXISTS `collezione`;
CREATE TABLE IF NOT EXISTS `collezione` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `id_utente` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome` (`nome`),
  KEY `id_utente_coll` (`id_utente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `contiene`
--

DROP TABLE IF EXISTS `contiene`;
CREATE TABLE IF NOT EXISTS `contiene` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_collezione` int(10) UNSIGNED NOT NULL,
  `id_disco` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_id_coll_disco` (`id_collezione`),
  KEY `fk_id_disco_coll` (`id_disco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `copertina`
--

DROP TABLE IF EXISTS `copertina`;
CREATE TABLE IF NOT EXISTS `copertina` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `path` varchar(256) NOT NULL,
  `testo` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`testo`)),
  `id_disco` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `path` (`path`),
  KEY `id_copertina_disco` (`id_disco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `disco`
--

DROP TABLE IF EXISTS `disco`;
CREATE TABLE IF NOT EXISTS `disco` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `autore` varchar(64) NOT NULL,
  `titolo` varchar(64) NOT NULL,
  `anno_uscita` date NOT NULL,
  `etichetta` varchar(64) NOT NULL,
  `genere` varchar(45) NOT NULL,
  `stato` varchar(32) NOT NULL,
  `formato` varchar(32) NOT NULL,
  `barcode` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `disco_collezione`
--

DROP TABLE IF EXISTS `disco_collezione`;
CREATE TABLE IF NOT EXISTS `disco_collezione` (
  `id` int(10) UNSIGNED NOT NULL,
  `autore` varchar(64) NOT NULL,
  `titolo` varchar(64) NOT NULL,
  `anno_uscita` date NOT NULL,
  `etichetta` varchar(64) NOT NULL,
  `genere` varchar(45) NOT NULL,
  `stato` varchar(32) NOT NULL,
  `formato` varchar(32) NOT NULL,
  `barcode` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `traccia`
--

DROP TABLE IF EXISTS `traccia`;
CREATE TABLE IF NOT EXISTS `traccia` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `titolo` varchar(64) NOT NULL,
  `durata` time NOT NULL,
  `autore` varchar(64) NOT NULL,
  `id_disco` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_traccia_disco` (`id_disco`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `utente`
--

DROP TABLE IF EXISTS `utente`;
CREATE TABLE IF NOT EXISTS `utente` (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nome` varchar(64) NOT NULL,
  `cognome` varchar(64) NOT NULL,
  `username` varchar(32) NOT NULL,
  `passwd` varchar(32) NOT NULL,
  `email` varchar(128) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `collezione`
--
ALTER TABLE `collezione`
  ADD CONSTRAINT `id_utente_coll` FOREIGN KEY (`id_utente`) REFERENCES `utente` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `contiene`
--
ALTER TABLE `contiene`
  ADD CONSTRAINT `fk_id_coll_disco` FOREIGN KEY (`id_collezione`) REFERENCES `collezione` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_id_disco_coll` FOREIGN KEY (`id_disco`) REFERENCES `disco` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Limiti per la tabella `copertina`
--
ALTER TABLE `copertina`
  ADD CONSTRAINT `id_copertina_disco` FOREIGN KEY (`id_disco`) REFERENCES `disco` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `traccia`
--
ALTER TABLE `traccia`
  ADD CONSTRAINT `id_traccia_disco` FOREIGN KEY (`id_disco`) REFERENCES `disco` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
