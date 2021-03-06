USE [master]
GO
/****** Object:  Database [MiniSocialNetwork]    Script Date: 12/3/2020 9:21:56 PM ******/
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
/****** Object:  Table [dbo].[Article]    Script Date: 12/3/2020 9:21:56 PM ******/
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
/****** Object:  Table [dbo].[Comment]    Script Date: 12/3/2020 9:21:56 PM ******/
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
/****** Object:  Table [dbo].[Emotion]    Script Date: 12/3/2020 9:21:56 PM ******/
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
/****** Object:  Table [dbo].[Member]    Script Date: 12/3/2020 9:21:56 PM ******/
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
/****** Object:  Table [dbo].[Notification]    Script Date: 12/3/2020 9:21:56 PM ******/
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
SET IDENTITY_INSERT [dbo].[Article] ON 

INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (1, N'abc@abc.abc', N'Lorem Ipsum', N'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vestibulum finibus id neque sit amet dignissim. Fusce sed mi elit. Nullam consectetur blandit ante, in volutpat diam interdum vel. In magna urna, molestie quis elementum nec, commodo maximus sapien. Suspendisse arcu nibh, blandit eget ligula non, condimentum condimentum metus. Sed iaculis posuere magna, eget fringilla lectus. Vivamus suscipit dignissim dui. Aenean malesuada, mauris a pulvinar fermentum, diam ante maximus nisi, ut blandit nisl mi et dolor. Praesent sit amet porta dolor. Ut porttitor sapien augue, sit amet aliquam sem tincidunt ac. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Suspendisse vel faucibus urna. Fusce pellentesque ultricies lorem vitae semper. Nulla laoreet lectus leo, quis efficitur est venenatis eget.', NULL, CAST(N'2020-09-20T00:00:00.000' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (5, N'abc@abc.abc', N'Test1', N'Alo Alo Alo', N'Article5.jpg', CAST(N'2020-09-20T15:30:22.280' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (6, N'abc@abc.abc', N'Test 10', N'Test 10', N'Article6.jpg', CAST(N'2020-09-20T15:31:02.053' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (7, N'abc@abc.abc', N'Today Status', N'I feel sad', NULL, CAST(N'2020-09-20T15:41:04.757' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (8, N'abc@abc.abc', N'Today Status', N'Sad again', NULL, CAST(N'2020-09-20T15:42:33.160' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (13, N'xyz@xyz.xyz', N'Xyz''s article', N'dsfsafdsfasfsf', NULL, CAST(N'2020-09-20T15:46:21.823' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (14, N'xyz@xyz.xyz', N'Hello', N'Sed rutrum at elit sed interdum. Aenean gravida porta eros, in vestibulum dui lacinia at. Proin mollis convallis blandit. Aenean varius ullamcorper ex, at tincidunt tortor tristique eu. Aenean turpis ante, imperdiet sit amet congue vitae, convallis nec neque. Proin porttitor ante at suscipit elementum. Nulla vel nisl a ante tempor bibendum nec sed nulla. In vel mi scelerisque, mattis magna nec, interdum ante. Donec ipsum sem, pellentesque in facilisis vel, rhoncus sagittis nisi. Vivamus cursus dictum augue, sollicitudin rhoncus odio mattis vel.', N'Article14.jpg', CAST(N'2020-09-20T15:46:54.447' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (15, N'xyz@xyz.xyz', N'Ariticle', N'a a a a a aa a  a a a a ', NULL, CAST(N'2020-09-20T15:47:07.893' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (16, N'xyz@xyz.xyz', N'Status', N'Good', NULL, CAST(N'2020-09-20T15:47:18.297' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (17, N'xyz@xyz.xyz', N'Status', N'Ok', N'Article17.jpg', CAST(N'2020-09-20T15:47:20.927' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (18, N'xyz@xyz.xyz', N'Status', N'Best', NULL, CAST(N'2020-09-20T15:47:23.377' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (19, N'xyz@xyz.xyz', N'Title', N'Hate life', N'Article19.jpg', CAST(N'2020-09-20T15:47:25.670' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (20, N'xyz@xyz.xyz', N'555555', N'55555555555', NULL, CAST(N'2020-09-20T15:47:30.597' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (21, N'xyz@xyz.xyz', N'7777777', N'77777777', NULL, CAST(N'2020-09-20T15:47:39.940' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (22, N'xyz@xyz.xyz', N'hello', N'hola', N'Article22.jpg', CAST(N'2020-09-20T15:47:52.177' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (23, N'admin', N'Today Status', N'Today I feel sad', NULL, CAST(N'2020-09-21T07:07:48.950' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (26, N'stever123410@gmail.com', N'Han dep trai', N'<3 Han dep trai', N'Article26.jpg', CAST(N'2020-09-27T20:10:32.373' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (27, N'stever123410@gmail.com', N'123', N'123', N'Article27.jpg', CAST(N'2020-09-27T20:10:53.577' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (28, N'stever123410@gmail.com', N'123', N'123', N'Article28.jpg', CAST(N'2020-09-27T20:11:43.430' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (29, N'abc@abc.abc', N'New Post', N'Chau len Bar chau di mau giao', N'Article29.jpg', CAST(N'2020-09-27T20:59:50.387' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (32, N'abc@abc.abc', N'Article Test', N'Hello', N'Article32.jpg', CAST(N'2020-09-29T22:36:31.623' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (34, N'stever123410@gmail.com', N'test', N'Good Morning', N'Article33.jpg', CAST(N'2020-09-30T00:00:00.000' AS DateTime), N'Delete')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (35, N'abc@abc.abc', N'Ahihi', N'Hihihi', N'Article35.jpg', CAST(N'2020-09-30T15:41:18.873' AS DateTime), N'Active')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (36, N'abc@abc.abc', N'Test', N'Test', N'Article36.jpg', CAST(N'2020-10-01T11:18:37.897' AS DateTime), N'Delete')
INSERT [dbo].[Article] ([articleID], [memberID], [articleTitle], [articleDescription], [articleImage], [articleDate], [articleStatus]) VALUES (37, N'hannqse140027@fpt.edu.vn', N'Test Post', N'sdfsadffsdfasdfsf', N'Article37.jpg', CAST(N'2020-10-06T10:41:00.380' AS DateTime), N'Delete')
SET IDENTITY_INSERT [dbo].[Article] OFF
GO
SET IDENTITY_INSERT [dbo].[Comment] ON 

INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (1, 22, N'abc@abc.abc', N'1', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (2, 22, N'abc@abc.abc', N'Halo Hola', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (3, 23, N'abc@abc.abc', N'Dont be sad :((', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (15, 29, N'lelyuyenphuong9.2@gmail.com', N'yeu yeu', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (16, 29, N'lelyuyenphuong9.2@gmail.com', N'<3', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (17, 28, N'lelyuyenphuong9.2@gmail.com', N'kjj', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (18, 28, N'lelyuyenphuong9.2@gmail.com', N'vhklhk', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (19, 28, N'lelyuyenphuong9.2@gmail.com', N'cgvhjkhkjlh', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (24, 32, N'abc@abc.abc', N'test', 0)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (25, 34, N'abc@abc.abc', N'good morning', 0)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (26, 29, N'hannqse140027@fpt.edu.vn', N'hello', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (27, 35, N'abc@abc.abc', N'alo', 0)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (28, 34, N'hannqse140027@fpt.edu.vn', N'alo', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (29, 35, N'abc@abc.abc', N'sdfsdaf', 0)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (30, 35, N'abc@abc.abc', N'fsdfasdf', 1)
INSERT [dbo].[Comment] ([commentID], [articleID], [memberID], [commentContent], [commentStatus]) VALUES (31, 35, N'abc@abc.abc', N'hhnghjjh', 1)
SET IDENTITY_INSERT [dbo].[Comment] OFF
GO
SET IDENTITY_INSERT [dbo].[Emotion] ON 

INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (8, 23, N'abc@abc.abc', N'dislike')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (12, 22, N'abc@abc.abc', N'dislike')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (14, 18, N'abc@abc.abc', N'dislike')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (15, 32, N'abc@abc.abc', N'like')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (16, 34, N'abc@abc.abc', N'like')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (17, 35, N'stever123410@gmail.com', N'like')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (18, 34, N'stever123410@gmail.com', N'dislike')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (19, 32, N'stever123410@gmail.com', N'like')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (20, 35, N'abc@abc.abc', N'like')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (21, 29, N'hannqse140027@fpt.edu.vn', N'dislike')
INSERT [dbo].[Emotion] ([emotionID], [articleID], [memberID], [emotion]) VALUES (22, 35, N'hannqse140027@fpt.edu.vn', N'like')
SET IDENTITY_INSERT [dbo].[Emotion] OFF
GO
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'abc@abc.abc', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', N'Abc', N'member', N'New')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'admin', N'8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', N'admin', N'admin', N'new')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'hannqse140027@fpt.edu.vn', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', N'Han Quang', N'member', N'New')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'lelyuyenphuong9.2@gmail.com', N'8D969EEF6ECAD3C29A3A629280E686CF0C3F5D5A86AFF3CA12020C923ADC6C92', N'Chincukku', N'member', N'New')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'ngohieuhieu1@gmail.com', N'A295DA364AFFE544D45AFA64AD087FD1480A792765BB08B4C525B3B27A6B3566', N'hieu', N'member', N'New')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'stever123410@gmail.com', N'62E734A5CAED91B11D3509ACA90AFAE0AAF05292FB207232DF5A916BFAADAB54', N'Ngo Tan Duc', N'member', N'New')
INSERT [dbo].[Member] ([memberID], [memberPassword], [memberFullname], [roleName], [memberStatus]) VALUES (N'xyz@xyz.xyz', N'2730E8A5F0B535AAEB0A065C5100502C629CBF2050F0719A4049E6C07F1692CD', N'New Member', N'member', N'New')
GO
SET IDENTITY_INSERT [dbo].[Notification] ON 

INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (11, 16, N'xyz@xyz.xyz', CAST(N'2020-09-27T20:09:05.720' AS DateTime), N'Admin deleted your article with title: 1')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (16, 29, N'abc@abc.abc', CAST(N'2020-09-28T18:01:41.220' AS DateTime), N'lelyuyenphuong9.2@gmail.com commented on your article: yeu yeu')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (17, 29, N'abc@abc.abc', CAST(N'2020-09-28T18:01:47.697' AS DateTime), N'lelyuyenphuong9.2@gmail.com commented on your article: <3')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (18, 28, N'stever123410@gmail.com', CAST(N'2020-09-28T18:04:43.400' AS DateTime), N'lelyuyenphuong9.2@gmail.com commented on your article: kjj')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (19, 28, N'stever123410@gmail.com', CAST(N'2020-09-28T18:04:49.697' AS DateTime), N'lelyuyenphuong9.2@gmail.com commented on your article: vhklhk')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (20, 28, N'stever123410@gmail.com', CAST(N'2020-09-28T18:04:53.723' AS DateTime), N'lelyuyenphuong9.2@gmail.com commented on your article: cgvhjkhkjlh')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (21, 6, N'abc@abc.abc', CAST(N'2020-09-28T19:42:15.083' AS DateTime), N'ngohieuhieu1@gmail.com liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (88, 27, N'stever123410@gmail.com', CAST(N'2020-09-29T22:46:36.240' AS DateTime), N'abc@abc.abc liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (89, 27, N'stever123410@gmail.com', CAST(N'2020-09-29T22:46:37.763' AS DateTime), N'abc@abc.abc disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (90, 27, N'stever123410@gmail.com', CAST(N'2020-09-29T22:46:39.330' AS DateTime), N'abc@abc.abc liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (91, 32, N'abc@abc.abc', CAST(N'2020-09-29T23:00:58.967' AS DateTime), N'Admin deleted your comment: test')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (92, 32, N'admin', CAST(N'2020-09-29T23:00:58.970' AS DateTime), N'You deletedabc@abc.abc''s comment: test')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (96, 34, N'stever123410@gmail.com', CAST(N'2020-09-30T15:39:33.677' AS DateTime), N'abc@abc.abc liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (97, 34, N'stever123410@gmail.com', CAST(N'2020-09-30T15:39:39.997' AS DateTime), N'abc@abc.abc commented on your article: good morning')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (98, 35, N'abc@abc.abc', CAST(N'2020-09-30T15:42:29.060' AS DateTime), N'stever123410@gmail.com liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (99, 32, N'abc@abc.abc', CAST(N'2020-09-30T15:42:34.697' AS DateTime), N'stever123410@gmail.com liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (100, 29, N'abc@abc.abc', CAST(N'2020-10-06T10:40:20.783' AS DateTime), N'hannqse140027@fpt.edu.vn commented on your article: hello')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (101, 29, N'abc@abc.abc', CAST(N'2020-10-06T10:40:24.733' AS DateTime), N'hannqse140027@fpt.edu.vn disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (102, 29, N'abc@abc.abc', CAST(N'2020-10-06T10:40:28.420' AS DateTime), N'hannqse140027@fpt.edu.vn liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (103, 29, N'abc@abc.abc', CAST(N'2020-10-06T10:40:29.460' AS DateTime), N'hannqse140027@fpt.edu.vn disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (104, 34, N'stever123410@gmail.com', CAST(N'2020-10-06T11:03:51.280' AS DateTime), N'hannqse140027@fpt.edu.vn commented on your article: alo')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (105, 35, N'abc@abc.abc', CAST(N'2020-10-13T13:52:34.320' AS DateTime), N'Admin deleted your comment: sdfsdaf')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (106, 35, N'admin', CAST(N'2020-10-13T13:52:34.327' AS DateTime), N'You deleted abc@abc.abc''s comment: sdfsdaf')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (107, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:40.367' AS DateTime), N'hannqse140027@fpt.edu.vn liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (108, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:42.193' AS DateTime), N'hannqse140027@fpt.edu.vn disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (109, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:43.210' AS DateTime), N'hannqse140027@fpt.edu.vn liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (110, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:43.640' AS DateTime), N'hannqse140027@fpt.edu.vn disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (111, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:44.067' AS DateTime), N'hannqse140027@fpt.edu.vn liked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (112, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:46.520' AS DateTime), N'hannqse140027@fpt.edu.vn disliked your article.')
INSERT [dbo].[Notification] ([notificationID], [articleID], [memberID], [notificationDate], [notificationDescription]) VALUES (113, 35, N'abc@abc.abc', CAST(N'2020-12-02T20:24:47.287' AS DateTime), N'hannqse140027@fpt.edu.vn liked your article.')
SET IDENTITY_INSERT [dbo].[Notification] OFF
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
