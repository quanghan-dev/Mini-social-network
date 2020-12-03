USE [master]
GO
/****** Object:  Database [MiniSocialNetwork]    Script Date: 12/3/2020 8:58:13 PM ******/
CREATE DATABASE [MiniSocialNetwork]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MiniSocialNetwork', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MiniSocialNetwork_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\MiniSocialNetwork_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [MiniSocialNetwork] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MiniSocialNetwork].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ARITHABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MiniSocialNetwork] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MiniSocialNetwork] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MiniSocialNetwork] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [MiniSocialNetwork] SET  MULTI_USER 
GO
ALTER DATABASE [MiniSocialNetwork] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MiniSocialNetwork] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MiniSocialNetwork] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MiniSocialNetwork] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MiniSocialNetwork] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MiniSocialNetwork] SET QUERY_STORE = OFF
GO
USE [MiniSocialNetwork]
GO
/****** Object:  Table [dbo].[Article]    Script Date: 12/3/2020 8:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Article](
	[articleID] [int] IDENTITY(1,1) NOT NULL,
	[memberID] [varchar](50) NOT NULL,
	[articleTitle] [varchar](100) NOT NULL,
	[articleDescription] [nvarchar](max) NOT NULL,
	[articleImage] [nvarchar](max) NULL,
	[articleDate] [datetime] NOT NULL,
	[articleStatus] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[articleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comment]    Script Date: 12/3/2020 8:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comment](
	[commentID] [int] IDENTITY(1,1) NOT NULL,
	[articleID] [int] NOT NULL,
	[memberID] [varchar](50) NOT NULL,
	[commentContent] [nvarchar](max) NOT NULL,
	[commentStatus] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[commentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Emotion]    Script Date: 12/3/2020 8:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Emotion](
	[emotionID] [int] IDENTITY(1,1) NOT NULL,
	[articleID] [int] NOT NULL,
	[memberID] [varchar](50) NOT NULL,
	[emotion] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[emotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Member]    Script Date: 12/3/2020 8:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Member](
	[memberID] [varchar](50) NOT NULL,
	[memberPassword] [varchar](100) NOT NULL,
	[memberFullname] [nvarchar](100) NOT NULL,
	[roleName] [varchar](100) NOT NULL,
	[memberStatus] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[memberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notification]    Script Date: 12/3/2020 8:58:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notification](
	[notificationID] [int] IDENTITY(1,1) NOT NULL,
	[articleID] [int] NOT NULL,
	[memberID] [varchar](50) NOT NULL,
	[notificationDate] [datetime] NOT NULL,
	[notificationDescription] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[notificationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Article]  WITH CHECK ADD FOREIGN KEY([memberID])
REFERENCES [dbo].[Member] ([memberID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([articleID])
REFERENCES [dbo].[Article] ([articleID])
GO
ALTER TABLE [dbo].[Comment]  WITH CHECK ADD FOREIGN KEY([memberID])
REFERENCES [dbo].[Member] ([memberID])
GO
ALTER TABLE [dbo].[Emotion]  WITH CHECK ADD FOREIGN KEY([articleID])
REFERENCES [dbo].[Article] ([articleID])
GO
ALTER TABLE [dbo].[Emotion]  WITH CHECK ADD FOREIGN KEY([memberID])
REFERENCES [dbo].[Member] ([memberID])
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD FOREIGN KEY([articleID])
REFERENCES [dbo].[Article] ([articleID])
GO
ALTER TABLE [dbo].[Notification]  WITH CHECK ADD FOREIGN KEY([memberID])
REFERENCES [dbo].[Member] ([memberID])
GO
USE [master]
GO
ALTER DATABASE [MiniSocialNetwork] SET  READ_WRITE 
GO
