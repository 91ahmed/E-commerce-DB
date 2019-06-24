/*
 * author name    (ahmed hassan)
 * author email   (ahmedh12491@gmail.com)
 *
 * database       (postgresql)
 */
 
-- Drop Existing Database
-- ----------------------
DROP DATABASE IF EXISTS ecommerce;
 
-- Create Database
-- ---------------
CREATE DATABASE ecommerce
ENCODING 'UTF8';



/*
	[Note]
	
	after creating the database follow these steps

	1- open the 'SQL Editor' from pgadmin .
	2- select the database you have created .
	3- run the code below to create tables .
	
*/



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


-- Create genders Table
-- --------------------
CREATE TABLE IF NOT EXISTS genders
(
	GenderID SMALLSERIAL NOT NULL,
	GenderName VARCHAR(7) NOT NULL UNIQUE,
	
	PRIMARY KEY (GenderID)
);

-- Create roles Table
-- ------------------
CREATE TABLE IF NOT EXISTS roles
(
	RoleID SMALLSERIAL NOT NULL,
	RoleName VARCHAR(150) NOT NULL UNIQUE,
	
	PRIMARY KEY (RoleID)
);

-- Create users Table
-- ------------------
CREATE TABLE IF NOT EXISTS users
(
	UserID SERIAL NOT NULL,
	UserFirstName VARCHAR(20) NOT NULL,
	UserLastName VARCHAR(20) NOT NULL,
	UserEmail VARCHAR(80) NOT NULL UNIQUE,
	UserPassword CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	UserBirthDate DATE NOT NULL, -- format (yyyy-mm-dd)
	UserGender SMALLINT NOT NULL,
	UserStatus BOOLEAN NOT NULL DEFAULT false, -- false (not active) | true (active)
	UserCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (UserGender) REFERENCES genders (GenderID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (UserID)
);

-- Create users_roles Table
-- ------------------------
CREATE TABLE IF NOT EXISTS users_roles
(
	UserRoleID SERIAL NOT NULL,
	UserID BIGINT NOT NULL,
	RoleID SMALLINT NOT NULL,
	
	FOREIGN KEY (UserID) REFERENCES users (UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (RoleID) REFERENCES roles (RoleID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (UserRoleID)
);

-- Create customers Table
-- ----------------------
CREATE TABLE IF NOT EXISTS customers
(
	CustomerID SERIAL NOT NULL,
	CustomerFirstName VARCHAR(20) NOT NULL,
	CustomerLastName VARCHAR(20) NOT NULL,
	CustomerEmail VARCHAR(80) NOT NULL UNIQUE,
	CustomerPassword CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	CustomerBirthDate DATE NOT NULL, -- format (yyyy-mm-dd)
	CustomerGender SMALLINT NOT NULL,
	CustomerCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerGender) REFERENCES genders (GenderID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (CustomerID)
);

-- Create manufactures Table
-- -------------------------
CREATE TABLE IF NOT EXISTS manufactures
(
	ManufactureID SMALLSERIAL NOT NULL,
	ManufactureName VARCHAR(100) NOT NULL UNIQUE,
	
	PRIMARY KEY (ManufactureID)
);

-- Create categories_kinds Table
-- -----------------------------
CREATE TABLE IF NOT EXISTS categories_kinds
(
	CategoryKindID SMALLINT NOT NULL,
	CategoryKindName VARCHAR(30) NOT NULL UNIQUE,
	
	PRIMARY KEY (CategoryKindID)
);

-- Create categories Table
-- -----------------------
CREATE TABLE IF NOT EXISTS categories
(
	CategoryID SMALLSERIAL NOT NULL,
	CategoryName VARCHAR(200) NOT NULL,
	CategoryKind SMALLINT NOT NULL,
	
	FOREIGN KEY (CategoryKind) REFERENCES categories_kinds (CategoryKindID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (CategoryID)
);

-- Create sizes Table
-- ------------------
CREATE TABLE IF NOT EXISTS sizes
(
	SizeID SMALLSERIAL NOT NULL,
	SizeName VARCHAR(50) NOT NULL UNIQUE,
	
	PRIMARY KEY (SizeID)
);

-- Create colors Table
-- -------------------
CREATE TABLE IF NOT EXISTS colors
(
	ColorID SMALLSERIAL NOT NULL,
	ColorName VARCHAR(50) NOT NULL UNIQUE,
	ColorCode CHAR(7) NOT NULL UNIQUE DEFAULT '#FFFFFF',
	
	PRIMARY KEY (ColorID)
);

-- Create products Table
-- ---------------------
CREATE TABLE IF NOT EXISTS products
(
	ProductID SERIAL NOT NULL,
	ProductSku CHAR(12) NOT NULL UNIQUE,
	ProductName VARCHAR(200) NOT NULL,
	ProductPrice DECIMAL(9,2) NOT NULL DEFAULT 0,
	ProductDiscount SMALLINT NOT NULL DEFAULT 0,
	ProductQuantity INT NOT NULL DEFAULT 1,
	ProductManufacture SMALLINT NOT NULL,
	ProductCategory SMALLINT NOT NULL,
	ProductDescription TEXT NULL,
	ProductView INT NOT NULL DEFAULT 0,
	ProductUser INT NOT NULL,
	ProductCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (ProductManufacture) REFERENCES manufactures (ManufactureID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductCategory) REFERENCES categories (CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductUser) REFERENCES users (UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (ProductID)
);

-- Create products_images Table
-- ----------------------------
CREATE TABLE IF NOT EXISTS products_images
(
	ProductImageID SERIAL NOT NULL,
	ImageName VARCHAR(200) NOT NULL,
	ProductID INT NOT NULL,
	
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (ProductImageID)
);

-- Create products_sizes Table
-- ---------------------------
CREATE TABLE IF NOT EXISTS products_sizes
(
	ProductSizeID SERIAL NOT NULL,
	SizeID SMALLINT NOT NULL,
	ProductID INT NOT NULL,
	
	FOREIGN KEY (SizeID) REFERENCES sizes (SizeID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (ProductSizeID)
);

-- Create products_colors Table
-- ----------------------------
CREATE TABLE IF NOT EXISTS products_colors
(
	ProductColorID SERIAL NOT NULL,
	ColorID SMALLINT NOT NULL,
	ProductID INT NOT NULL,
	
	FOREIGN KEY (ColorID) REFERENCES colors (ColorID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (ProductColorID)
);

-- Create shopping_cart Table
-- --------------------------
CREATE TABLE IF NOT EXISTS shopping_cart
(
	CartID SERIAL NOT NULL,
	CustomerID INT NOT NULL,
	ProductID INT NOT NULL,
	CartDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerID) REFERENCES customers (CustomerID),
	FOREIGN KEY (ProductID) REFERENCES products (ProductID),
	
	PRIMARY KEY (CartID)
);

-- Create countries Table
-- ----------------------
CREATE TABLE IF NOT EXISTS countries
(
	CountryID SMALLINT NOT NULL,
	CountryCode VARCHAR(20) NOT NULL,
	CountryCodeAlpha2 CHAR(2) NOT NULL,
	CountryCodeAlpha3 CHAR(3) NOT NULL,
	CountryNameEn VARCHAR(200) NOT NULL,
	CountryNameAr VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (CountryID)
);

-- Create orders Table
-- -------------------
CREATE TABLE IF NOT EXISTS orders
(
	OrderID INT NOT NULL,
	CustomerID INT NOT NULL,
	CustomerName VARCHAR(100) NOT NULL,
	CustomerCountry SMALLINT NOT NULL,
	CustomerCity VARCHAR(100) NOT NULL,
	CustomerRegion VARCHAR(100) NOT NULL,
	CustomerZip VARCHAR(10) NULL,
	CustomerAddress VARCHAR(200) NOT NULL,
	CustomerPhone VARCHAR(20) NULL,
	OrderDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerID) REFERENCES customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (CustomerCountry) REFERENCES countries (CountryID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (OrderID)
);

-- Create orders_details Table
-- ---------------------------
CREATE TABLE IF NOT EXISTS orders_details
(
	OrderDetailID SERIAL NOT NULL,
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity INT NOT NULL,
	UnitPrice DECIMAL(9,2) NOT NULL,
	Discount SMALLINT NOT NULL DEFAULT 0,
	
	FOREIGN KEY (OrderID) REFERENCES orders (OrderID),
	FOREIGN KEY (ProductID) REFERENCES products (ProductID),
	
	PRIMARY KEY (OrderDetailID)
);