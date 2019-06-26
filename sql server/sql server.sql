/*
 * author name    (ahmed hassan)
 * author email   (ahmedh12491@gmail.com)
 *
 * database       (sql server)
 */
 
-- Drop Database If Exists
-- -----------------------
IF EXISTS (SELECT * FROM sysdatabases WHERE name='[ecommerce]')
USE [master];
DROP DATABASE [ecommerce];

GO

-- Create Database
-- ---------------
CREATE DATABASE [ecommerce]
ON
(
    NAME = ecommerce,
	
	-- The path of (mdf) data file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce.mdf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
),
FILEGROUP FileGroup1
(
    NAME = ecommerce1,
	
	-- The path of (ndf) data file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce1.ndf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
),
(
    NAME = ecommerce2,
	
	-- The path of (ndf) data file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce2.ndf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
),
FILEGROUP FileGroup2
(
    NAME = ecommerce3,
	
	-- The path of (ndf) data file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce3.ndf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
),
(
    NAME = ecommerce4,
	
	-- The path of (ndf) data file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce4.ndf',
    SIZE = 200MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
)
LOG ON
(
    NAME = ecommerce_log,
	
	-- The path of (ldf) log file
    FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\ecommerce_log.ldf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 100MB
)
	COLLATE Arabic_CI_AI_KS_WS
;

GO

-- Use Database
-- ------------
USE ecommerce;

GO

-- Recovery Mode
-- -------------
ALTER DATABASE ecommerce SET RECOVERY SIMPLE;

GO

