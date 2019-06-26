/*
 * author name    (ahmed hassan)
 * author email   (ahmedh12491@gmail.com)
 *
 * database       (mysql)
 * engine         (innoDB)
 */

-- Drop Existing Database
-- ----------------------
DROP DATABASE IF EXISTS `ecommerce`;

-- Create Database
-- ---------------
CREATE DATABASE IF NOT EXISTS `ecommerce`
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_general_ci;

-- Use Database
-- ------------
USE `ecommerce`;

-- Drop Existing Tables
-- --------------------
DROP TABLE IF EXISTS users_roles;
DROP TABLE IF EXISTS orders_details;
DROP TABLE IF EXISTS shopping_cart;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS products_colors;
DROP TABLE IF EXISTS products_sizes;
DROP TABLE IF EXISTS products_images;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS categories_kinds;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS manufactures;
DROP TABLE IF EXISTS sizes;
DROP TABLE IF EXISTS colors;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS countries;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS genders;

-- Create `genders` Table
-- ----------------------
CREATE TABLE IF NOT EXISTS `genders`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`GenderID` INT UNSIGNED NOT NULL UNIQUE,
	`GenderName` VARCHAR(20) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `roles` Table
-- --------------------
CREATE TABLE IF NOT EXISTS `roles`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`RoleID` INT UNSIGNED NOT NULL UNIQUE,
	`RoleName` VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `users` Table
-- --------------------
CREATE TABLE IF NOT EXISTS `users`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`UserID` INT UNSIGNED NOT NULL UNIQUE,
	`UserFirstName` VARCHAR(20) NOT NULL,
	`UserLastName` VARCHAR(20) NOT NULL,
	`UserEmail` VARCHAR(100) NOT NULL UNIQUE,
	`UserPassword` CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	`UserBirthDate` DATE NOT NULL, -- format (yyyy-mm-dd)
	`UserGender` INT UNSIGNED NOT NULL,
	`UserStatus` BOOLEAN NOT NULL DEFAULT 0, -- 0 (not active) | 1 (active)
	`UserCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`UserGender`) REFERENCES `genders` (`GenderID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `users_roles` Table
-- --------------------------
CREATE TABLE IF NOT EXISTS `users_roles`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`UserID` INT UNSIGNED NOT NULL,
	`RoleID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `customers` Table
-- ------------------------
CREATE TABLE IF NOT EXISTS `customers`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerID` INT UNSIGNED NOT NULL UNIQUE,
	`CustomerFirstName` VARCHAR(20) NOT NULL,
	`CustomerLastName` VARCHAR(20) NOT NULL,
	`CustomerEmail` VARCHAR(100) NOT NULL UNIQUE,
	`CustomerPassword` CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	`CustomerBirthDate` DATE NOT NULL, -- format (yyyy-mm-dd)
	`CustomerGender` INT UNSIGNED NOT NULL,
	`CustomerCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerGender`) REFERENCES `genders` (`GenderID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `manufactures` Table
-- ---------------------------
CREATE TABLE IF NOT EXISTS `manufactures`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ManufactureID` INT UNSIGNED NOT NULL UNIQUE,
	`ManufactureName` VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `categories_kinds` Table
-- -------------------------------
CREATE TABLE IF NOT EXISTS `categories_kinds`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CategoryKindID` INT UNSIGNED NOT NULL UNIQUE,
	`CategoryKindName` VARCHAR(50) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `categories` Table
-- -------------------------
CREATE TABLE IF NOT EXISTS `categories`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CategoryID` INT UNSIGNED NOT NULL UNIQUE,
	`CategoryName` VARCHAR(200) NOT NULL,
	`CategoryKind` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`CategoryKind`) REFERENCES `categories_kinds` (`CategoryKindID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `sizes` Table
-- --------------------
CREATE TABLE IF NOT EXISTS `sizes`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`SizeID` INT UNSIGNED NOT NULL UNIQUE,
	`SizeName` VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `colors` Table
-- ---------------------
CREATE TABLE IF NOT EXISTS `colors`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ColorID` INT UNSIGNED NOT NULL UNIQUE,
	`ColorName` VARCHAR(50) NOT NULL,
	`ColorCode` CHAR(7) NOT NULL DEFAULT '#FFFFFF',
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `products` Table
-- -----------------------
CREATE TABLE IF NOT EXISTS `products`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductID` INT UNSIGNED NOT NULL UNIQUE,
	`ProductSku` CHAR(12) NOT NULL UNIQUE,
	`ProductName` VARCHAR(200) NOT NULL,
	`ProductPrice` DECIMAL(9,2) NOT NULL DEFAULT 0,
	`ProductDiscount` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	`ProductQuantity` SMALLINT UNSIGNED NOT NULL DEFAULT 1,
	`ProductManufacture` INT UNSIGNED NOT NULL,
	`ProductCategory` INT UNSIGNED NOT NULL,
	`ProductDescription` LONGTEXT NULL,
	`ProductView` INT UNSIGNED NOT NULL DEFAULT 0,
	`ProductUser` INT UNSIGNED NOT NULL,
	`ProductCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`ProductManufacture`) REFERENCES `manufactures` (`ManufactureID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductCategory`) REFERENCES `categories` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductUser`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `products_images` Table
-- ------------------------------
CREATE TABLE IF NOT EXISTS `products_images`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ImageName` VARCHAR(200) NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;


-- Create `products_sizes` Table
-- -----------------------------
CREATE TABLE IF NOT EXISTS `products_sizes`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`SizeID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`SizeID`) REFERENCES `sizes` (`SizeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `products_colors` Table
-- ------------------------------
CREATE TABLE IF NOT EXISTS `products_colors`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ColorID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`ColorID`) REFERENCES `colors` (`ColorID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductID`) REFERENCES `products` (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `shopping_cart` Table
-- ----------------------------
CREATE TABLE IF NOT EXISTS `shopping_cart`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	`CartDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `countries` Table
-- ------------------------
CREATE TABLE IF NOT EXISTS `countries`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CountryID` INT UNSIGNED NOT NULL UNIQUE,
	`CountryCode` VARCHAR(20) NOT NULL,
	`CountryCodeAlpha2` CHAR(2) NOT NULL,
	`CountryCodeAlpha3` CHAR(3) NOT NULL,
	`CountryNameEn` VARCHAR(200) NOT NULL,
	`CountryNameAr` VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `orders` Table
-- ---------------------
CREATE TABLE IF NOT EXISTS `orders`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT UNSIGNED NOT NULL UNIQUE,
	`CustomerID` INT UNSIGNED NOT NULL,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CustomerCountry` INT UNSIGNED NOT NULL,
	`CustomerCity` VARCHAR(100) NOT NULL,
	`CustomerRegion` VARCHAR(100) NOT NULL,
	`CustomerZip` VARCHAR(10) NULL,
	`CustomerAddress` VARCHAR(200) NOT NULL,
	`CustomerPhone` VARCHAR(20) NULL,
	`OrderDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`CustomerCountry`) REFERENCES `countries` (`CountryID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;

-- Create `orders_details` Table
-- -----------------------------
CREATE TABLE IF NOT EXISTS `orders_details`
(
	`Serial` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	`Quantity` SMALLINT UNSIGNED NOT NULL,
	`UnitPrice` DECIMAL(9,2) NOT NULL,
	`Discount` SMALLINT UNSIGNED NOT NULL DEFAULT 0,
	
	FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
	
	PRIMARY KEY (`Serial`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;