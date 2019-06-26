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
	Serial SERIAL NOT NULL,
	GenderID INTEGER NOT NULL UNIQUE,
	GenderName VARCHAR(20) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create roles Table
-- ------------------
CREATE TABLE IF NOT EXISTS roles
(
	Serial SERIAL NOT NULL,
	RoleID INTEGER NOT NULL UNIQUE,
	RoleName VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create users Table
-- ------------------
CREATE TABLE IF NOT EXISTS users
(
	Serial SERIAL NOT NULL,
	UserID INTEGER NOT NULL UNIQUE,
	UserFirstName VARCHAR(20) NOT NULL,
	UserLastName VARCHAR(20) NOT NULL,
	UserEmail VARCHAR(100) NOT NULL UNIQUE,
	UserPassword CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	UserBirthDate DATE NOT NULL, -- format (yyyy-mm-dd)
	UserGender INTEGER NOT NULL,
	UserStatus BOOLEAN NOT NULL DEFAULT false, -- false (not active) | true (active)
	UserCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (UserGender) REFERENCES genders (GenderID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (UserID)
);

-- Create users_roles Table
-- ------------------------
CREATE TABLE IF NOT EXISTS users_roles
(
	Serial SERIAL NOT NULL,
	UserID INTEGER NOT NULL,
	RoleID INTEGER NOT NULL,
	
	FOREIGN KEY (UserID) REFERENCES users (UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (RoleID) REFERENCES roles (RoleID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create customers Table
-- ----------------------
CREATE TABLE IF NOT EXISTS customers
(
	Serial SERIAL NOT NULL,
	CustomerID INTEGER NOT NULL UNIQUE,
	CustomerFirstName VARCHAR(20) NOT NULL,
	CustomerLastName VARCHAR(20) NOT NULL,
	CustomerEmail VARCHAR(100) NOT NULL UNIQUE,
	CustomerPassword CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	CustomerBirthDate DATE NOT NULL, -- format (yyyy-mm-dd)
	CustomerGender INTEGER NOT NULL,
	CustomerCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerGender) REFERENCES genders (GenderID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create manufactures Table
-- -------------------------
CREATE TABLE IF NOT EXISTS manufactures
(
	Serial SERIAL NOT NULL,
	ManufactureID INTEGER NOT NULL UNIQUE,
	ManufactureName VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create categories_kinds Table
-- -----------------------------
CREATE TABLE IF NOT EXISTS categories_kinds
(
	Serial SERIAL NOT NULL,
	CategoryKindID INTEGER NOT NULL UNIQUE,
	CategoryKindName VARCHAR(50) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create categories Table
-- -----------------------
CREATE TABLE IF NOT EXISTS categories
(
	Serial SERIAL NOT NULL,
	CategoryID INTEGER NOT NULL UNIQUE,
	CategoryName VARCHAR(200) NOT NULL,
	CategoryKind INTEGER NOT NULL,
	
	FOREIGN KEY (CategoryKind) REFERENCES categories_kinds (CategoryKindID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create sizes Table
-- ------------------
CREATE TABLE IF NOT EXISTS sizes
(
	Serial SERIAL NOT NULL,
	SizeID INTEGER NOT NULL UNIQUE,
	SizeName VARCHAR(100) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create colors Table
-- -------------------
CREATE TABLE IF NOT EXISTS colors
(
	Serial SERIAL NOT NULL,
	ColorID INTEGER NOT NULL UNIQUE,
	ColorName VARCHAR(50) NOT NULL,
	ColorCode CHAR(7) NOT NULL DEFAULT '#FFFFFF',
	
	PRIMARY KEY (Serial)
);

-- Create products Table
-- ---------------------
CREATE TABLE IF NOT EXISTS products
(
	Serial SERIAL NOT NULL,
	ProductID INTEGER NOT NULL UNIQUE,
	ProductSku CHAR(12) NOT NULL UNIQUE,
	ProductName VARCHAR(200) NOT NULL,
	ProductPrice DECIMAL(9,2) NOT NULL DEFAULT 0,
	ProductDiscount SMALLINT NOT NULL DEFAULT 0,
	ProductQuantity SMALLINT NOT NULL DEFAULT 1,
	ProductManufacture INTEGER NOT NULL,
	ProductCategory INTEGER NOT NULL,
	ProductDescription TEXT NULL,
	ProductView INTEGER NOT NULL DEFAULT 0,
	ProductUser INTEGER NOT NULL,
	ProductCreatedDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (ProductManufacture) REFERENCES manufactures (ManufactureID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductCategory) REFERENCES categories (CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductUser) REFERENCES users (UserID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create products_images Table
-- ----------------------------
CREATE TABLE IF NOT EXISTS products_images
(
	Serial SERIAL NOT NULL,
	ImageName VARCHAR(200) NOT NULL,
	ProductID INTEGER NOT NULL,
	
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create products_sizes Table
-- ---------------------------
CREATE TABLE IF NOT EXISTS products_sizes
(
	Serial SERIAL NOT NULL,
	SizeID INTEGER NOT NULL,
	ProductID INTEGER NOT NULL,
	
	FOREIGN KEY (SizeID) REFERENCES sizes (SizeID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create products_colors Table
-- ----------------------------
CREATE TABLE IF NOT EXISTS products_colors
(
	Serial SERIAL NOT NULL,
	ColorID INTEGER NOT NULL,
	ProductID INTEGER NOT NULL,
	
	FOREIGN KEY (ColorID) REFERENCES colors (ColorID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (ProductID) REFERENCES products (ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create shopping_cart Table
-- --------------------------
CREATE TABLE IF NOT EXISTS shopping_cart
(
	Serial SERIAL NOT NULL,
	CustomerID INTEGER NOT NULL,
	ProductID INTEGER NOT NULL,
	CartDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerID) REFERENCES customers (CustomerID),
	FOREIGN KEY (ProductID) REFERENCES products (ProductID),
	
	PRIMARY KEY (Serial)
);

-- Create countries Table
-- ----------------------
CREATE TABLE IF NOT EXISTS countries
(
	Serial SERIAL NOT NULL,
	CountryID INTEGER NOT NULL UNIQUE,
	CountryCode VARCHAR(20) NOT NULL,
	CountryCodeAlpha2 CHAR(2) NOT NULL,
	CountryCodeAlpha3 CHAR(3) NOT NULL,
	CountryNameEn VARCHAR(200) NOT NULL,
	CountryNameAr VARCHAR(200) NOT NULL,
	
	PRIMARY KEY (Serial)
);

-- Create orders Table
-- -------------------
CREATE TABLE IF NOT EXISTS orders
(
	Serial SERIAL NOT NULL,
	OrderID INTEGER NOT NULL UNIQUE,
	CustomerID INTEGER NOT NULL,
	CustomerName VARCHAR(100) NOT NULL,
	CustomerCountry INTEGER NOT NULL,
	CustomerCity VARCHAR(100) NOT NULL,
	CustomerRegion VARCHAR(100) NOT NULL,
	CustomerZip VARCHAR(10) NULL,
	CustomerAddress VARCHAR(200) NOT NULL,
	CustomerPhone VARCHAR(20) NULL,
	OrderDate TIMESTAMP DEFAULT NOW(),
	
	FOREIGN KEY (CustomerID) REFERENCES customers (CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (CustomerCountry) REFERENCES countries (CountryID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
);

-- Create orders_details Table
-- ---------------------------
CREATE TABLE IF NOT EXISTS orders_details
(
	Serial SERIAL NOT NULL,
	OrderID INT NOT NULL,
	ProductID INT NOT NULL,
	Quantity SMALLINT NOT NULL,
	UnitPrice DECIMAL(9,2) NOT NULL,
	Discount SMALLINT NOT NULL DEFAULT 0,
	
	FOREIGN KEY (OrderID) REFERENCES orders (OrderID),
	FOREIGN KEY (ProductID) REFERENCES products (ProductID),
	
	PRIMARY KEY (Serial)
);