-- Drop Existing Tables
-- --------------------
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[users_roles]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[users_roles]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[orders_details]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[orders_details]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[shopping_cart]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[shopping_cart]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[customers]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[customers]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[roles]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[roles]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[products_colors]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[products_colors]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[products_sizes]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[products_sizes]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[products_images]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[products_images]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[products]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[products]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[categories]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[categories]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[categories_kinds]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[categories_kinds]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[users]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[users]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[manufactures]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[manufactures]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[sizes]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[sizes]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[colors]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[colors]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[orders]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[orders]
GO
IF EXISTS (SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[countries]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[countries]
GO
IF EXISTS(SELECT * FROM sysobjects WHERE ID = object_ID('[dbo].[genders]') and sysstat & 0xf = 3)
DROP TABLE [dbo].[genders]

GO

-- Create [genders] Table
-- ----------------------
CREATE TABLE [genders]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[GenderID] INT NOT NULL UNIQUE,
	[GenderName] NVARCHAR(20) NOT NULL,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [roles] Table
-- --------------------
CREATE TABLE [roles]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[RoleID] INT NOT NULL UNIQUE,
	[RoleName] NVARCHAR(200) NOT NULL,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [users] Table
-- --------------------
CREATE TABLE [users]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[UserID] INT NOT NULL UNIQUE,
	[UserFirstName] NVARCHAR(20) NOT NULL,
	[UserLastName] NVARCHAR(20) NOT NULL,
	[UserEmail] NVARCHAR(100) NOT NULL UNIQUE,
	[UserPassword] CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	[UserBirthDate] DATE NOT NULL, -- format (yyyy-mm-dd)
	[UserGender] INT NOT NULL,
	[UserStatus] BIT NOT NULL DEFAULT 0, -- 0 (not active) | 1 (active)
	[UserCreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
	
	FOREIGN KEY ([UserGender]) REFERENCES [dbo].[genders] ([GenderID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [users_roles] Table
-- --------------------------
CREATE TABLE [users_roles]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[UserID] INT NOT NULL,
	[RoleID] INT NOT NULL,
	
	FOREIGN KEY ([UserID]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([RoleID]) REFERENCES [dbo].[roles] ([RoleID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [customers] Table
-- ------------------------
CREATE TABLE [customers]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[CustomerID] INT NOT NULL UNIQUE,
	[CustomerFirstName] NVARCHAR(20) NOT NULL,
	[CustomerLastName] NVARCHAR(20) NOT NULL,
	[CustomerEmail] NVARCHAR(100) NOT NULL UNIQUE,
	[CustomerPassword] CHAR(60) NOT NULL, -- values in this column should be encrypted or hashed
	[CustomerBirthDate] DATE NOT NULL, -- format (yyyy-mm-dd)
	[CustomerGender] INT NOT NULL,
	[CustomerCreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
	
	FOREIGN KEY ([CustomerGender]) REFERENCES [dbo].[genders] ([GenderID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [manufactures] Table
-- ---------------------------
CREATE TABLE [manufactures]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[ManufactureID] INT NOT NULL UNIQUE,
	[ManufactureName] NVARCHAR(100) NOT NULL,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [categories_kinds] Table
-- -------------------------------
CREATE TABLE [categories_kinds]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[CategoryKindID] INT NOT NULL UNIQUE,
	[CategoryKindName] NVARCHAR(50) NOT NULL,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [categories] Table
-- -------------------------
CREATE TABLE [categories]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[CategoryID] INT NOT NULL UNIQUE,
	[CategoryName] NVARCHAR(200) NOT NULL,
	[CategoryKind] INT NOT NULL,
	
	FOREIGN KEY ([CategoryKind]) REFERENCES [dbo].[categories_kinds] ([CategoryKindID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [sizes] Table
-- --------------------
CREATE TABLE [sizes]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[SizeID] INT NOT NULL UNIQUE,
	[SizeName] NVARCHAR(100) NOT NULL,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [colors] Table
-- ---------------------
CREATE TABLE [colors]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[ColorID] INT NOT NULL UNIQUE,
	[ColorName] NVARCHAR(50) NOT NULL,
	[ColorCode] CHAR(7) NOT NULL DEFAULT '#FFFFFF',
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [products] Table
-- -----------------------
CREATE TABLE [products]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[ProductID] INT NOT NULL UNIQUE,
	[ProductSku] CHAR(12) NOT NULL UNIQUE,
	[ProductName] NVARCHAR(200) NOT NULL,
	[ProductPrice] DECIMAL(9,2) NOT NULL DEFAULT 0,
	[ProductDiscount] SMALLINT NOT NULL DEFAULT 0,
	[ProductQuantity] SMALLINT NOT NULL DEFAULT 1,
	[ProductManufacture] INT NOT NULL,
	[ProductCategory] INT NOT NULL,
	[ProductDescription] TEXT NULL,
	[ProductView] INT NOT NULL DEFAULT 0,
	[ProductUser] INT NOT NULL,
	[ProductCreatedDate] DATETIME NOT NULL DEFAULT GETDATE(),
	
	FOREIGN KEY ([ProductManufacture]) REFERENCES [dbo].[manufactures] ([ManufactureID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([ProductCategory]) REFERENCES [dbo].[categories] ([CategoryID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([ProductUser]) REFERENCES [dbo].[users] ([UserID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [products_images] Table
-- ------------------------------
CREATE TABLE [products_images]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[ImageName] NVARCHAR(200) NOT NULL,
	[ProductID] INT NOT NULL,
	
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].[products] ([ProductID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [products_sizes] Table
-- -----------------------------
CREATE TABLE [products_sizes]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[SizeID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	
	FOREIGN KEY ([SizeID]) REFERENCES [dbo].[sizes] ([SizeID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].[products] ([ProductID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [products_colors] Table
-- ------------------------------
CREATE TABLE [products_colors]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[ColorID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	
	FOREIGN KEY ([ColorID]) REFERENCES [dbo].[colors] ([ColorID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].[products] ([ProductID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY (Serial)
)
ON "FileGroup1";

GO

-- Create [shopping_cart] Table
-- ----------------------------
CREATE TABLE [shopping_cart]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[CustomerID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	[CartDate] DATETIME NOT NULL DEFAULT GETDATE(),
	
	FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[customers] ([CustomerID]),
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].products ([ProductID]),
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup1";

GO

-- Create [countries] Table
-- ------------------------
CREATE TABLE [countries]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[CountryID] INT NOT NULL UNIQUE,
	[CountryCode] NVARCHAR(20) NOT NULL,
	[CountryCodeAlpha2] CHAR(2) NOT NULL,
	[CountryCodeAlpha3] CHAR(3) NOT NULL,
	[CountryNameEn] NVARCHAR(200) NOT NULL,
	[CountryNameAr] NVARCHAR(200) NOT NULL,
	
	PRIMARY KEY ([Serial])
);

GO

-- Create [orders] Table
-- ---------------------
CREATE TABLE [orders]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[OrderID] INT NOT NULL UNIQUE,
	[CustomerID] INT NOT NULL,
	[CustomerName] NVARCHAR(100) NOT NULL,
	[CustomerCountry] INT NOT NULL,
	[CustomerCity] NVARCHAR(100) NOT NULL,
	[CustomerRegion] NVARCHAR(100) NOT NULL,
	[CustomerZip] NVARCHAR(10) NULL,
	[CustomerAddress] NVARCHAR(200) NOT NULL,
	[CustomerPhone] NVARCHAR(20) NULL,
	[OrderDate] DATETIME NOT NULL DEFAULT GETDATE(),
	
	FOREIGN KEY ([CustomerID]) REFERENCES [dbo].[customers] ([CustomerID]) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY ([CustomerCountry]) REFERENCES [dbo].[countries] ([CountryID]) ON DELETE CASCADE ON UPDATE CASCADE,
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup2";

GO

-- Create [orders_details] Table
-- -----------------------------
CREATE TABLE [orders_details]
(
	[Serial] INT NOT NULL IDENTITY(1,1),
	[OrderID] INT NOT NULL,
	[ProductID] INT NOT NULL,
	[Quantity] SMALLINT NOT NULL,
	[UnitPrice] DECIMAL(9,2) NOT NULL,
	[Discount] SMALLINT NOT NULL DEFAULT 0,
	
	FOREIGN KEY ([OrderID]) REFERENCES [dbo].[orders] ([OrderID]),
	FOREIGN KEY ([ProductID]) REFERENCES [dbo].[products] ([ProductID]),
	
	PRIMARY KEY ([Serial])
)
ON "FileGroup2";