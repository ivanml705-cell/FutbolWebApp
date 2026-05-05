USE `futbol`;

CREATE TABLE IF NOT EXISTS `webappuser` (
  `LoginName` varchar(20) NOT NULL DEFAULT '',
  `Password` varchar(20) NOT NULL DEFAULT '',
  `Rights` int NOT NULL DEFAULT '0',
  `FullName` varchar(30) NOT NULL DEFAULT '',
  `LastLogin` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`LoginName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE IF NOT EXISTS `webappserverprops` (
  `Key` varchar(64) NOT NULL DEFAULT '',
  `CreateDate` varchar(10) NOT NULL DEFAULT '',
  `CreateTime` varchar(12) NOT NULL DEFAULT '',
  `ExpiresDate` varchar(10) NOT NULL DEFAULT '',
  `ExpiresTime` varchar(12) NOT NULL DEFAULT '',
  `Locked` int NOT NULL DEFAULT '0',
  `LockedDate` varchar(10) NOT NULL DEFAULT '',
  `LockedTime` varchar(12) NOT NULL DEFAULT '',
  `Page` int NOT NULL DEFAULT '0',
  `Pages` int NOT NULL DEFAULT '0',
  `Data` varchar(8000) NOT NULL DEFAULT '',
  PRIMARY KEY (`Key`, `Page`),
  KEY `WebAppServerProps002` (`ExpiresDate`, `ExpiresTime`, `Key`, `Page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE `webappsession`
  MODIFY `CreateDate` varchar(10) NOT NULL DEFAULT '',
  MODIFY `LastAccessDate` varchar(10) NOT NULL DEFAULT '';
