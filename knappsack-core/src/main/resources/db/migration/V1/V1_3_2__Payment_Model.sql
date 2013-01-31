ALTER TABLE DOMAIN_CONFIGURATION ADD `DISABLE_LIMIT_VALIDATIONS` tinyint(1) NOT NULL DEFAULT '0';

ALTER TABLE STORAGE_CONFIGURATION ADD `REGISTRATION_DEFAULT` tinyint(1) NOT NULL DEFAULT '0';


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAYMENT_PLAN_RESTRICTION` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `APPLICATION_LIMIT` bigint(20) DEFAULT NULL,
  `APP_VERSION_LIMIT` bigint(20) DEFAULT NULL,
  `CHANGED_BY` varchar(255) DEFAULT NULL,
  `CREATE_DATE` date DEFAULT NULL,
  `GIGABYTE_INCREMENTAL_BANDWIDTH_COST` float DEFAULT NULL,
  `LAST_UPDATE` date DEFAULT NULL,
  `MEGABYTE_BANDWIDTH_LIMIT` bigint(20) DEFAULT NULL,
  `MEGABYTE_STORAGE_LIMIT` bigint(20) DEFAULT NULL,
  `USER_LIMIT` bigint(20) DEFAULT NULL,
  `UUID` varchar(255) NOT NULL,
  `VERSION` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PAYMENT_PLAN` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CHANGED_BY` varchar(255) DEFAULT NULL,
  `CREATE_DATE` date DEFAULT NULL,
  `EXTERNAL_PAYMENT_PLAN_ID` varchar(255) NOT NULL,
  `LAST_UPDATE` date DEFAULT NULL,
  `PUBLIC` tinyint(1) NOT NULL DEFAULT '0',
  `UUID` varchar(255) NOT NULL,
  `VERSION` int(11) DEFAULT NULL,
  `PAYMENT_PLAN_RESTRICTION_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`),
  KEY `FK_PAYMENT_PLAN_PAYMENT_PLAN_RESTRICTION_ID` (`PAYMENT_PLAN_RESTRICTION_ID`),
  CONSTRAINT `FK_PAYMENT_PLAN_PAYMENT_PLAN_RESTRICTION_ID` FOREIGN KEY (`PAYMENT_PLAN_RESTRICTION_ID`) REFERENCES `PAYMENT_PLAN_RESTRICTION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CUSTOMER` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `EXTERNAL_CUSTOMER_ID` varchar(255) NOT NULL,
  `CHANGED_BY` varchar(255) DEFAULT NULL,
  `CREATE_DATE` date DEFAULT NULL,
  `LAST_UPDATE` date DEFAULT NULL,
  `UUID` varchar(255) NOT NULL,
  `VERSION` int(11) DEFAULT NULL,
  `ORGANIZATION_ID` bigint(20) NOT NULL,
  `PAYMENT_PLAN_ID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UUID` (`UUID`),
  KEY `FK_CUSTOMER_ORGANIZATION_ID` (`ORGANIZATION_ID`),
  KEY `FK_CUSTOMER_PAYMENT_PLAN_ID` (`PAYMENT_PLAN_ID`),
  CONSTRAINT `FK_CUSTOMER_PAYMENT_PLAN_ID` FOREIGN KEY (`PAYMENT_PLAN_ID`) REFERENCES `PAYMENT_PLAN` (`ID`),
  CONSTRAINT `FK_CUSTOMER_ORGANIZATION_ID` FOREIGN KEY (`ORGANIZATION_ID`) REFERENCES `ORGANIZATION` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

