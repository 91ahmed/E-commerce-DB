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
	`GenderID` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`GenderName` VARCHAR(7) NOT NULL UNIQUE,
	
	PRIMARY KEY (`GenderID`)
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
	`RoleID` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`RoleName` VARCHAR(150) NOT NULL UNIQUE,
	
	PRIMARY KEY (`RoleID`)
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
	`UserID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`UserFirstName` VARCHAR(20) NOT NULL,
	`UserLastName` VARCHAR(20) NOT NULL,
	`UserEmail` VARCHAR(80) NOT NULL UNIQUE,
	`UserPassword` CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	`UserBirthDate` DATE NOT NULL, -- format (yyyy-mm-dd)
	`UserGender` TINYINT UNSIGNED NOT NULL,
	`UserStatus` BOOLEAN NOT NULL DEFAULT 0, -- 0 (not active) | 1 (active)
	`UserCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`UserGender`) REFERENCES `genders` (`GenderID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`UserID`)
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
	`UserRoleID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`UserID` INT UNSIGNED NOT NULL,
	`RoleID` TINYINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`RoleID`) REFERENCES `roles` (`RoleID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`UserRoleID`)
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
	`CustomerID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerFirstName` VARCHAR(20) NOT NULL,
	`CustomerLastName` VARCHAR(20) NOT NULL,
	`CustomerEmail` VARCHAR(80) NOT NULL UNIQUE,
	`CustomerPassword` CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	`CustomerBirthDate` DATE NOT NULL, -- format (yyyy-mm-dd)
	`CustomerGender` TINYINT UNSIGNED NOT NULL,
	`CustomerCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerGender`) REFERENCES `genders` (`GenderID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`CustomerID`)
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
	`ManufactureID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ManufactureName` VARCHAR(100) NOT NULL UNIQUE,
	
	PRIMARY KEY (`ManufactureID`)
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
	`CategoryKindID` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CategoryKindName` VARCHAR(30) NOT NULL UNIQUE,
	
	PRIMARY KEY (`CategoryKindID`)
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
	`CategoryID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CategoryName` VARCHAR(200) NOT NULL,
	`CategoryKind` TINYINT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`CategoryKind`) REFERENCES `categories_kinds` (`CategoryKindID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`CategoryID`)
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
	`SizeID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`SizeName` VARCHAR(50) NOT NULL UNIQUE,
	
	PRIMARY KEY (`SizeID`)
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
	`ColorID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ColorName` VARCHAR(50) NOT NULL UNIQUE,
	`ColorCode` CHAR(7) NOT NULL UNIQUE DEFAULT '#FFFFFF',
	
	PRIMARY KEY (`ColorID`)
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
	`ProductID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ProductSku` CHAR(12) NOT NULL UNIQUE,
	`ProductName` VARCHAR(200) NOT NULL,
	`ProductPrice` DECIMAL(9,2) NOT NULL DEFAULT 0,
	`ProductDiscount` TINYINT UNSIGNED NOT NULL DEFAULT 0,
	`ProductQuantity` INT UNSIGNED NOT NULL DEFAULT 1,
	`ProductManufacture` SMALLINT UNSIGNED NOT NULL,
	`ProductCategory` SMALLINT UNSIGNED NOT NULL,
	`ProductDescription` LONGTEXT NULL,
	`ProductView` INT UNSIGNED NOT NULL DEFAULT 0,
	`ProductUser` INT UNSIGNED NOT NULL,
	`ProductCreatedDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`ProductManufacture`) REFERENCES `manufactures` (`ManufactureID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductCategory`) REFERENCES `categories` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductUser`) REFERENCES `users` (`UserID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`ProductID`)
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
	`ProductImageID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ImageName` VARCHAR(200) NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`ProductImageID`)
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
	`ProductSizeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`SizeID` SMALLINT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`SizeID`) REFERENCES `sizes` (`SizeID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`ProductSizeID`)
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
	`ProductColorID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`ColorID` SMALLINT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	
	FOREIGN KEY (`ColorID`) REFERENCES `colors` (`ColorID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`ProductID`) REFERENCES `products` (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`ProductColorID`)
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
	`CartID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`CustomerID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	`CartDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
	
	PRIMARY KEY (`CartID`)
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
	`CountryID` SMALLINT UNSIGNED NOT NULL,
	`CountryCode` VARCHAR(20) NOT NULL,
	`CountryCodeAlpha2` CHAR(2) NOT NULL,
	`CountryCodeAlpha3` CHAR(3) NOT NULL,
	`CountryNameEn` VARCHAR(200) NOT NULL,
	`CountryNameAr` VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (`CountryID`)
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
	`OrderID` INT UNSIGNED NOT NULL,
	`CustomerID` INT UNSIGNED NOT NULL,
	`CustomerName` VARCHAR(100) NOT NULL,
	`CustomerCountry` SMALLINT UNSIGNED NOT NULL,
	`CustomerCity` VARCHAR(100) NOT NULL,
	`CustomerRegion` VARCHAR(100) NOT NULL,
	`CustomerZip` VARCHAR(10) NULL,
	`CustomerAddress` VARCHAR(200) NOT NULL,
	`CustomerPhone` VARCHAR(20) NULL,
	`OrderDate` DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`CustomerCountry`) REFERENCES `countries` (`CountryID`) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (`OrderID`)
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
	`OrderDetailID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`OrderID` INT UNSIGNED NOT NULL,
	`ProductID` INT UNSIGNED NOT NULL,
	`Quantity` INT UNSIGNED NOT NULL,
	`UnitPrice` DECIMAL(9,2) NOT NULL,
	`Discount` TINYINT UNSIGNED NOT NULL DEFAULT 0,
	
	FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
	FOREIGN KEY (`ProductID`) REFERENCES `products` (`ProductID`),
	
	PRIMARY KEY (`OrderDetailID`)
)
	ENGINE innoDB
	DEFAULT CHARACTER SET utf8mb4
	DEFAULT COLLATE utf8mb4_general_ci
	AUTO_INCREMENT 1
;