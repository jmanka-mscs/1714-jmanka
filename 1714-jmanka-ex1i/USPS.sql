USE [master]
GO
/****** Object:  Database [USPS]    Script Date: 10/7/2020 2:19:22 AM ******/
CREATE DATABASE [USPS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'USPS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\USPS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'USPS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\USPS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [USPS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [USPS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [USPS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [USPS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [USPS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [USPS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [USPS] SET ARITHABORT OFF 
GO
ALTER DATABASE [USPS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [USPS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [USPS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [USPS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [USPS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [USPS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [USPS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [USPS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [USPS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [USPS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [USPS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [USPS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [USPS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [USPS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [USPS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [USPS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [USPS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [USPS] SET RECOVERY FULL 
GO
ALTER DATABASE [USPS] SET  MULTI_USER 
GO
ALTER DATABASE [USPS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [USPS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [USPS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [USPS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [USPS] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'USPS', N'ON'
GO
ALTER DATABASE [USPS] SET QUERY_STORE = OFF
GO
USE [USPS]
GO
/****** Object:  Table [dbo].[Address]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Address](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[RouteNumber] [int] NOT NULL,
	[Address] [nvarchar](50) NOT NULL,
	[City] [nvarchar](50) NOT NULL,
	[State] [nvarchar](50) NOT NULL,
	[Zip] [int] NOT NULL,
	[CircumstanceId] [int] NULL,
	[CaseId] [int] NULL,
	[PoBox?] [bit] NOT NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CaseLocation]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CaseLocation](
	[CaseId] [int] IDENTITY(1,1) NOT NULL,
	[Row] [int] NOT NULL,
	[Column] [nchar](10) NOT NULL,
 CONSTRAINT [PK_CaseLocation] PRIMARY KEY CLUSTERED 
(
	[CaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CircumstanceId]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CircumstanceId](
	[CircumstanceId] [int] IDENTITY(1,1) NOT NULL,
	[TypeId] [int] NOT NULL,
	[TenseId] [int] NOT NULL,
 CONSTRAINT [PK_CircumstanceId] PRIMARY KEY CLUSTERED 
(
	[CircumstanceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CircumstanceType]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CircumstanceType](
	[TypeId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_CircumstanceType] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[FirstNameOrBusinessName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[AddressId] [int] NULL,
	[CircumstanceId] [int] NULL,
	[PreviousFwd?] [bit] NOT NULL,
	[CurrentFwd?] [bit] NOT NULL,
	[FutureFwd?] [bit] NOT NULL,
	[PoBox?] [bit] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Forwards]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Forwards](
	[ForwardId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[PreviousAddressId] [int] NOT NULL,
	[FutureAddressId] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[TenseId] [int] NOT NULL,
 CONSTRAINT [PK_Forwards] PRIMARY KEY CLUSTERED 
(
	[ForwardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tense]    Script Date: 10/7/2020 2:19:23 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tense](
	[TenseId] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nchar](10) NOT NULL,
 CONSTRAINT [PK_Tense] PRIMARY KEY CLUSTERED 
(
	[TenseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Address] ON 

INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (1, 6, N'615 McHugh Rd. #8', N'Holmen', N'WI', 54636, NULL, 1, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (3, 6, N'615 McHugh Rd. #9', N'Holmen', N'WI', 54636, NULL, 1, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (4, 2, N'35636 5th St.', N'Independence', N'WI', 54747, NULL, NULL, 1)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (5, 4, N'N35111 Przybilla Rd.', N'Independence', N'WI', 54747, NULL, 13, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (6, 8, N'201 Kenneda St.', N'Holmen', N'WI', 54636, NULL, 15, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (7, 7, N'1111 Linden Dr.', N'Holmen', N'WI', 54636, NULL, NULL, 1)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (8, 22, N'W39482 Sky Harbor Dr.', N'Eau Claire', N'WI', 54701, 5, 18, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (10, 1, N'N9391 US Hwy 53 Trailer #50', N'Holmen', N'WI', 54636, NULL, 7, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (11, 10, N'801 Timberwood Ln.', N'Holmen', N'WI', 54636, NULL, 8, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (12, 3, N'N763 Valley Pl.', N'Fountain City', N'WI', 54629, NULL, 4, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (13, 1, N'W7070 County Rd. T', N'Holmen', N'WI', 54636, 2, 11, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (14, 7, N'208 Park Ln. ', N'Holmen', N'WI', 54636, NULL, 3, 0)
INSERT [dbo].[Address] ([AddressId], [RouteNumber], [Address], [City], [State], [Zip], [CircumstanceId], [CaseId], [PoBox?]) VALUES (15, 8, N'412 Lilly Ct.', N'Holmen', N'WI', 54636, NULL, 8, 0)
SET IDENTITY_INSERT [dbo].[Address] OFF
GO
SET IDENTITY_INSERT [dbo].[CaseLocation] ON 

INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (1, 1, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (2, 1, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (3, 1, N'C         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (4, 2, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (5, 2, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (6, 2, N'C         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (7, 3, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (8, 3, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (9, 3, N'C         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (10, 4, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (11, 4, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (12, 4, N'C         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (13, 5, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (14, 5, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (15, 5, N'C         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (16, 6, N'A         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (17, 6, N'B         ')
INSERT [dbo].[CaseLocation] ([CaseId], [Row], [Column]) VALUES (18, 6, N'C         ')
SET IDENTITY_INSERT [dbo].[CaseLocation] OFF
GO
SET IDENTITY_INSERT [dbo].[CircumstanceId] ON 

INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (1, 1, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (2, 1, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (3, 1, 3)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (4, 2, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (5, 2, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (6, 2, 3)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (7, 3, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (8, 3, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (9, 3, 3)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (10, 4, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (11, 4, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (12, 4, 3)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (13, 5, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (14, 5, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (15, 5, 3)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (16, 6, 1)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (17, 6, 2)
INSERT [dbo].[CircumstanceId] ([CircumstanceId], [TypeId], [TenseId]) VALUES (18, 6, 3)
SET IDENTITY_INSERT [dbo].[CircumstanceId] OFF
GO
SET IDENTITY_INSERT [dbo].[CircumstanceType] ON 

INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (1, N'Dog alert')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (2, N'Dangerous driveway')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (3, N'Hardship')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (4, N'Hold')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (5, N'Dog alert & dangerous driveway')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (6, N'Hardship & hold')
INSERT [dbo].[CircumstanceType] ([TypeId], [Type]) VALUES (7, N'')
SET IDENTITY_INSERT [dbo].[CircumstanceType] OFF
GO
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (1, N'Jessi', N'Manka', 1, NULL, 1, 0, 0, 0)
INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (2, N'Nathan', N'Martin', 1, NULL, 1, 0, 1, 0)
INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (3, N'Diane', N'Martin', 12, NULL, 1, 1, 0, 0)
INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (4, N'Jenny', N'Manka', 6, 12, 1, 0, 0, 0)
INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (5, N'Sheri', N'Zilla', 4, NULL, 0, 0, 0, 1)
INSERT [dbo].[Customer] ([CustomerId], [FirstNameOrBusinessName], [LastName], [AddressId], [CircumstanceId], [PreviousFwd?], [CurrentFwd?], [FutureFwd?], [PoBox?]) VALUES (6, N'Richard', N'Fonstad', 14, 7, 0, 1, 0, 0)
SET IDENTITY_INSERT [dbo].[Customer] OFF
GO
SET IDENTITY_INSERT [dbo].[Forwards] ON 

INSERT [dbo].[Forwards] ([ForwardId], [CustomerId], [PreviousAddressId], [FutureAddressId], [StartDate], [TenseId]) VALUES (1, 1, 11, 1, CAST(N'2019-01-03' AS Date), 1)
INSERT [dbo].[Forwards] ([ForwardId], [CustomerId], [PreviousAddressId], [FutureAddressId], [StartDate], [TenseId]) VALUES (2, 2, 11, 1, CAST(N'2019-01-03' AS Date), 1)
INSERT [dbo].[Forwards] ([ForwardId], [CustomerId], [PreviousAddressId], [FutureAddressId], [StartDate], [TenseId]) VALUES (3, 2, 1, 12, CAST(N'2020-12-01' AS Date), 3)
INSERT [dbo].[Forwards] ([ForwardId], [CustomerId], [PreviousAddressId], [FutureAddressId], [StartDate], [TenseId]) VALUES (4, 3, 11, 12, CAST(N'2020-09-02' AS Date), 2)
INSERT [dbo].[Forwards] ([ForwardId], [CustomerId], [PreviousAddressId], [FutureAddressId], [StartDate], [TenseId]) VALUES (5, 6, 15, 14, CAST(N'2019-05-17' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Forwards] OFF
GO
SET IDENTITY_INSERT [dbo].[Tense] ON 

INSERT [dbo].[Tense] ([TenseId], [Type]) VALUES (1, N'Previous  ')
INSERT [dbo].[Tense] ([TenseId], [Type]) VALUES (2, N'Current   ')
INSERT [dbo].[Tense] ([TenseId], [Type]) VALUES (3, N'Future    ')
SET IDENTITY_INSERT [dbo].[Tense] OFF
GO
USE [master]
GO
ALTER DATABASE [USPS] SET  READ_WRITE 
GO
