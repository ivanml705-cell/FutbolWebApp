USE `futbol`;

ALTER TABLE `entrenador`
  MODIFY `EquipoID` int NULL;

UPDATE `entrenador` e
LEFT JOIN `equipo` eq ON eq.`ID` = e.`EquipoID`
SET e.`EquipoID` = NULL
WHERE e.`EquipoID` IS NOT NULL
  AND eq.`ID` IS NULL;

SET @fk_exists := (
  SELECT COUNT(*)
  FROM information_schema.REFERENTIAL_CONSTRAINTS
  WHERE CONSTRAINT_SCHEMA = DATABASE()
    AND CONSTRAINT_NAME = 'fk_entrenador_equipo'
    AND TABLE_NAME = 'entrenador'
);

SET @sql := IF(
  @fk_exists = 0,
  'ALTER TABLE `entrenador` ADD CONSTRAINT `fk_entrenador_equipo` FOREIGN KEY (`EquipoID`) REFERENCES `equipo` (`ID`)',
  'SELECT ''fk_entrenador_equipo already exists'' AS info'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
