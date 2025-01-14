USE [master]
GO
/****** Object:  Database [Pluto]    Script Date: 3.9.2024 г. 18:49:17 ******/
CREATE DATABASE [Pluto]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Pluto', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Pluto.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Pluto_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\Pluto_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Pluto] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Pluto].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Pluto] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Pluto] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Pluto] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Pluto] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Pluto] SET ARITHABORT OFF 
GO
ALTER DATABASE [Pluto] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Pluto] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Pluto] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Pluto] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Pluto] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Pluto] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Pluto] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Pluto] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Pluto] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Pluto] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Pluto] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Pluto] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Pluto] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Pluto] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Pluto] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Pluto] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Pluto] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Pluto] SET RECOVERY FULL 
GO
ALTER DATABASE [Pluto] SET  MULTI_USER 
GO
ALTER DATABASE [Pluto] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Pluto] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Pluto] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Pluto] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Pluto] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Pluto] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Pluto', N'ON'
GO
ALTER DATABASE [Pluto] SET QUERY_STORE = ON
GO
ALTER DATABASE [Pluto] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Pluto]
GO
/****** Object:  Table [dbo].[Courses]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Courses](
	[CourseID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorID] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Description] [varchar](8000) NOT NULL,
	[Price] [smallint] NOT NULL,
	[LevelString] [varchar](50) NOT NULL,
	[Level] [tinyint] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[funcGetAuthorCourses]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[funcGetAuthorCourses]
(
	@AuthorID int	
)
RETURNS TABLE 
AS
RETURN 
(
	SELECT * FROM Courses WHERE AuthorID = @AuthorID 
)

GO
/****** Object:  Table [dbo].[Authors]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Authors](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Authors] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseSections]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseSections](
	[SectionID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NOT NULL,
	[Title] [varchar](255) NOT NULL,
 CONSTRAINT [PK_Sections] PRIMARY KEY CLUSTERED 
(
	[SectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CourseTags]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CourseTags](
	[CourseID] [int] NOT NULL,
	[TagID] [int] NOT NULL,
 CONSTRAINT [PK_CourseTags] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC,
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Posts]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Posts](
	[PostID] [int] NOT NULL,
	[DatePublished] [smalldatetime] NOT NULL,
	[Title] [varchar](255) NOT NULL,
	[Body] [varchar](8000) NOT NULL,
 CONSTRAINT [PK_Posts] PRIMARY KEY CLUSTERED 
(
	[PostID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[TagID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[TagID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUser](
	[UserID] [int] NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[Password] [int] NOT NULL,
 CONSTRAINT [PK_tblUser] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Authors] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Authors] ([AuthorID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_Authors]
GO
ALTER TABLE [dbo].[CourseSections]  WITH CHECK ADD  CONSTRAINT [FK_CourseSections_Courses] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseSections] CHECK CONSTRAINT [FK_CourseSections_Courses]
GO
ALTER TABLE [dbo].[CourseTags]  WITH CHECK ADD  CONSTRAINT [FK_CourseTags_Courses] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Courses] ([CourseID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseTags] CHECK CONSTRAINT [FK_CourseTags_Courses]
GO
ALTER TABLE [dbo].[CourseTags]  WITH CHECK ADD  CONSTRAINT [FK_CourseTags_Tags] FOREIGN KEY([TagID])
REFERENCES [dbo].[Tags] ([TagID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[CourseTags] CHECK CONSTRAINT [FK_CourseTags_Tags]
GO
/****** Object:  StoredProcedure [dbo].[DeleteCourse]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[DeleteCourse] 
(
	@CourseID int
)
AS
	DELETE FROM Courses
	WHERE CourseID = @CourseID

GO
/****** Object:  StoredProcedure [dbo].[GetCourses]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[GetCourses] 
AS
	SELECT * FROM Courses 
GO
/****** Object:  StoredProcedure [dbo].[InsertCourse]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[InsertCourse]
(
	@AuthorID int,
	@Title varchar(255),
	@Description varchar(8000),
	@Price smallint,
	@LevelString varchar(50),
	@Level tinyint
)
AS 

INSERT INTO [dbo].[Courses]
           (
		    [AuthorID]
		   ,[Title]
           ,[Description]
           ,[Price]
           ,[LevelString]
           ,[Level])
     VALUES
		(
		@AuthorID,
		@Title,
		@Description,
		@Price,
		@LevelString,
		@Level)
           

GO
/****** Object:  StoredProcedure [dbo].[UpdateCourse]    Script Date: 3.9.2024 г. 18:49:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[UpdateCourse]
(
	@CourseID int,
	@Title varchar(255),
	@Description varchar(8000),
	@LevelString varchar(50),
	@Level tinyint
)
AS 
	UPDATE Courses
	SET 
		Title = @Title,
		Description = @Description,
		LevelString = @LevelString,
		Level = @Level
	WHERE CourseID = @CourseID 
GO
USE [master]
GO
ALTER DATABASE [Pluto] SET  READ_WRITE 
GO
