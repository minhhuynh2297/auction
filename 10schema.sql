CREATE TABLE `Athletic` (
  `item_number` int(11) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  `size` varchar(6) DEFAULT NULL,
  `final_price` double NOT NULL DEFAULT '0',
  KEY `item_number` (`item_number`),
  CONSTRAINT `Athletic_ibfk_2` FOREIGN KEY (`item_number`) REFERENCES `item` (`item_number`) ON DELETE CASCADE
)

CREATE TABLE `Auction` (
  `hidden_minimum` double DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `title` varchar(50) DEFAULT NULL,
  `auction_number` int(11) NOT NULL AUTO_INCREMENT,
  `end_date` datetime NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `item_number` int(11) DEFAULT NULL,
  `increment` double NOT NULL DEFAULT '0',
  `closed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`auction_number`,`end_date`),
  KEY `email` (`email`),
  KEY `item_number` (`item_number`),
  CONSTRAINT `Auction_ibfk_2` FOREIGN KEY (`item_number`) REFERENCES `item` (`item_number`) ON DELETE CASCADE
)

CREATE TABLE `Bids` (
  `amount` double DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `date_posted` datetime DEFAULT CURRENT_TIMESTAMP,
  `auction_number` int(11) DEFAULT NULL,
  `isAuto` tinyint(1) DEFAULT '0',
  `upper_limit` double DEFAULT '0',
  KEY `email` (`email`),
  KEY `auction_number` (`auction_number`),
  CONSTRAINT `Bids_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `Bids_ibfk_2` FOREIGN KEY (`auction_number`) REFERENCES `Auction` (`auction_number`) ON DELETE CASCADE
)

CREATE TABLE `Business` (
  `item_number` int(11) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  `size` varchar(6) DEFAULT NULL,
  `final_price` double NOT NULL DEFAULT '0',
  KEY `item_number` (`item_number`),
  CONSTRAINT `Business_ibfk_2` FOREIGN KEY (`item_number`) REFERENCES `item` (`item_number`) ON DELETE CASCADE
)

CREATE TABLE `Buyer` (
  `creditCardNumber` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `Address` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `num_purchases` int(11) DEFAULT '0',
  PRIMARY KEY (`email`),
  CONSTRAINT `Buyer_ibfk_2` FOREIGN KEY (`email`) REFERENCES `Customer` (`email`) ON DELETE CASCADE
)

CREATE TABLE `Customer` (
  `creditCardNumber` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `Address` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `name` char(50) DEFAULT NULL,
  PRIMARY KEY (`email`)
)

CREATE TABLE `Employee` (
  `password` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `isAdmin` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`email`)
)

CREATE TABLE `Interest` (
  `email` varchar(50) NOT NULL DEFAULT '',
  `tag` varchar(20) DEFAULT NULL,
  `size` varchar(6) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `Interest_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Customer` (`email`)
)

CREATE TABLE `item` (
  `item_number` int(11) NOT NULL AUTO_INCREMENT,
  `seller_email` varchar(50) DEFAULT NULL,
  `category_number` int(11) DEFAULT NULL,
  `item_name` varchar(50) DEFAULT NULL,
  `brand` varchar(50) DEFAULT NULL,
  `model` varchar(50) DEFAULT NULL,
  `final_price` double NOT NULL DEFAULT '0',
  `description` text,
  `tag1` varchar(20) DEFAULT NULL,
  `tag2` varchar(20) DEFAULT NULL,
  `tag3` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`item_number`),
  KEY `seller_email` (`seller_email`),
  CONSTRAINT `item_ibfk_2` FOREIGN KEY (`seller_email`) REFERENCES `Seller` (`email`) ON DELETE CASCADE
)

CREATE TABLE `Messages` (
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `content` text,
  `email_subject` varchar(200) DEFAULT NULL,
  `received_from` varchar(50) NOT NULL DEFAULT '',
  `sent_to` varchar(50) DEFAULT NULL,
  `email_number` int(11) NOT NULL AUTO_INCREMENT,
  `isRead` tinyint(1) DEFAULT '0',
  `reply_to` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`email_number`),
  KEY `reply_to` (`reply_to`),
  KEY `sent_to` (`sent_to`),
  CONSTRAINT `Messages_ibfk_3` FOREIGN KEY (`reply_to`) REFERENCES `Employee` (`email`),
  CONSTRAINT `Messages_ibfk_4` FOREIGN KEY (`sent_to`) REFERENCES `Customer` (`email`) ON DELETE CASCADE,
  CONSTRAINT `Messages_ibfk_5` FOREIGN KEY (`sent_to`) REFERENCES `Customer` (`email`) ON DELETE CASCADE
)

CREATE TABLE `Question` (
  `email` varchar(50) DEFAULT NULL,
  `question_id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(255) DEFAULT NULL,
  `answer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `email` (`email`),
  CONSTRAINT `Question_ibfk_1` FOREIGN KEY (`email`) REFERENCES `Customer` (`email`)
)

CREATE TABLE `Sandal` (
  `item_number` int(11) DEFAULT NULL,
  `color` varchar(15) DEFAULT NULL,
  `size` varchar(6) DEFAULT NULL,
  `final_price` double NOT NULL DEFAULT '0',
  KEY `item_number` (`item_number`),
  CONSTRAINT `Sandal_ibfk_2` FOREIGN KEY (`item_number`) REFERENCES `item` (`item_number`) ON DELETE CASCADE
)

CREATE TABLE `Seller` (
  `creditCardNumber` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `Address` varchar(50) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL,
  `num_sold` int(11) DEFAULT NULL,
  `earnings` double DEFAULT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `Seller_ibfk_2` FOREIGN KEY (`email`) REFERENCES `Customer` (`email`) ON DELETE CASCADE
)

CREATE TABLE `User` (
  `name` char(30) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(20) DEFAULT NULL
) 

