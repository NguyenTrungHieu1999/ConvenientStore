USE [master]
GO
/****** Object:  Database [ConvenientStore]    Script Date: 7/30/2020 10:38:43 AM ******/
CREATE DATABASE [ConvenientStore]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ConvenientStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ConvenientStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ConvenientStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ConvenientStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ConvenientStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ConvenientStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [ConvenientStore] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [ConvenientStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ConvenientStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ConvenientStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ConvenientStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ConvenientStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ConvenientStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ConvenientStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ConvenientStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ConvenientStore] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ConvenientStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ConvenientStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ConvenientStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ConvenientStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ConvenientStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ConvenientStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ConvenientStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ConvenientStore] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ConvenientStore] SET  MULTI_USER 
GO
ALTER DATABASE [ConvenientStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ConvenientStore] SET DB_CHAINING OFF 
GO
USE [ConvenientStore]
GO
/****** Object:  Table [dbo].[Bill]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill](
	[BillID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[CreateDate] [datetime] NULL,
	[TotalMoney] [decimal](18, 0) NULL,
	[Status] [int] NULL,
	[Address] [nvarchar](250) NULL,
	[CreditCard] [nvarchar](250) NULL,
 CONSTRAINT [PK_Bill] PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BillDetail]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BillDetail](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[BillID] [bigint] NULL,
	[ProductID] [bigint] NULL,
	[Quantity] [int] NULL,
	[Price] [decimal](18, 0) NULL,
 CONSTRAINT [PK_BillDetail_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[ProductID] [bigint] NULL,
	[Quantity] [int] NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmpID] [bigint] NULL,
	[Salary] [decimal](18, 0) NULL,
 CONSTRAINT [PK_Employee] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FavoriteProduct]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FavoriteProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[ProductID] [bigint] NULL,
 CONSTRAINT [PK_FavoriteProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[NotiID] [bigint] IDENTITY(1,1) NOT NULL,
	[ContentNotification] [nvarchar](250) NULL,
	[CreateDate] [datetime] NULL,
	[CreateBy] [nvarchar](250) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](250) NULL,
	[Show] [bit] NULL,
 CONSTRAINT [PK_Notification] PRIMARY KEY CLUSTERED 
(
	[NotiID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[BarCode] [nvarchar](250) NULL,
	[MetaTitle] [nvarchar](250) NULL,
	[Descriptions] [nvarchar](500) NULL,
	[Image] [nvarchar](250) NULL,
	[Price] [decimal](18, 0) NULL,
	[PromotionPrice] [decimal](18, 0) NULL,
	[Quantity] [int] NOT NULL,
	[CategoryID] [bigint] NULL,
	[Detail] [ntext] NULL,
	[CreateDate] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[PopupID] [nvarchar](250) NULL,
	[RateStar] [float] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[CateID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](250) NULL,
	[MetaTitle] [varchar](250) NULL,
	[DisplayOrder] [int] NULL,
	[CreateDate] [datetime] NULL,
	[CreateBy] [nvarchar](50) NULL,
	[ModifiedDate] [datetime] NULL,
	[ModifiedBy] [nvarchar](50) NULL,
	[Status] [bit] NULL,
	[ShowOnHome] [bit] NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[CateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductRate]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductRate](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[ProductID] [bigint] NULL,
	[RateStar] [float] NULL,
	[CommentContent] [nvarchar](250) NULL,
 CONSTRAINT [PK_ProductRate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NULL,
	[Password] [varchar](500) NULL,
	[GroupID] [varchar](20) NULL,
	[Name] [nvarchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[Sex] [bit] NULL,
	[Address] [nvarchar](250) NULL,
	[Email] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Status] [bit] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[WatchedProduct]    Script Date: 7/30/2020 10:38:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WatchedProduct](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NULL,
	[ProductID] [bigint] NULL,
 CONSTRAINT [PK_WatchedProduct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Bill] ON 

INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10101, 21, CAST(N'2019-01-03T08:31:57.637' AS DateTime), CAST(87120 AS Decimal(18, 0)), 3, N'TP.HCM', N'1234 5869 2243 0245 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10102, 33, CAST(N'2019-02-03T08:54:54.423' AS DateTime), CAST(91974 AS Decimal(18, 0)), 0, N'TP.HCM', N'1111 1111 1111 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10103, 33, CAST(N'2019-02-25T08:56:53.913' AS DateTime), CAST(91974 AS Decimal(18, 0)), 1, N'TP.HCM', N'1111 1111 1111 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10104, 33, CAST(N'2019-03-11T08:59:11.783' AS DateTime), CAST(91974 AS Decimal(18, 0)), 0, N'TP.HCM', N'1111 1111 1111 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10105, 33, CAST(N'2019-03-23T09:00:28.710' AS DateTime), CAST(650000 AS Decimal(18, 0)), 1, N'TP.HCM', N'2222 2222 2222 2222 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10106, 1, CAST(N'2019-03-06T09:18:43.170' AS DateTime), CAST(5200 AS Decimal(18, 0)), 0, N'TP.HCM', N'1111 1111 1111 1333 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10107, 1, CAST(N'2019-04-03T09:19:37.473' AS DateTime), CAST(5200 AS Decimal(18, 0)), 3, N'TP.HCM', N'1111 1111 1111 1333 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10108, 17, CAST(N'2019-05-25T09:29:04.760' AS DateTime), CAST(9000 AS Decimal(18, 0)), 0, N'Quận 9', N'1234 1111 1111 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10109, 17, CAST(N'2019-05-11T09:30:38.030' AS DateTime), CAST(478000 AS Decimal(18, 0)), 0, N'Quận 9', N'1234 1522 5254 5545 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10110, 18, CAST(N'2019-06-10T09:36:22.017' AS DateTime), CAST(1252000 AS Decimal(18, 0)), 4, N'Quận 9', N'5155 5757 2555 7452 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10111, 35, CAST(N'2019-07-03T11:14:12.170' AS DateTime), CAST(1567000 AS Decimal(18, 0)), 0, N'Thủ Đức', N'5425 5415 4154 1524 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10113, 21, CAST(N'2019-07-03T19:10:39.390' AS DateTime), CAST(179094 AS Decimal(18, 0)), 0, N'Quận 9', N'3124 2465 4325 3526 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10114, 21, CAST(N'2019-08-03T21:11:14.863' AS DateTime), CAST(179094 AS Decimal(18, 0)), 0, N'Quận 9', N'1232 1231 1231 3123 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10115, 21, CAST(N'2019-12-03T22:12:09.980' AS DateTime), CAST(87120 AS Decimal(18, 0)), 0, N'Quận 9', N'0909 9990 9909 9090 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10116, 44, CAST(N'2019-12-04T08:35:08.063' AS DateTime), CAST(5200 AS Decimal(18, 0)), 0, N'Quận 9', N'1231 1231 3123 2131 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10117, 44, CAST(N'2019-12-04T08:36:11.730' AS DateTime), CAST(244200 AS Decimal(18, 0)), 3, N'Quận 9', N'1231 2312 1232 3123 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10118, 49, CAST(N'2019-12-04T08:54:38.457' AS DateTime), CAST(273000 AS Decimal(18, 0)), 0, N'Quận 9', N'1231 3123 1231 2312 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10119, 48, CAST(N'2019-12-04T09:21:09.137' AS DateTime), CAST(239000 AS Decimal(18, 0)), 1, N'Quận 9', N'1912 3123 1231 3213 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10120, 21, CAST(N'2019-12-06T23:11:12.183' AS DateTime), CAST(691000 AS Decimal(18, 0)), 0, N'Quận 9', N'1231 2312 3123 1231 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10121, 50, CAST(N'2019-09-06T23:36:16.280' AS DateTime), CAST(239000 AS Decimal(18, 0)), 0, N'Quận 9', N'1232 1321 3213 2131 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10122, 57, CAST(N'2019-10-06T23:38:21.183' AS DateTime), CAST(238000 AS Decimal(18, 0)), 0, N'Gò Vấp', N'1232 1231 3213 1231 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10123, 39, CAST(N'2019-10-06T23:39:12.817' AS DateTime), CAST(87120 AS Decimal(18, 0)), 0, N'Quận Thủ Đức', N'1232 1321 3123 1231 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10124, 39, CAST(N'2019-11-06T23:40:14.527' AS DateTime), CAST(34000 AS Decimal(18, 0)), 0, N'484 Lê Văn Việt', N'1213 2131 3123 2131 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10136, 21, CAST(N'2020-03-15T11:12:58.667' AS DateTime), CAST(87120 AS Decimal(18, 0)), 0, N'Quận 9, TP.Hồ Chí Minh', N'1231 2312 3123 1231 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10137, 21, CAST(N'2020-03-16T10:44:09.983' AS DateTime), CAST(213000 AS Decimal(18, 0)), 0, N'Quận 9, TP.Hồ Chí Minh', N'1231 3123 1231 3123 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10138, 1, CAST(N'2020-07-04T15:16:28.003' AS DateTime), CAST(174240 AS Decimal(18, 0)), 0, N'Quận 9', N'1231 3123 1231 3123 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10139, 1, CAST(N'2020-07-04T15:17:32.483' AS DateTime), CAST(326120 AS Decimal(18, 0)), 0, N'Quận 9', N'1111 1111 1111 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10140, 21, CAST(N'2020-07-04T17:12:36.933' AS DateTime), CAST(239000 AS Decimal(18, 0)), 0, N'Quận 9, TP.Hồ Chí Minh', N'1231 3123 1231 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10141, 21, CAST(N'2020-07-04T17:38:37.717' AS DateTime), CAST(213000 AS Decimal(18, 0)), 0, N'Quận 9, TP.Hồ Chí Minh', N'1232 3213 1231 3123 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10142, 21, CAST(N'2020-07-04T17:48:44.833' AS DateTime), CAST(238000 AS Decimal(18, 0)), 0, N'Quận 9, TP.Hồ Chí Minh', N'1231 2312 2131 1111 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10143, 2, CAST(N'2020-07-05T17:45:40.047' AS DateTime), CAST(87120 AS Decimal(18, 0)), 0, N'Đồng Tháp', N'1233 4567 8999 9999 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10144, 2, CAST(N'2020-07-05T18:03:23.197' AS DateTime), CAST(87120 AS Decimal(18, 0)), 0, N'Đồng Tháp', N'1235 5587 8787 8787 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10145, 1, CAST(N'2020-07-06T08:17:59.663' AS DateTime), CAST(300120 AS Decimal(18, 0)), 0, N'Quận 9', N'4444 4444 4444 4444 ')
INSERT [dbo].[Bill] ([BillID], [UserID], [CreateDate], [TotalMoney], [Status], [Address], [CreditCard]) VALUES (10146, 1, CAST(N'2020-07-06T08:21:49.263' AS DateTime), CAST(0 AS Decimal(18, 0)), 0, N'Quận 9', N'5555 5555 5555 5555 ')
SET IDENTITY_INSERT [dbo].[Bill] OFF
SET IDENTITY_INSERT [dbo].[BillDetail] ON 

INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10051, 10101, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10052, 10102, 53, 1, CAST(91974 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10053, 10103, 53, 1, CAST(91974 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10054, 10104, 53, 1, CAST(91974 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10055, 10105, 48, 1, CAST(650000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10056, 10106, 49, 1, CAST(5200 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10057, 10107, 49, 1, CAST(5200 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10058, 10108, 55, 1, CAST(9000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10059, 10109, 46, 2, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10060, 10110, 57, 1, CAST(362000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10061, 10110, 47, 1, CAST(890000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10062, 10111, 58, 2, CAST(134000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10063, 10111, 62, 1, CAST(1299000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10066, 10113, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10067, 10113, 53, 1, CAST(91974 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10068, 10114, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10069, 10114, 53, 1, CAST(91974 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10070, 10115, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10071, 10116, 49, 1, CAST(5200 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10072, 10117, 49, 1, CAST(5200 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10073, 10117, 46, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10074, 10118, 52, 1, CAST(34000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10075, 10118, 46, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10076, 10119, 69, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10077, 10120, 46, 2, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10078, 10120, 45, 1, CAST(213000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10079, 10121, 46, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10080, 10122, 42, 1, CAST(238000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10081, 10123, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10082, 10124, 52, 1, CAST(34000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10093, 10136, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10094, 10137, 45, 1, CAST(213000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10095, 10138, 43, 2, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10096, 10139, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10097, 10139, 46, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10098, 10140, 46, 1, CAST(239000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10099, 10141, 45, 1, CAST(213000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10100, 10142, 42, 1, CAST(238000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10101, 10143, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10102, 10144, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10103, 10145, 43, 1, CAST(87120 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10104, 10145, 45, 1, CAST(213000 AS Decimal(18, 0)))
INSERT [dbo].[BillDetail] ([ID], [BillID], [ProductID], [Quantity], [Price]) VALUES (10105, 10146, 43, 1, CAST(87120 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[BillDetail] OFF
SET IDENTITY_INSERT [dbo].[Cart] ON 

INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10020, 33, 48, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10024, 17, 45, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10025, 17, 43, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10026, 18, 57, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10027, 18, 47, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10030, 35, 62, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10032, 43, 45, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10037, 44, 42, 1)
INSERT [dbo].[Cart] ([CartID], [UserID], [ProductID], [Quantity]) VALUES (10043, 1, 43, 2)
SET IDENTITY_INSERT [dbo].[Cart] OFF
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([ID], [EmpID], [Salary]) VALUES (1, 3, CAST(20000000 AS Decimal(18, 0)))
INSERT [dbo].[Employee] ([ID], [EmpID], [Salary]) VALUES (3, 2, CAST(18000000 AS Decimal(18, 0)))
INSERT [dbo].[Employee] ([ID], [EmpID], [Salary]) VALUES (12, 33, CAST(25000000 AS Decimal(18, 0)))
INSERT [dbo].[Employee] ([ID], [EmpID], [Salary]) VALUES (13, 1, CAST(30000000 AS Decimal(18, 0)))
INSERT [dbo].[Employee] ([ID], [EmpID], [Salary]) VALUES (14, 34, CAST(21000000 AS Decimal(18, 0)))
SET IDENTITY_INSERT [dbo].[Employee] OFF
SET IDENTITY_INSERT [dbo].[FavoriteProduct] ON 

INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10071, 33, 53)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10072, 17, 45)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10073, 18, 47)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10074, 18, 46)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10076, 35, 46)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10077, 35, 48)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10080, 44, 42)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10085, 1, 42)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10086, 1, 45)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10087, 1, 46)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10088, 1, 49)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10089, 1, 43)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10091, 21, 43)
INSERT [dbo].[FavoriteProduct] ([ID], [UserID], [ProductID]) VALUES (10092, 21, 45)
SET IDENTITY_INSERT [dbo].[FavoriteProduct] OFF
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([NotiID], [ContentNotification], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Show]) VALUES (15, N'<p>Giảm 300K khi mua đơn h&agrave;ng tr&ecirc;n 1.500.000 đồng, số lượng c&oacute; hạn!!!</p>
', CAST(N'2019-12-03T10:36:29.777' AS DateTime), N'Trần Anh Hào', CAST(N'2019-12-03T10:36:29.777' AS DateTime), N'Trần Anh Hào', 1)
INSERT [dbo].[Notification] ([NotiID], [ContentNotification], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Show]) VALUES (16, N'<p>Sale 30% tất cả đơn h&agrave;ng tr&ecirc;n 300.000 đồng từ ng&agrave;y 4/12 đến ng&agrave;y 11/12 nhanh tay l&ecirc;n n&agrave;o!!!!</p>
', CAST(N'2019-12-03T10:40:32.123' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-04T09:28:07.173' AS DateTime), N'Trương Thế Ngọc', 1)
INSERT [dbo].[Notification] ([NotiID], [ContentNotification], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Show]) VALUES (19, N'<p>Giảm gi&aacute; l&ecirc;n đến 50% chỉ trong h&ocirc;m nay nhanh tay mua n&agrave;o!!!!!</p>
', CAST(N'2019-12-06T23:15:58.067' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-06T23:15:58.067' AS DateTime), N'Trương Thế Ngọc', 1)
SET IDENTITY_INSERT [dbo].[Notification] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (42, N'Sữa Tươi Vinamilk', N'sua-tuoi-vinamilk', N'sua-tuoi-vinamilk', N'Bộ 12 Lốc 4 Sữa Tươi Tiệt Trùng Vinamilk 100% Có Đường (110ml / Hộp)', N'/Data/files/HangTieuDung/Suatiettrungvinammilk.jpg', CAST(259000 AS Decimal(18, 0)), CAST(238000 AS Decimal(18, 0)), 100, 1, N'<ul>
	<li>Hương vị sữa tươi thơm ngon</li>
	<li>Sữa tươi tiệt tr&ugrave;ng nguy&ecirc;n chất</li>
	<li>Canxi, Phytosterol bảo vệ xương v&agrave; răng</li>
	<li>Cung cấp dưỡng chất tốt cho sức khỏe</li>
	<li>Rất gi&agrave;u canxi</li>
</ul>
', CAST(N'2019-12-02T20:20:01.503' AS DateTime), N'Trương Thế Ngọc', CAST(N'2020-07-06T08:34:25.640' AS DateTime), N'Trương Thế Ngọc', 1, N'model42', 4.5)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (43, N'Lọ tiêu đa năng cao cấp', N'lo-tieu-da-nang-cao-cap', N'lo-tieu-da-nang-cao-cap', N'Lọ Dụng Cụ Xay Tiêu Đa Năng Bằng Inox Cao Cấp', N'/Data/files/HangTieuDung/Lotieu.jpg', CAST(88000 AS Decimal(18, 0)), CAST(87120 AS Decimal(18, 0)), 50, 1, N'<ul>
	<li>Thiết kế nhỏ gọn, l&agrave; vật dụng kh&ocirc;ng thể thiếu trong bếp ăn của người nội trợ.</li>
	<li>Vừa l&agrave; dụng cụ đựng, bảo quản ti&ecirc;u hạt, vừa gi&uacute;p xay nhuyễn nhanh ch&oacute;ng, rắc ti&ecirc;u trực tiếp l&ecirc;n bề mặt m&oacute;n ăn.</li>
	<li>Th&acirc;n thủy tinh trong suốt, nắp inox k&iacute;n đ&aacute;o.</li>
	<li>Dễ d&agrave;ng th&aacute;o rời để vệ sinh sạch sẽ v&agrave; cất đi sau khi sử dụng</li>
</ul>
', CAST(N'2019-12-02T20:22:57.600' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:55:41.447' AS DateTime), N'Trương Thế Ngọc', 1, N'model43', 4.5)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (44, N'Bộ Mỹ Phẩm Dưỡng Ẩm', N'bo-my-pham-duong-am', N'bo-my-pham-duong-am', N'Bộ Mỹ Phẩm Dưỡng Ẩm 8 Món OHUI Miracle Moisture', N'/Data/files/MyPham/BoMyPhamDuongAm.jpg', CAST(3600000 AS Decimal(18, 0)), CAST(3560000 AS Decimal(18, 0)), 60, 24, N'<ul>
	<li>Tăng cường h&agrave;ng r&agrave;o bổ sung độ ẩm cho l&agrave;n da</li>
	<li>Th&agrave;nh phần thi&ecirc;n nhi&ecirc;n, kh&ocirc;ng g&acirc;y k&iacute;ch ứng</li>
	<li>Bảo v&ecirc;̣ làn da khỏi căng thẳng do tác đ&ocirc;̣ng b&ecirc;n ngoài</li>
	<li>B&ocirc;̉ sung &acirc;̉m s&acirc;u b&ecirc;n trong da giúp làn da &acirc;̉m mịn, rạng rỡ</li>
	<li>Bộ bao gồm nước hoa hồng v&agrave; sữa dưỡng ẩm fullsize. Tinh chất dưỡng ẩm, kem dưỡng ẩm, nước hoa hồng, sữa dưỡng ẩm, mặt nạ dưỡng ẩm, tinh chất dưỡng ẩm Sample size</li>
</ul>
', CAST(N'2019-12-02T20:24:26.257' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:09:37.010' AS DateTime), N'Trương Thế Ngọc', 1, N'model44', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (45, N'SỮA CHUA UỐNG SUSU', N'sua-chua-uong-susu', N'sua-chua-uong-susu', N'SỮA CHUA UỐNG SUSU IQ HƯƠNG TÁO NHO', N'/Data/files/HangTieuDung/SuaChuaSuSu.png', CAST(273500 AS Decimal(18, 0)), CAST(213000 AS Decimal(18, 0)), 100, 1, N'<ul>
	<li>Sữa chua uống Vinamilk SuSu IQ mới &ndash; c&ocirc;ng thức đột ph&aacute; Vitamin A gi&uacute;p b&eacute; mắt s&aacute;ng tinh anh, ngo&agrave;i ra c&ograve;n c&oacute; Vitamin B6, B12 v&agrave; chất xơ h&ograve;a tan gi&uacute;p b&eacute; khỏe mạnh v&agrave; năng động mỗi ng&agrave;y.</li>
	<li>Sữa Chua uống Vinamilk SuSu IQ &ndash; S&aacute;ng tr&iacute; tinh anh.</li>
	<li>B&eacute; sẽ th&iacute;ch ngay SuSu IQ với nhiều hương vị tr&aacute;i c&acirc;y chua chua ngọt ngọt thơm m&aacute;t, c&ugrave;ng bao b&igrave; mới cực vui nhộn với nhiều con th&uacute; ngộ nghĩnh.</li>
</ul>
', CAST(N'2019-12-02T20:25:51.063' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:56:22.180' AS DateTime), N'Trương Thế Ngọc', 1, N'model45', 4.5)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (46, N'2 Túi Nước Giặt OMO', N'2-tui-nuoc-giat-omo', N'2-tui-nuoc-giat-omo', N'Combo 2 Túi Nước Giặt OMO Matic Dịu Nhẹ Hương Oải Hương Và Sữa Gạo (2.3kg/Túi)', N'/Data/files/HangTieuDung/NuocXaVai.jpg', CAST(278000 AS Decimal(18, 0)), CAST(239000 AS Decimal(18, 0)), 40, 1, N'<ul>
	<li>Sản phẩm được viện da liễu trung ương kiểm nghiệm v&agrave; chứng nhận</li>
	<li>Th&agrave;nh phần dịu nhẹ với da b&eacute;: kh&ocirc;ng paraben, kh&ocirc;ng chất tẩy trắng, kh&ocirc;ng chất tạo m&agrave;u</li>
	<li>Kết hợp với tinh t&uacute;y thi&ecirc;n nhi&ecirc;n từ: sữa gạo v&agrave; oải hương</li>
	<li>Được thiết kế ph&ugrave; hợp cho giặt tay v&agrave; giặt m&aacute;y giặt cửa tr&ecirc;n</li>
</ul>
', CAST(N'2019-12-02T20:28:49.577' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:57:14.590' AS DateTime), N'Trương Thế Ngọc', 1, N'model46', 5)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (47, N'Khô Gà Lá Chanh Cay', N'kho-ga-la-chanh-cay', N'kho-ga-la-chanh-cay', N'Khô Gà Lá Chanh Cay TeTe 500gram', N'/Data/files/HangTieuDung/KhoGa.png', CAST(199000 AS Decimal(18, 0)), CAST(89000 AS Decimal(18, 0)), 20, 1, N'<p>ĐẶC ĐIỂM NỔI BẬT:</p>

<ul>
	<li>Hương vị thơm ngon đậm đ&agrave;</li>
	<li>Sử dụng ho&agrave;n to&agrave;n thịt g&agrave; tươi, n&oacute;i kh&ocirc;ng với g&agrave; đ&ocirc;ng lạnh.</li>
	<li>Nguồn nguy&ecirc;n liệu sạch,c&oacute; nguồn gốc r&otilde; r&agrave;ng</li>
	<li>C&oacute; giấy chứng nhận của cơ quan c&oacute; thẩm quyền.</li>
</ul>
', CAST(N'2019-12-02T20:30:56.390' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:37:56.063' AS DateTime), N'Trương Thế Ngọc', 1, N'model47', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (48, N'Bộ ấm trà 30 món', N'bo-am-tra-30-mon', N'bo-am-tra-30-mon', N'Bộ ấm trà 30 món họa tiết Ngựa mã đáo thành công- Nghệ thuật trà đạo', N'/Data/files/HangTieuDung/BoAmTra.png', CAST(2250000 AS Decimal(18, 0)), CAST(650000 AS Decimal(18, 0)), 3, 1, N'<ul>
	<li>Nguy&ecirc;n liệu: Đất cao lanh v&agrave; men tr&aacute;ng sứ.</li>
	<li>Tr&agrave; đạo kh&ocirc;ng chỉ đơn thuần l&agrave; ph&eacute;p tắc uống tr&agrave;, m&agrave; c&ograve;n l&agrave; một phương tiện hữu hiệu nhằm l&agrave;m trong sạch t&acirc;m hồn bằng c&aacute;ch h&ograve;a m&igrave;nh với thi&ecirc;n nhi&ecirc;n, từ đ&oacute; tu t&acirc;m dưỡng t&iacute;nh để đạt gi&aacute;c ngộ. Bốn nguy&ecirc;n tắc cơ bản của Tr&agrave; đạo bao gồm H&ograve;a - K&iacute;nh - Thanh - Tịch.</li>
	<li>H&ograve;a c&oacute; nghĩa h&agrave;i h&ograve;a, h&ograve;a hợp, giao h&ograve;a. Đ&oacute; l&agrave; sự h&agrave;i h&ograve;a giữa tr&agrave; nh&acirc;n với tr&agrave; thất, sự h&ograve;a hợp giữa c&aacute;c tr&agrave; nh&acirc;n với nhau, sự h&agrave;i h&ograve;a giữa tr&agrave; nh&acirc;n với c&aacute;c dụng cụ pha tr&agrave;.</li>
	<li>K&iacute;nh l&agrave; l&ograve;ng k&iacute;nh trọng, sự t&ocirc;n k&iacute;nh của tr&agrave; nh&acirc;n với mọi sự vật v&agrave; con người, l&agrave; sự tri &acirc;n cuộc sống. L&ograve;ng k&iacute;nh trọng được nảy sinh khi tinh thần của tr&agrave; nh&acirc;n vươn tới sự h&agrave;i h&ograve;a ho&agrave;n to&agrave;n.</li>
	<li>Thanh l&agrave; khi l&ograve;ng t&ocirc;n k&iacute;nh với vạn vật đạt tới sự kh&ocirc;ng ph&acirc;n biệt th&igrave; tấm l&ograve;ng trở n&ecirc;n thanh thản, y&ecirc;n tĩnh.</li>
	<li>Tịch l&agrave; khi l&ograve;ng thanh thản, y&ecirc;n tĩnh ho&agrave;n to&agrave;n th&igrave; to&agrave;n bộ thế giới trở n&ecirc;n tịch lặng, d&ugrave; sống giữa mu&ocirc;n người cũng như sống giữa nơi am thất vắng vẻ tịch li&ecirc;u. L&uacute;c đ&oacute;, thế giới với con người kh&ocirc;ng c&ograve;n l&agrave; hai, m&agrave; cả hai đều vắng bặt.</li>
	<li>Bộ ấm tr&agrave; 30 m&oacute;n cho bạn một buổi tr&agrave; đạo trọn vẹn b&ecirc;n người th&acirc;n v&agrave; gia đ&igrave;nh.</li>
</ul>
', CAST(N'2019-12-02T20:34:27.450' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:57:43.653' AS DateTime), N'Trương Thế Ngọc', 1, N'model48', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (49, N'Bánh sấy vị rong biển', N'banh-say-vi-rong-bien', N'banh-say-vi-rong-bien', N'Bánh sấy vị rong biển', N'/Data/files/HangTieuDung/BanhXay.jpg', CAST(20000 AS Decimal(18, 0)), CAST(5200 AS Decimal(18, 0)), 50, 1, N'<ul>
	<li>B&aacute;nh sấy gi&ograve;n vị rong biển đủ vị</li>
	<li>Cọng b&aacute;nh gi&ograve;n tan</li>
	<li>L&agrave; một m&oacute;n ăn chơi hay một m&oacute;n đồ nhắm kh&ocirc;ng thể thiếu trong c&aacute;c cuộc vui</li>
</ul>
', CAST(N'2019-12-02T20:39:52.803' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:57:56.003' AS DateTime), N'Trương Thế Ngọc', 1, N'model49', 4.7)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (50, N'Combo Tạp Chí Graphics 5 tập', N'combo-tap-chi-graphics-5-tap', N'combo-tap-chi-graphics-5-tap', N'Combo Tạp Chí Graphics (5 Tập)', N'/Data/files/TapChi_Sach/tapchi5tap.jpg', CAST(735000 AS Decimal(18, 0)), CAST(441000 AS Decimal(18, 0)), 20, 3, N'<h5>COMBO 5 CUỐN GRAPHICS</h5>

<p>Nếu bạn l&agrave; một người đam m&ecirc; thiết kế đồ hoạ, hiếu k&igrave; về những kiến thức xung quanh lĩnh vực n&agrave;y, Graphics l&agrave; một cuốn s&aacute;ch tuyệt vời cho bạn. Đ&acirc;y l&agrave; số đặc biệt đầu ti&ecirc;n của Graphics, với 150 trang giấy, đọc giả sẽ được trải nghiệm rất nhiều c&aacute;c kiến thức th&uacute; vị li&ecirc;n quan đến c&aacute;c chủ đề xoay quanh h&igrave;nh dạng (shape) trong thiết kế. Với hơn 15 b&agrave;i viết đến từ nhiều t&aacute;c giả kh&aacute;c nhau, Graphics c&ugrave;ng bạn chia sẻ những trải nghiệm trong qu&aacute; tr&igrave;nh thiết kế.</p>

<h5>Build the forms</h5>

<p>Khi đang cầm ấn phẩm n&agrave;y tr&ecirc;n tay, chắc hẳn bạn đ&atilde; c&oacute; những h&igrave;nh dung về kh&aacute;i niệm &ldquo;graphic design&rdquo; (thiết kế đồ hoạ) của ri&ecirc;ng m&igrave;nh. Những h&igrave;nh dung đ&oacute; c&oacute; thể tồn tại dưới dạng những trang l&yacute; thuyết, những kiến thức chuy&ecirc;n s&acirc;u về bộ m&ocirc;n n&agrave;y m&agrave; bạn đ&atilde; t&iacute;ch luỹ trong qu&aacute; tr&igrave;nh học tập v&agrave; l&agrave;m việc. Hoặc đơn giản hơn, ch&uacute;ng tồn tại trong c&aacute;ch bạn cảm nhận về vẻ đẹp của một tấm poster, b&igrave;a một cuốn s&aacute;ch, một tấm &aacute;p ph&iacute;ch v&ocirc; t&igrave;nh bắt gặp tr&ecirc;n đường. Bởi lẽ, thiết kế đồ hoạ nằm ở khắp nơi xung quanh bạn. D&ugrave; bạn l&agrave; ai, d&ugrave; bạn đang t&igrave;m kiếm những nguồn cảm hứng, những &yacute; tưởng mới cho t&aacute;c phẩm của m&igrave;nh, hay đơn giản chỉ l&agrave; y&ecirc;u th&iacute;ch v&agrave; muốn t&igrave;m hiểu về lĩnh vực s&aacute;ng tạo n&agrave;y, tạp ch&iacute; Graphics hứa hẹn sẽ l&agrave; người bạn đồng h&agrave;nh th&uacute; vị v&agrave; bổ &iacute;ch của bạn tr&ecirc;n h&agrave;nh tr&igrave;nh đ&oacute;.</p>

<h5>EXPLORE THE SPACE</h5>

<p>Khi đang cầm ấn phẩm n&agrave;y tr&ecirc;n tay, chắc hẳn bạn đ&atilde; c&oacute; những h&igrave;nh dung về kh&aacute;i niệm &ldquo;graphic design&rdquo; (thiết kế đồ hoạ) của ri&ecirc;ng m&igrave;nh. Những h&igrave;nh dung đ&oacute; c&oacute; thể tồn tại dưới dạng những trang l&yacute; thuyết, những kiến thức chuy&ecirc;n s&acirc;u về bộ m&ocirc;n n&agrave;y m&agrave; bạn đ&atilde; t&iacute;ch luỹ trong qu&aacute; tr&igrave;nh học tập v&agrave; l&agrave;m việc. Hoặc đơn giản hơn, ch&uacute;ng tồn tại trong c&aacute;ch bạn cảm nhận về vẻ đẹp của một tấm poster, b&igrave;a một cuốn s&aacute;ch, một tấm &aacute;p ph&iacute;ch v&ocirc; t&igrave;nh bắt gặp tr&ecirc;n đường. Bởi lẽ, thiết kế đồ hoạ nằm ở khắp nơi xung quanh bạn. D&ugrave; bạn l&agrave; ai, d&ugrave; bạn đang t&igrave;m kiếm những nguồn cảm hứng, những &yacute; tưởng mới cho t&aacute;c phẩm của m&igrave;nh, hay đơn giản chỉ l&agrave; y&ecirc;u th&iacute;ch v&agrave; muốn t&igrave;m hiểu về lĩnh vực s&aacute;ng tạo n&agrave;y, tạp ch&iacute; Graphics hứa hẹn sẽ l&agrave; người bạn đồng h&agrave;nh th&uacute; vị v&agrave; bổ &iacute;ch của bạn tr&ecirc;n h&agrave;nh tr&igrave;nh đ&oacute;.</p>
', CAST(N'2019-12-02T20:59:34.057' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:58:17.107' AS DateTime), N'Trương Thế Ngọc', 1, N'model50', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (51, N'Tuyển Tập Tạp Chí Phát Triển Nhân Lực', N'tuyen-tap-tap-chi-phat-trien-nhan-luc', N'tuyen-tap-tap-chi-phat-trien-nhan-luc', N'Tuyển Tập Tạp Chí Phát Triển Nhân Lực', N'/Data/files/TapChi_Sach/tapchiphattriennhanluc.jpg', CAST(220000 AS Decimal(18, 0)), CAST(165000 AS Decimal(18, 0)), 20, 3, N'<p><strong>Tuyển Tập Tạp Ch&iacute; Ph&aacute;t Triển Nh&acirc;n Lực</strong></p>

<p>Cuốn s&aacute;ch bao gồm c&aacute;c c&ocirc;ng tr&igrave;nh nghi&ecirc;n cứu, c&aacute;c b&agrave;i b&aacute;o khoa học của c&aacute;c nh&agrave; l&atilde;nh đạo, c&aacute;c nh&agrave; khoa học v&agrave; quản l&yacute; đ&atilde; được tuyển chọn v&agrave; đăng tr&ecirc;n Tạp ch&iacute; từ năm 2007 đến nay.</p>

<p>N&oacute; được thể hiện theo c&aacute;c chuy&ecirc;n mục: Những vấn đề l&yacute; luận của chủ nghĩa M&aacute;c &ndash; L&ecirc;nin, Tư tưởng v&agrave; tấm gương đạo đức Hồ Ch&iacute; Minh, L&yacute; luận v&agrave; thực tiễn đổi mới đất nước, Ph&aacute;t triển nguồn nh&acirc;n lực phục vụ c&ocirc;ng nghiệp h&oacute;a, hiện đại h&oacute;a&hellip;</p>

<p><strong>&ldquo;Tuyển tập Tạp ch&iacute; Ph&aacute;t triển Nh&acirc;n lực&rdquo;&nbsp;</strong>c&oacute; gi&aacute; trị khoa học v&agrave; mang &yacute; nghĩa l&yacute; luận &ndash; thực tiễn s&acirc;u sắc. N&oacute; kh&ocirc;ng chỉ phản &aacute;nh thế giới quan v&agrave; phương ph&aacute;p luận khoa học của chủ nghĩa M&aacute;c &ndash; L&ecirc;nin trong c&ocirc;ng cuộc đổi mới của Việt Nam h&ocirc;m nay. Cuốn s&aacute;ch l&agrave; tập t&agrave;i liệu khoa học cần thiết v&agrave; bổ &iacute;ch cho c&aacute;c nh&agrave; l&atilde;nh đạo, quản l&yacute;, c&aacute;c nh&agrave; khoa học v&agrave; giảng vi&ecirc;n&hellip;</p>
', CAST(N'2019-12-02T21:06:45.007' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:58:29.897' AS DateTime), N'Trương Thế Ngọc', 1, N'model51', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (52, N'Tam Quốc Diễn Nghĩa - Tập 5', N'tam-quoc-dien-nghia---tap-5', N'tam-quoc-dien-nghia---tap-5', N'Tam Quốc Diễn Nghĩa', N'/Data/files/TapChi_Sach/tam_quoc_dien_nghia_5a.jpg', CAST(45000 AS Decimal(18, 0)), CAST(34000 AS Decimal(18, 0)), 50, 3, N'<p><strong>Tam Quốc Diễn Nghĩa - Tập 5</strong></p>

<p>Tam Quốc Diễn Nghĩa l&agrave; một trong những bộ s&aacute;ch c&oacute; ảnh hưởng s&acirc;u rộng nhất thời xưa, bởi n&oacute; h&agrave;m chứa những chiến lược d&ugrave;ng người, d&ugrave;ng qu&acirc;n, d&ugrave;ng mưu v&agrave; triết l&iacute; sống v&ocirc; c&ugrave;ng s&acirc;u sắc. Bộ truyện tranh Tam Quốc Diễn Nghĩa sử dụng thủ ph&aacute;p truyện tranh hiện đại để phản &aacute;nh một c&aacute;ch ch&acirc;n thực nhất những t&igrave;nh tiết đặc sắc của nguy&ecirc;n t&aacute;c gi&uacute;p độc giả lĩnh hội tầm tr&iacute; tuệ lớn lao của Tam Quốc một c&aacute;ch nhẹ nh&agrave;ng, đơn giản.</p>

<p>Tam Quốc l&agrave; thời đại sinh ra v&ocirc; số nh&acirc;n t&agrave;i. Ở đ&oacute; c&oacute; anh h&ugrave;ng h&agrave;o kiệt, c&oacute; tr&iacute; sĩ mưu thần, c&oacute; những trung thần bỏ m&igrave;nh cứu ch&uacute;a, c&oacute; những m&atilde;nh tướng sức địch mu&ocirc;n người, c&oacute; những cao nh&acirc;n thấu hiểu thời thế&hellip; Họ c&ugrave;ng nhau dựng n&ecirc;n một thi&ecirc;n t&igrave;nh sử thi h&agrave;o h&ugrave;ng, bất hủ.</p>
', CAST(N'2019-12-02T21:13:15.730' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:58:47.510' AS DateTime), N'Trương Thế Ngọc', 1, N'model52', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (53, N' Làm Bạn Với Bầu Trời_Nguyễn Nhật Ánh', N'-lam-ban-voi-bau-troi_nguyen-nhat-anh', N'-lam-ban-voi-bau-troi_nguyen-nhat-anh', N'Làm Bạn Với Bầu Trời ( tặng kèm BOOKMARK HAPPY LIFE)', N'/Data/files/TapChi_Sach/lambanvoibautroi.jpg', CAST(110000 AS Decimal(18, 0)), CAST(91974 AS Decimal(18, 0)), 60, 3, N'<p><strong>L&agrave;m Bạn Với Bầu Trời</strong></p>

<p>Một c&acirc;u chuyện&nbsp; giản dị, chứa đầy bất ngờ cho tới trang cuối c&ugrave;ng. V&agrave; đẹp lộng lẫy, v&igrave; l&ograve;ng vị tha v&agrave; t&igrave;nh y&ecirc;u thương, khiến mắt rưng rưng v&igrave; một nỗi mừng vui h&acirc;n hoan. Cuốn s&aacute;ch như một đốm lửa thắp l&ecirc;n l&ograve;ng kh&aacute;t khao sống tốt tr&ecirc;n đời.</p>

<p>&nbsp;Viết về điều tốt đ&atilde; kh&ocirc;ng dễ, viết sao cho người đọc c&oacute; thể đ&oacute;n nhận đầy cảm x&uacute;c t&iacute;ch cực, v&agrave; muốn&nbsp; được hưởng, được l&agrave;m những điều tốt d&ugrave; nhỏ b&eacute; mới thật l&agrave; kh&oacute;.&nbsp;<em>L&agrave;m bạn với bầu trời</em>&nbsp;của Nguyễn Nhật &Aacute;nh đ&atilde; l&agrave;m được điều n&agrave;y, anh đ&atilde; &ldquo;m&ocirc; tả c&aacute;i tốt thật đẹp để người ta y&ecirc;u th&iacute;ch n&oacute;&rdquo;, như&nbsp; anh&nbsp; từng ph&aacute;t biểu &ldquo; điểm mạnh của văn chương nằm ở khả năng thẩm thấu. Bằng h&igrave;nh thức đặc th&ugrave; của m&igrave;nh, văn chương g&oacute;p phần m&agrave;i sắc c&aacute;c &yacute; niệm đạo đức nơi người đọc một c&aacute;ch v&ocirc; h&igrave;nh. Bồi đắp t&acirc;m hồn v&agrave; nh&acirc;n c&aacute;ch một c&aacute;ch &acirc;m thầm v&agrave; bền bỉ, đ&oacute; l&agrave; chức năng gốc rễ của văn chương, đặc biệt l&agrave; văn chương viết cho thanh thiếu ni&ecirc;n.&rdquo;</p>
', CAST(N'2019-12-02T21:16:28.853' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T22:58:59.083' AS DateTime), N'Trương Thế Ngọc', 1, N'model53', 5)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (54, N'Bộ hộp màu 150 chi tiết', N'bo-hop-mau-150-chi-tiet', N'bo-hop-mau-150-chi-tiet', N'Bộ hộp màu 150 chi tiết', N'/Data/files/VanPhongPham/bomau.jpg', CAST(111000 AS Decimal(18, 0)), CAST(94896 AS Decimal(18, 0)), 20, 2, N'<ul>
	<li>Bộ sản phẩm bao gồm: 24 b&uacute;t dạ, 48 m&agrave;u dầu, 48 m&agrave;u s&aacute;p, 24 m&agrave;u gỗ ,</li>
	<li>12 m&agrave;u nước, 1 cọ vẽ , 1 b&uacute;t ch&igrave; HB, 1 chai keo, 6 gim giấy, 1 tẩy</li>
	<li>1 gọt b&uacute;t ch&igrave;, 1 palet pha m&agrave;u.</li>
	<li>K&iacute;ch thước hộp: 40 x 30 x 4 cm</li>
</ul>
', CAST(N'2019-12-02T23:04:25.750' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T23:04:25.750' AS DateTime), N'Trương Thế Ngọc', 1, N'model54', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (55, N'Sổ Tay Từ Vựng 120 Trang', N'so-tay-tu-vung-120-trang', N'so-tay-tu-vung-120-trang', N'Sổ Tay Từ Vựng 120 Trang (7.6 x 13) - Mẫu Ngẫu Nhiên', N'/Data/files/VanPhongPham/SoTay120Trang.jpg', CAST(19000 AS Decimal(18, 0)), CAST(9000 AS Decimal(18, 0)), 30, 2, N'<ul>
	<li><strong>Sổ Tay Từ Vựng 120 Trang (7.6 x 13) - Mẫu Ngẫu Nhi&ecirc;n</strong>&nbsp;l&agrave; vật dụng cần thiết gi&uacute;p bạn ghi ch&uacute; những th&ocirc;ng tin quan trọng, l&agrave; m&oacute;n qu&agrave; &yacute; nghĩa d&agrave;nh tặng cho người th&acirc;n, bạn b&egrave;.</li>
	<li>Thiết kế sổ gọn nhỏ, dễ d&agrave;ng cho v&agrave;o t&uacute;i x&aacute;ch, ba l&ocirc; để mang theo b&ecirc;n người khi ra ngo&agrave;i.</li>
	<li>Với cuốn sổ xinh xắn n&agrave;y, bạn c&oacute; thể d&ugrave;ng để ghi ch&uacute; c&aacute;c c&ocirc;ng việc, kế hoạch h&agrave;ng ng&agrave;y, l&agrave;m sổ tay, qu&agrave; tặ</li>
	<li>Sản phẩm th&iacute;ch hợp cho nhiều đối tượng sử dụng kh&aacute;c nhau như: học sinh, sinh vi&ecirc;n, nh&acirc;n vi&ecirc;n văn ph&ograve;ng, chủ cửa h&agrave;ng kinh</li>
</ul>
', CAST(N'2019-12-02T23:06:21.090' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T23:06:21.090' AS DateTime), N'Trương Thế Ngọc', 1, N'model55', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (56, N'Túi Đựng Bút', N'tui-dung-but', N'tui-dung-but', N'Túi Đựng Bút viết Zip Unicorn', N'/Data/files/VanPhongPham/tuizip.jpg', CAST(26000 AS Decimal(18, 0)), CAST(9999 AS Decimal(18, 0)), 20, 2, N'<ul>
	<li>T&uacute;i Đựng B&uacute;t viết Zip Unicorn&nbsp;được l&agrave;m từ chất liệu nhựa cao cấp,&nbsp;mềm mại, dễ d&agrave;ng vệ sinh.&nbsp;</li>
	<li>Thiết kế kh&oacute;a k&eacute;o như t&uacute;i zip chắc chắn, trơn tru gi&uacute;p bạn đ&oacute;ng / mở dễ d&agrave;ng, thuận tiện khi sử dụng</li>
	<li>Kiểu d&aacute;ng độc đ&aacute;o&nbsp;n&agrave;y, bạn c&oacute; thể t&ugrave;y &yacute; sắp xếp vật dụng c&aacute; nh&acirc;n của m&igrave;nh một c&aacute;ch gọn g&agrave;ng, ngăn nắp v&agrave; c&ograve;n c&oacute; thể mang theo b&ecirc;n người để sử dụng v&agrave;o bất kỳ l&uacute;c n&agrave;o.</li>
	<li>T&uacute;i đựng b&uacute;t sẽ gi&uacute;p c&aacute;c&nbsp; bạn lưu trữ c&aacute;c dụng cụ học tập, b&eacute; c&oacute; thể dễ d&agrave;ng sử dụng hộp b&uacute;t v&agrave; sử dụng những dụng cụ m&igrave;nh cần.</li>
</ul>
', CAST(N'2019-12-02T23:15:36.763' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T23:16:12.137' AS DateTime), N'Trương Thế Ngọc', 1, N'model56', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (57, N'Máy Tính Học Sinh', N'may-tinh-hoc-sinh', N'may-tinh-hoc-sinh', N'Máy Tính Học Sinh Casio FX-570ES PLUS', N'/Data/files/VanPhongPham/maytinh.jpg', CAST(451000 AS Decimal(18, 0)), CAST(362000 AS Decimal(18, 0)), 60, 2, N'<p><strong>M&aacute;y T&iacute;nh Học Sinh Casio FX-570ES PLUS</strong></p>

<p><strong>Lưu &yacute;: Xuất xứ sản phẩm ở Th&aacute;i Lan, Philippines hay Trung Quốc t&ugrave;y theo từng đợt nhập h&agrave;ng.</strong></p>

<p><strong>M&aacute;y đ&atilde; được&nbsp;<strong>Bộ Gi&aacute;o Dục&nbsp;</strong>cho ph&eacute;p mang v&agrave;o ph&ograve;ng thi.</strong></p>

<p><strong>M&aacute;y T&iacute;nh Học Sinh Casio FX-570ES PLUS</strong>&nbsp;l&agrave; d&ograve;ng m&aacute;y t&iacute;nh mới nhất d&agrave;nh cho học sinh trung học. Năm 2012, Bộ Gi&aacute;o dục đ&atilde; ra c&ocirc;ng văn x&aacute;c nhận m&aacute;y t&iacute;nh Casio fx 570ES PLUS được ph&eacute;p mang v&agrave;o ph&ograve;ng thi. Đ&acirc;y l&agrave; d&ograve;ng&nbsp;m&aacute;y t&iacute;nh Casio được ưa chuộng nhất hiện nay với nhiều t&iacute;nh năng nổi trội, trong đ&oacute; đ&aacute;ng ch&uacute; &yacute; nhất l&agrave; khả năng hiển thị dạng biểu thức v&agrave; căn bật 2 rất ưu việt.</p>
', CAST(N'2019-12-02T23:46:27.260' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-02T23:46:27.260' AS DateTime), N'Trương Thế Ngọc', 1, N'model57', 4.25)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (58, N'Kẻ Trộm Sách', N'ke-trom-sach', N'ke-trom-sach', N'Kẻ Trộm Sách(Tái bản)', N'/Data/files/TapChi_Sach/ketromsach.jpg', CAST(180000 AS Decimal(18, 0)), CAST(134000 AS Decimal(18, 0)), 20, 3, N'<p><em>Kẻ trộm s&aacute;ch</em><em>&nbsp;</em>&ndash; t&aacute;c phẩm của nh&agrave; văn &Uacute;c Markus Zusak xuất bản năm 2005 đ&atilde; l&agrave;m mưa l&agrave;m gi&oacute; tr&ecirc;n bảng xếp hạng những cuốn s&aacute;ch b&aacute;n chạy nhất của&nbsp;<em>The New York Times</em>&nbsp;hơn 100 tuần li&ecirc;n tiếp, trở th&agrave;nh một t&aacute;c phẩm kinh điển, một sự lựa chọn của hệ thống c&aacute;c thư viện trường học của Anh v&agrave; Mỹ.&nbsp;<em>Kẻ trộm s&aacute;ch</em><em>&nbsp;</em>khi mới ra đời đ&atilde; lập tức g&acirc;y ngạc nhi&ecirc;n cho những c&acirc;y b&uacute;t ph&ecirc; b&igrave;nh văn học tr&ecirc;n thế giới v&agrave; l&agrave;m h&agrave;ng triệu cặp mắt phải nh&ograve;a lệ.</p>
', CAST(N'2019-12-03T08:37:34.277' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T08:37:34.277' AS DateTime), N'Trương Thế Ngọc', 1, N'model58', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (59, N'Bộ Mỹ Phẩm Chăm Sóc Da OSM', N'bo-my-pham-cham-soc-da-osm', N'bo-my-pham-cham-soc-da-osm', N'Bộ Mỹ Phẩm Chăm Sóc Da OSM', N'/Data/files/MyPham/BoMyPhamOSM.jpg', CAST(583000 AS Decimal(18, 0)), CAST(520000 AS Decimal(18, 0)), 20, 24, N'<ul>
	<li><strong>Bộ Mỹ Phẩm Chăm S&oacute;c Da OSM&nbsp;</strong>với chiết xuất từ bột ngọc trai thi&ecirc;n nhi&ecirc;n c&ugrave;ng 18 loại axit amin, chứa h&agrave;m lượng dưỡng ẩm phong ph&uacute;, gi&uacute;p cho da lu&ocirc;n được mềm mại, mịn m&agrave;ng v&agrave; trắng s&aacute;ng</li>
	<li>Chiết xuất nh&acirc;n s&acirc;m v&agrave; c&aacute;c th&agrave;nh phần tự nhi&ecirc;n kh&aacute;c, gi&uacute;p tăng cường h&agrave;m lượng SOD của da, th&uacute;c đẩy hiệu quả dưỡng da của bột ngọc trai, mang đến cho da trắng hồng, săn chắc</li>
	<li>Bộ sản phẩm gi&uacute;p cải thiện sắc tố đen, vết th&acirc;m sạm, trả lại cho bạn l&agrave;n da săn chắc, tươi trẻ v&agrave; khỏe mạnh
	<ul>
		<li>Bộ sản phẩm dưỡng ẩm gồm: Sữa rửa mặt ngọc trai 100g, lotion dưỡng ẩm, sữa dưỡng emulsion, kem dưỡng l&agrave;m mềm da 50g, gel dưỡng mắt 15g</li>
		<li>Bộ sản phẩm l&agrave;m trắng gồm: Sữa rửa mặt ngọc trai, lotion dưỡng ẩm, sữa dưỡng emulsion v&agrave; BB cream</li>
	</ul>
	</li>
	<li>L&agrave; bộ qu&agrave; tặng chăm s&oacute;c da mặt tuyệt vời cho ph&aacute;i nữ</li>
</ul>
', CAST(N'2019-12-03T09:17:34.620' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:17:34.620' AS DateTime), N'Trương Thế Ngọc', 1, N'model59', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (60, N'Bộ 2 Hộp Mỹ Phẩm Lipo White ', N'bo-2-hop-my-pham-lipo-white-', N'bo-2-hop-my-pham-lipo-white-', N'Bộ 2 Hộp Mỹ Phẩm Lipo White Trị Nám Tàn Nhang Sạm Đốm Nâu Học Viện Quân Y (30ml)', N'/Data/files/MyPham/myphamlypowhile.jpg', CAST(493900 AS Decimal(18, 0)), CAST(491900 AS Decimal(18, 0)), 98, 24, N'<ul>
	<li><strong>Bộ 2 Hộp Mỹ Phẩm Lipo White Trị N&aacute;m T&agrave;n Nhang Sạm Đốm N&acirc;u Học Viện Qu&acirc;n Y (30ml)&nbsp;</strong>được sản xuất tr&ecirc;n c&ocirc;ng nghệ Liposome&ndash; c&ocirc;ng nghệ sản xuất mỹ phẩm h&agrave;ng đầu H&agrave;n Quốc.</li>
	<li>Với cấu tr&uacute;c lipid k&eacute;p của hạt nano gi&uacute;p l&agrave;m tăng khả năng thẩm thấu s&acirc;u v&agrave;o trong da, x&oacute;a sạch những vết n&aacute;m, t&agrave;n nhang, những đốm th&acirc;m đen, đẩy l&ugrave;i dấu hiệu tuổi t&aacute;c tr&ecirc;n da</li>
	<li>Sản phẩm c&oacute; c&ocirc;ng dụng l&agrave;m s&aacute;ng da, gi&uacute;p trắng da, l&agrave;m mờ sắc tố melanin tr&ecirc;n da; l&agrave;m mờ c&aacute;c v&ugrave;ng da bị n&aacute;m, sạm, t&agrave;n nhang, nhiều đốm n&acirc;u, vết th&acirc;m do mụn để lại v&agrave; dưỡng ẩm, l&agrave;m da mềm mại</li>
</ul>
', CAST(N'2019-12-03T09:24:02.263' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:24:02.263' AS DateTime), N'Trương Thế Ngọc', 1, N'model60', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (61, N'Kem giảm viêm da, kích ứng, dị ứng', N'kem-giam-viem-da,-kich-ung,-di-ung', N'kem-giam-viem-da,-kich-ung,-di-ung', N'Kem giảm viêm da, kích ứng, dị ứng mỹ phẩm Madeleine Ritchie 18+ Active Manuka Honey & Propolis Skin Creme 3ml', N'/Data/files/MyPham/kemchongviemda.jpg', CAST(70000 AS Decimal(18, 0)), CAST(65000 AS Decimal(18, 0)), 20, 24, N'<ul>
	<li>T&igrave;nh trạng: Ch&agrave;m da, vẩy nến, vi&ecirc;m da, k&iacute;ch ứng, dị ứng mỹ phẩm</li>
	<li>Giảm sưng tấy, mẩn đỏ, mẩn ngứa, bong tr&oacute;c da. Th&uacute;c đẩy l&agrave;m l&agrave;nh nhanh c&aacute;c tổn thương da.</li>
	<li>Dưỡng ẩm chuy&ecirc;n biệt d&agrave;nh cho da (Đặc biệt da nhạy cảm v&agrave; kh&ocirc;).Nu&ocirc;i dưỡng v&agrave; phục hồi sức khỏe l&agrave;n da.</li>
	<li>Giảm mụn, hạn chế t&igrave;nh trạng mụn trứng c&aacute;c, mụn vi&ecirc;m, mụn bọc.</li>
	<li>L&agrave;m mờ th&acirc;m mụn, sẹo mụn, phục hồi, t&aacute;i tạo l&agrave;n da sau thương tổn.</li>
	<li>L&agrave;m dịu c&aacute;c vết thương sau laser, dị ứng mỹ phẩm, sưng tấy do c&ocirc;n tr&ugrave;ng đốt&hellip;</li>
	<li>Đặc biệt kem kh&ocirc;ng chứa steroid, mỡ động vật (lanolin), kh&ocirc;ng c&oacute; th&ecirc;m m&agrave;u sắc hay bất kỳ hương liệu n&agrave;o kh&aacute;c.</li>
	<li>Dược t&iacute;nh l&agrave;m l&agrave;nh vết thương đạt hiệu quả cao, k&iacute;ch th&iacute;ch sự t&aacute;i tạo cho l&agrave;n da da. Được c&aacute;c B&aacute;c Sỹ da liễu khuy&ecirc;n d&ugrave;ng.</li>
</ul>
', CAST(N'2019-12-03T09:26:56.377' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:26:56.377' AS DateTime), N'Trương Thế Ngọc', 1, N'model61', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (62, N'Nồi Cơm Điện', N'noi-com-dien', N'noi-com-dien', N'Nồi Cơm Điện Tử Lòng Nồi Niêu Bluestone RCB-5939 (1.5L) - Hàng chính hãng', N'/Data/files/DienGiaDung/noicomdien.jpg', CAST(2199000 AS Decimal(18, 0)), CAST(1299000 AS Decimal(18, 0)), 40, 25, N'<ul>
	<li>C&ocirc;ng suất: 860W</li>
	<li>Dung t&iacute;ch: 1.5L</li>
	<li>L&ograve;ng nồi Ni&ecirc;u: D&agrave;y 1.5 mm</li>
	<li>Trang bị 9 chức năng nấu hiện đại</li>
	<li>Phụ kiện: Mu&ocirc;̃ng, c&ocirc;́c đong, xửng h&acirc;́p</li>
</ul>
', CAST(N'2019-12-03T09:49:20.810' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T09:49:20.810' AS DateTime), N'Trương Thế Ngọc', 1, N'model62', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (64, N'Máy may mini', N'may-may-mini', N'may-may-mini', N'Máy may mini gia đình để bàn có đèn CM202', N'/Data/files/DienGiaDung/maymay.png', CAST(690000 AS Decimal(18, 0)), CAST(161000 AS Decimal(18, 0)), 46, 25, N'<ul>
	<li>M&aacute;y nhỏ gọn, mang đi v&agrave; đặt ở tất cả mọi nơi để may v&aacute; rất tiện dụng</li>
	<li>Sử dụng cả nguồn điện trực tiếp v&agrave; pin n&ecirc;n rất tiện lợi cho bạn ở mọi l&uacute;c mọi nơi đều c&oacute; thể kh&acirc;u v&aacute; những bộ đồ d&ugrave;ng trong gia đ&igrave;nh</li>
	<li>M&aacute;y kh&acirc;u mini FHSM 202 điều chỉnh 2 tốc độ: nhanh &ndash; chậm</li>
	<li>Bạn c&oacute; thể may v&aacute; được hầu hết c&aacute;c loại vải kh&aacute;c nhau.</li>
</ul>
', CAST(N'2019-12-03T10:12:12.020' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T10:12:12.020' AS DateTime), N'Trương Thế Ngọc', 1, N'model64', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (65, N'Ấm Siêu Tốc Inox ', N'am-sieu-toc-inox-', N'am-sieu-toc-inox-', N'Ấm Siêu Tốc Inox Happy Time Sunhouse HTD1081 (1.8 lít)- Hàng chính hãng', N'/Data/files/DienGiaDung/amsieutoc.png', CAST(190000 AS Decimal(18, 0)), CAST(115000 AS Decimal(18, 0)), 22, 25, N'<ul>
	<li>Th&acirc;n ấm xoay 360 độ</li>
	<li>Tự động ngắt khi nước s&ocirc;i</li>
	<li>Quai l&agrave;m bằng nhựa chịu nhiệt si&ecirc;u bền</li>
	<li>Đ&egrave;n b&aacute;o hiệu bật tắt</li>
</ul>
', CAST(N'2019-12-03T10:14:12.220' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T10:14:12.220' AS DateTime), N'Trương Thế Ngọc', 1, N'model65', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (66, N'Táo đỏ Red Delicious', N'tao-do-red-delicious', N'tao-do-red-delicious', N'Táo đỏ Red Delicious nhập khẩu Mỹ hộp 1kg (4 - 5 trái)', N'/Data/files/ThucPham/taodo.jpg', CAST(49000 AS Decimal(18, 0)), CAST(47000 AS Decimal(18, 0)), 150, 26, N'<p>✓ T&aacute;o đỏ&nbsp;nhập khẩu 100% từ Mỹ&nbsp;(<a href="https://www.bachhoaxanh.com/kinh-nghiem-hay/chung-nhan-nhap-khau-cua-tao-do-1175243" style="margin: 0px; padding: 0px; text-decoration: none; color: rgb(40, 138, 214);" target="_blank">Giấy chứng nhận nhập khẩu</a>)</p>

<p>✓ Đạt ti&ecirc;u chuẩn xuất&nbsp;khẩu to&agrave;n cầu</p>

<p>✓ Bảo quản tươi ngon đến tận tay kh&aacute;ch h&agrave;ng</p>

<p>✓ Quả c&oacute; h&igrave;nh lục lăng, vỏ m&agrave;u đỏ đậm đẹp mắt</p>

<p>✓ Thịt t&aacute;o trắng, thơm, thịt t&aacute;o ch&iacute;n &iacute;t bột, gi&ograve;n nhẹ, ngọt thanh,&nbsp;nhiều nước</p>
', CAST(N'2019-12-03T11:42:18.173' AS DateTime), N'Nguyễn Trung Hiếu', CAST(N'2019-12-03T11:51:07.707' AS DateTime), N'Nguyễn Trung Hiếu', 1, N'model66', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (67, N'Nấm hương khô Việt San gói 80g', N'nam-huong-kho-viet-san-goi-80g', N'nam-huong-kho-viet-san-goi-80g', N'Nấm hương khô Việt San gói 80g', N'/Data/files/ThucPham/namkho.jpg', CAST(42000 AS Decimal(18, 0)), CAST(41000 AS Decimal(18, 0)), 50, 26, N'<p>Kh&ocirc;ng c&oacute;</p>
', CAST(N'2019-12-03T11:46:19.703' AS DateTime), N'Nguyễn Trung Hiếu', CAST(N'2019-12-03T11:49:41.443' AS DateTime), N'Nguyễn Trung Hiếu', 1, N'model67', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (68, N'Đậu pinto TMT Foods gói 500g', N'dau-pinto-tmt-foods-goi-500g', N'dau-pinto-tmt-foods-goi-500g', N'Đậu pinto TMT Foods gói 500g', N'/Data/files/ThucPham/dau.jpg', CAST(73000 AS Decimal(18, 0)), CAST(72000 AS Decimal(18, 0)), 20, 26, N'<p>Kh&ocirc;ng c&oacute;</p>
', CAST(N'2019-12-03T11:49:01.537' AS DateTime), N'Nguyễn Trung Hiếu', CAST(N'2019-12-03T11:49:01.537' AS DateTime), N'Nguyễn Trung Hiếu', 1, N'model68', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (69, N'Bàn ủi', N'ban-ui', N'ban-ui', N'Bàn Ủi Electrolux EDI1004 (1300W) - Hàng chính hãng', N'/Data/files/DienGiaDung/banui.png', CAST(290000 AS Decimal(18, 0)), CAST(239000 AS Decimal(18, 0)), 100, 25, N'<p>C&ocirc;ng suất: 1300W</p>

<p>Tay cầm bọc nhựa chắc chắn, tăng độ b&aacute;m khi cầm nắm</p>

<p>Mặt đế bằng th&eacute;p kh&ocirc;ng gỉ, phủ lớp chống d&iacute;nh cao cấp</p>

<p>Thiết kế đầu ủi mũi nhọn, dễ d&agrave;ng di chuyển v&agrave;o những vị tr&iacute; kh&oacute; đến</p>

<p>Khớp d&acirc;y c&oacute; thể xoay 360&deg; linh hoạt v&agrave; cấu tạo d&acirc;y d&agrave;i chống rối</p>

<p>Dễ d&agrave;ng điều nhiệt ph&ugrave; hợp với từng loại vải: cotton, len, lụa, vải lanh, vải nylon</p>
', CAST(N'2019-12-04T09:16:16.090' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-04T09:17:33.100' AS DateTime), N'Trương Thế Ngọc', 1, N'model69', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (70, N'Bánh quy', N'banh-quy', N'banh-quy', N'Bánh quy trứng muối Đài Loan 500g', N'/Data/files/HangTieuDung/banhquy.png', CAST(160000 AS Decimal(18, 0)), CAST(90000 AS Decimal(18, 0)), 100, 1, N'<p>Quy c&aacute;ch: 500g</p>

<p>Xuất xứ: Đ&agrave;i Lo&agrave;n</p>

<p>B&aacute;nh quy trứng muối với vị mặn mặn, gi&ograve;n gi&ograve;n của lớp vỏ b&aacute;nh thơm ngon, b&ecirc;n trong l&agrave; loại kem mạch nha c&oacute; vị trứng muối lạ miệng, hấp dẫn ngay từ những miếng đầu ti&ecirc;n.</p>

<p>Đ&acirc;y l&agrave; sản phẩm b&aacute;nh nhập khẩu cao cấp trực tiếp từ Taiwan.</p>

<p>G&oacute;i b&aacute;nh to 180g gồm 28 c&aacute;i nhỏ b&ecirc;n trong, tiện cho việc sử dụng v&agrave; bảo quản.</p>

<p>B&aacute;nh Quy Trứng Muối Đ&agrave;i Loan c&oacute; chứa th&agrave;nh phần dầu cọ gi&uacute;p b&aacute;nh giữ độ gi&ograve;n rất l&acirc;u, h&agrave;m lượng vitamin A cao trong dầu cọ c&ograve;n tốt cho sức khỏe. Ngo&agrave;i ra, dầu cọ c&ograve;n gi&uacute;p k&eacute;o d&agrave;i độ tươi ngon của b&aacute;nh v&agrave; gi&uacute;p b&aacute;nh giữ độ gi&ograve;n rất l&acirc;u.</p>
', CAST(N'2019-12-04T12:42:22.493' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-04T12:42:22.493' AS DateTime), N'Trương Thế Ngọc', 1, N'model70', NULL)
INSERT [dbo].[Product] ([ProductID], [Name], [BarCode], [MetaTitle], [Descriptions], [Image], [Price], [PromotionPrice], [Quantity], [CategoryID], [Detail], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [PopupID], [RateStar]) VALUES (71, N'Xúc Xích Tulip', N'xuc-xich-tulip', N'xuc-xich-tulip', N'Xúc Xích Tulip Hot Dog Skinless 220g', N'/Data/files/HangTieuDung/xucxich.png', CAST(49000 AS Decimal(18, 0)), CAST(47000 AS Decimal(18, 0)), 100, 26, N'<p>Hương vị thơm ngon, đậm đ&agrave; vị thịt</p>

<p>Nguy&ecirc;n liệu tự nhi&ecirc;n, an to&agrave;n cho người sử dụng</p>

<p>Tiết kiệm thời gian chế biến</p>
', CAST(N'2019-12-04T12:44:08.000' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-04T12:44:08.000' AS DateTime), N'Trương Thế Ngọc', 1, N'model71', NULL)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (1, N'Hàng tiêu dùng', N'hang-tieu-dung', 0, CAST(N'2019-10-11T22:03:51.843' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T11:27:36.103' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (2, N'Văn phòng phẩm', N'van-phong-pham', 4, CAST(N'2019-10-11T22:32:02.043' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T11:27:52.460' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (3, N'Tạp chí và Sách', N'tap-chi-va-sach', 3, CAST(N'2019-10-11T22:32:02.043' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T11:27:47.007' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (24, N'Mỹ phẩm', N'my-pham', 5, CAST(N'2019-12-03T09:09:17.393' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T11:27:58.350' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (25, N'Điện gia dụng', N'dien-gia-dung', 2, CAST(N'2019-12-03T09:44:17.387' AS DateTime), N'Trương Thế Ngọc', CAST(N'2019-12-03T11:27:40.370' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
INSERT [dbo].[ProductCategory] ([CateID], [Name], [MetaTitle], [DisplayOrder], [CreateDate], [CreateBy], [ModifiedDate], [ModifiedBy], [Status], [ShowOnHome]) VALUES (26, N'Thực phẩm', N'thuc-pham', 1, CAST(N'2019-12-03T11:30:37.580' AS DateTime), N'Nguyễn Trung Hiếu', CAST(N'2019-12-03T11:30:37.580' AS DateTime), N'Nguyễn Trung Hiếu', 1, 1)
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
SET IDENTITY_INSERT [dbo].[ProductRate] ON 

INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (9, 33, 53, 5, N'Sản phẩm khá tốt')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (10, 17, 45, 4.5, N'Sản phẩm dùng rất tốt')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (11, 18, 46, 5, N'Sản phẩm rất tốt')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (12, 26, 57, 3.5, N'Sản phẩm dùng tạm ổn, thời gian giao hàng hơi chậm!')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (13, 21, 57, 5, N'Rất tốt')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (14, 21, 42, 4.4, N'Sản phẩm rất tốt')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (15, 44, 42, 4.6, N'Giao hàng nhanh, nhân viên rất nhiệt tình')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (16, 49, 49, 4.7, N'Bánh ngon nhưng hơi ít')
INSERT [dbo].[ProductRate] ([ID], [UserID], [ProductID], [RateStar], [CommentContent]) VALUES (17, 21, 43, 4.5, N'Sản phẩm rất tốt')
SET IDENTITY_INSERT [dbo].[ProductRate] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (1, N'admin', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'ADMIN', N'Trương Thế Ngọc', CAST(N'1990-02-07T00:00:00.000' AS DateTime), 1, N'Quận 9', N'dinhsonhai2701@gmail.com', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (2, N'trana', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'EMP', N'Trần Anh Hào', CAST(N'1999-05-22T00:00:00.000' AS DateTime), 1, N'Đồng Tháp', N'haotran123@gmail.com', N'123584255', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (3, N'huynhgiao', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'EMP', N'Huỳnh Giao An', CAST(N'2001-12-12T00:00:00.000' AS DateTime), 0, N'Quận Thủ Đức', N'user@gmail.com', N'0909000009', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (17, N'truongan', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Trương Ân', CAST(N'2019-10-23T00:00:00.000' AS DateTime), 1, N'Quận 9', N'abc@gmail.com', N'0909009999', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (18, N'nguyenchuong', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Chương', CAST(N'2019-12-08T00:00:00.000' AS DateTime), 1, N'Quận 9', N'chuongnguyen@gmail.com', N'0909000991', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (21, N'sonhai', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Đinh Sơn Hải', CAST(N'1999-05-13T00:00:00.000' AS DateTime), 1, N'Quận 9, TP.Hồ Chí Minh', N'17110290@student.hcmute.edu.vn', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (26, N'ngocgiang', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Ngọc Giang', CAST(N'1990-02-28T00:00:00.000' AS DateTime), 1, N'Quận 9', N'gianggiang@gmail.com', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (33, N'hieunguyen', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Trung Hiếu', CAST(N'1999-05-25T00:00:00.000' AS DateTime), 1, N'Đồng Tháp', N'hieutanmy321@gmail.com', N'0568522555', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (34, N'datle', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'EMP', N'Lê Tấn Đạt123', CAST(N'1999-06-15T00:00:00.000' AS DateTime), 1, N'TP.HCM', N'datle@gmail.com', N'01254488', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (35, N'dantran', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Khánh Dân', CAST(N'1999-06-16T00:00:00.000' AS DateTime), 1, N'Thủ Đức', N'dantran@gmail.com', N'53565658', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (39, N'ngoclong', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Ngọc Long', CAST(N'1999-12-11T00:00:00.000' AS DateTime), 1, N'Quận 9', N'ngoclong@gmail.com', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (40, N'nguyennga', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Tố Nga', CAST(N'1999-12-11T00:00:00.000' AS DateTime), 0, N'Quận 12', N'tonga@gmail.com', N'0912124129', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (41, N'dinhtrong', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Trần Đình Trọng', CAST(N'1987-01-04T00:00:00.000' AS DateTime), 1, N'Quận Thủ Đức', N'trongdinh@gmail.com', N'0998991987', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (42, N'hoaithuong', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Hoài Thương Nhớ', CAST(N'1997-01-01T00:00:00.000' AS DateTime), 0, N'98 Cửu Long', N'thuongnguyen@gmail.com', N'0912912899', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (43, N'nghiadoan', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Đoàn Trung Nghĩa', CAST(N'2009-12-01T00:00:00.000' AS DateTime), 1, N'Quận 9', N'nghiadoan@gmail.com', N'0912912912', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (44, N'truongha', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Trương Thanh Hà', CAST(N'2000-02-09T00:00:00.000' AS DateTime), 0, N'Quận 9', N'truongha@gmail.com', N'0912124129', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (45, N'thevinh', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Trần Thế Vinh', CAST(N'2009-06-25T00:00:00.000' AS DateTime), 1, N'Quận 9', N'thevinh123@gmail.com', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (46, N'domuoi', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Đỗ Mười', CAST(N'2010-07-21T00:00:00.000' AS DateTime), 0, N'Gò Vấp', N'domuoi@gmail.com', N'0123299292', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (47, N'ngochuyen', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Ngọc Huyền Diệu', CAST(N'2005-06-15T00:00:00.000' AS DateTime), 0, N'Quận 9', N'huyenhuyen@gmail.com', N'0123232329', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (48, N'thanhvinh', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Trương Thành Vinh', CAST(N'1999-06-24T00:00:00.000' AS DateTime), 1, N'Quận 9', N'vinhtruong@gmail.com', N'0912312311', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (49, N'thedung', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Hoàng Thế Dũng', CAST(N'2000-07-11T00:00:00.000' AS DateTime), 1, N'Quận 9', N'thedung@gmail.com', N'0123456789', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (50, N'xuandat', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'DAT', CAST(N'2019-12-26T00:00:00.000' AS DateTime), 1, N'HCM', N'17110277@student.hcmute.edu.vn', N'123', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (57, N'ngocthao', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Đỗ Ngọc Thảo', CAST(N'2000-07-13T00:00:00.000' AS DateTime), 0, N'Quận 9', N'ngocthao@gmail.com', N'0988999912', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (58, N'ngocthuy', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Ngọc Thúy', CAST(N'2000-02-23T00:00:00.000' AS DateTime), 0, N'Quận 9', N'gianggiang@gmail.com', N'0989998998', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (59, N'sonhai1234', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Đinh Sơn Hải', CAST(N'2020-03-19T00:00:00.000' AS DateTime), 1, N'Quận 9', N'sonhai1234@gmail.com', N'0123232329', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (60, N'quangsang', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Nguyễn Quang Sáng', CAST(N'1999-07-30T00:00:00.000' AS DateTime), 1, N'Thủ Đức', N'quangsang@gmail.com', N'0337561231', 1)
INSERT [dbo].[User] ([UserID], [UserName], [Password], [GroupID], [Name], [DateOfBirth], [Sex], [Address], [Email], [Phone], [Status]) VALUES (61, N'sonhai1999', N'ba4a7ed22eafaae1327eee4d38c6ba30afff7cc4b71a4d1de3a9ec03f961281d', N'CLIENT', N'Dinh Son Hai', CAST(N'1990-01-04T00:00:00.000' AS DateTime), 1, N'Thủ Đức', N'quangsang@gmail.com', N'0337561231', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[WatchedProduct] ON 

INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10005, 1, 51)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10006, 1, 50)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10007, 1, 53)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10008, 1, 52)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10009, 1, 43)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10010, 1, 42)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10011, 1, 57)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10012, 33, 53)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10013, 33, 44)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10014, 33, 48)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10015, 17, 43)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10016, 17, 45)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10017, 18, 47)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10018, 18, 46)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10019, 2, 57)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10020, 26, 57)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10021, 21, 57)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10022, 35, 46)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10023, 35, 48)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10025, 35, 62)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10026, 21, 42)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10027, 21, 49)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10028, 44, 42)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10029, 49, 49)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10032, 1, 62)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10033, 1, 46)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10034, 1, 45)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10035, 1, 49)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10036, 21, 45)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10037, 21, 43)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10038, 21, 47)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10039, 21, 46)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10040, 21, 70)
INSERT [dbo].[WatchedProduct] ([ID], [UserID], [ProductID]) VALUES (10041, 21, 48)
SET IDENTITY_INSERT [dbo].[WatchedProduct] OFF
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Product__737584F663207771]    Script Date: 7/30/2020 10:38:43 AM ******/
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [UQ__Product__737584F663207771] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__abc__C9F2845692469C42]    Script Date: 7/30/2020 10:38:43 AM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [UQ__abc__C9F2845692469C42] UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Bill] ADD  CONSTRAINT [DF_Bill_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Price]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_PromotionPrice]  DEFAULT ((0)) FOR [PromotionPrice]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Quantity]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Product] ADD  CONSTRAINT [DF_Product_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_CreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductCategory] ADD  CONSTRAINT [DF_ProductCategory_ShowOnHome]  DEFAULT ((1)) FOR [ShowOnHome]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_GroupID_1]  DEFAULT ('CLIENT') FOR [GroupID]
GO
ALTER TABLE [dbo].[Bill]  WITH CHECK ADD  CONSTRAINT [FK_Bill_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Bill] CHECK CONSTRAINT [FK_Bill_User]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Bill] FOREIGN KEY([BillID])
REFERENCES [dbo].[Bill] ([BillID])
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Bill]
GO
ALTER TABLE [dbo].[BillDetail]  WITH CHECK ADD  CONSTRAINT [FK_BillDetail_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[BillDetail] CHECK CONSTRAINT [FK_BillDetail_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_User] FOREIGN KEY([EmpID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_User]
GO
ALTER TABLE [dbo].[FavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[FavoriteProduct] CHECK CONSTRAINT [FK_FavoriteProduct_Product]
GO
ALTER TABLE [dbo].[FavoriteProduct]  WITH CHECK ADD  CONSTRAINT [FK_FavoriteProduct_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FavoriteProduct] CHECK CONSTRAINT [FK_FavoriteProduct_User]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_ProductCategory] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[ProductCategory] ([CateID])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_ProductCategory]
GO
ALTER TABLE [dbo].[ProductRate]  WITH CHECK ADD  CONSTRAINT [FK_ProductRate_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[ProductRate] CHECK CONSTRAINT [FK_ProductRate_Product]
GO
ALTER TABLE [dbo].[ProductRate]  WITH CHECK ADD  CONSTRAINT [FK_ProductRate_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[ProductRate] CHECK CONSTRAINT [FK_ProductRate_User]
GO
ALTER TABLE [dbo].[WatchedProduct]  WITH CHECK ADD  CONSTRAINT [FK_WatchedProduct_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[WatchedProduct] CHECK CONSTRAINT [FK_WatchedProduct_Product]
GO
ALTER TABLE [dbo].[WatchedProduct]  WITH CHECK ADD  CONSTRAINT [FK_WatchedProduct_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[WatchedProduct] CHECK CONSTRAINT [FK_WatchedProduct_User]
GO
USE [master]
GO
ALTER DATABASE [ConvenientStore] SET  READ_WRITE 
GO
