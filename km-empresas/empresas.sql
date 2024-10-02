CREATE TABLE IF NOT EXISTS `owned_properties` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `property_name` varchar(255) NOT NULL,
    `owner_cid` varchar(50) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `unique_property` (`property_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
