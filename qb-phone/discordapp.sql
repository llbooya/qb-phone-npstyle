DROP TABLE IF EXISTS `phone_chatrooms`;
CREATE TABLE `phone_chatrooms` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT,
    `room_code` VARCHAR(10) NOT NULL UNIQUE,
    `room_name` VARCHAR(15) NOT NULL,
    `room_owner_id` VARCHAR(20),
    `room_owner_name` VARCHAR(60),
    `room_members` TEXT DEFAULT '{}', 
    `room_pin` VARCHAR(50),
    `unpaid_balance` DECIMAL(10,2) DEFAULT 0,
    `is_masked` BOOLEAN DEFAULT 0,
    `is_pinned` BOOLEAN DEFAULT 0,
    `created` DATETIME DEFAULT NOW(),
    PRIMARY KEY (`id`)
);

INSERT INTO `phone_chatrooms` (`room_code`, `room_name`, `room_owner_id`, `room_owner_name`, `is_pinned`) VALUES
	('411', '411', 'official', 'Government', 1),
	('lounge', 'The Lounge', 'official', 'Government', 1),
	('events', 'Events', 'official', 'Government', 1);

DROP TABLE IF EXISTS `phone_chatroom_messages`;
CREATE TABLE `phone_chatroom_messages` (
    `id` INT unsigned NOT NULL AUTO_INCREMENT,
    `room_id` INT unsigned,
    `member_id` VARCHAR(20),
    `member_name` VARCHAR(50),
    `message` TEXT NOT NULL,
     `is_pinned` BOOLEAN DEFAULT FALSE,
     `created` DATETIME DEFAULT NOW(),
    PRIMARY KEY (`id`)
);