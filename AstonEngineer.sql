USE [master]
GO
/****** Object:  Database [AstonEngineer]    Script Date: 8/18/2021 11:07:02 AM ******/
CREATE DATABASE [AstonEngineer]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AstonEngineer', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AstonEngineer.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'AstonEngineer_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\AstonEngineer_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [AstonEngineer] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AstonEngineer].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AstonEngineer] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AstonEngineer] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AstonEngineer] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AstonEngineer] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AstonEngineer] SET ARITHABORT OFF 
GO
ALTER DATABASE [AstonEngineer] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AstonEngineer] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [AstonEngineer] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AstonEngineer] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AstonEngineer] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AstonEngineer] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AstonEngineer] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AstonEngineer] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AstonEngineer] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AstonEngineer] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AstonEngineer] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AstonEngineer] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AstonEngineer] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AstonEngineer] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AstonEngineer] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AstonEngineer] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AstonEngineer] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AstonEngineer] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AstonEngineer] SET RECOVERY FULL 
GO
ALTER DATABASE [AstonEngineer] SET  MULTI_USER 
GO
ALTER DATABASE [AstonEngineer] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AstonEngineer] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AstonEngineer] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AstonEngineer] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'AstonEngineer', N'ON'
GO
USE [AstonEngineer]
GO
/****** Object:  StoredProcedure [dbo].[usp_ExecuteClient]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Performs create, update and delete methods for client.
-- =============================================
CREATE PROCEDURE [dbo].[usp_ExecuteClient](
	@ClientId		int = null,
	@ClientName		varchar(100) = null,
	@CreateDate		datetime = null,
	@QueryId		int = 10,
	@ReturnValue	int = null output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto INSERT_ITEM end;
	if(@QueryId = 20) begin goto UPDATE_ITEM end;
	if(@QueryId = 30) begin goto DELETE_ITEM end;

	goto EXIT_SECTION;

--BEGIN: INSERT SECTION
INSERT_ITEM:
	begin
		insert into dbo.Client(
			ClientName,
			CreateDate
		)
		values(
			@ClientName,
			getdate()
		)
		set @ReturnValue = SCOPE_IDENTITY();

		goto EXIT_SECTION;
	end
--END

--BEGIN: UPDATE SECTION
UPDATE_ITEM:
	begin
		update	dbo.Client
		set		ClientName = isNull(@ClientName, ClientName),
				CreateDate = isNULL(@CreateDate, CreateDate)
		where	ClientId = @ClientId;

		set	@ReturnValue = @ClientId;

		goto EXIT_SECTION;
	end
--END

--BEGIN: DELETE SECTION
DELETE_ITEM:
	begin
		delete
		from	dbo.Client
		where	ClientId = @ClientId;

		set	@ReturnValue = @ClientId;

		goto EXIT_SECTION;
	end
--END

--EXIT SECTION
EXIT_SECTION:

END

GO
/****** Object:  StoredProcedure [dbo].[usp_ExecuteEmployee]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Gets a specific client record, or gathers all client records
-- =============================================
CREATE PROCEDURE [dbo].[usp_ExecuteEmployee](
	@EmployeeId		int = null,
	@HireDate		datetime = null,
	@TermDate		datetime = null,
	@BirthDate		datetime = null,
	@PersonId		int = null,
	@QueryId		int = 10,
	@ReturnValue	int = null output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto INSERT_ITEM end;
	if(@QueryId = 20) begin goto UPDATE_ITEM end;
	if(@QueryId = 30) begin goto DELETE_ITEM end;

	goto EXIT_SECTION;

--BEGIN: INSERT SECTION
INSERT_ITEM:
	begin
		insert into dbo.Employee(
			HireDate,
			TermDate,
			BirthDate,
			PersonId
		)
		values(
			@HireDate,
			@TermDate,
			@BirthDate,
			@PersonId
		)
		set @ReturnValue = SCOPE_IDENTITY();

		goto EXIT_SECTION;
	end
--END

--BEGIN: UPDATE SECTION
UPDATE_ITEM:
	begin
		update	dbo.Employee
		set		HireDate = isNull(@HireDate, HireDate),
				TermDate = isNULL(@TermDate, TermDate),
				BirthDate = isNULL(@BirthDate, BirthDate),
				PersonId = isNULL(@PersonId, PersonId)
		where	EmployeeId = @EmployeeId;

		set	@ReturnValue = @EmployeeId;

		goto EXIT_SECTION;
	end
--END

--BEGIN: DELETE SECTION
DELETE_ITEM:
	begin
		delete
		from	dbo.Employee
		where	EmployeeId = @EmployeeId;

		set	@ReturnValue = @EmployeeId;

		goto EXIT_SECTION;
	end
--END

--EXIT SECTION
EXIT_SECTION:

END
GO
/****** Object:  StoredProcedure [dbo].[usp_ExecutePhone]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Gets a specific client record, or gathers all client records
-- =============================================
CREATE PROCEDURE [dbo].[usp_ExecutePhone](
	@PhoneId		int = null,
	@EntityTypeId	int = null,
	@ClientId		int = null,
	@PersonId		int = null,
	@AreaCode		int = null,
	@PhoneNumber		int = null,
	@PhoneNumberPost int=null,
	@QueryId		int = 10,
	@ReturnValue	int = null output
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto INSERT_ITEM end;
	if(@QueryId = 20) begin goto UPDATE_ITEM end;
	if(@QueryId = 30) begin goto DELETE_ITEM end;

	goto EXIT_SECTION;

--BEGIN: INSERT SECTION
INSERT_ITEM:
	begin
		insert into dbo.Phone(
			EntityTypeId,
			ClientId,
			PersonId,
			AreaCode,
			PhoneNumber,
			PhoneNumberPost
		)
		values(
			@EntityTypeId,
			@ClientId,
			@PersonId,
			@AreaCode,
			@PhoneNumber,
			@PhoneNumberPost
		)
		set @ReturnValue = SCOPE_IDENTITY();

		goto EXIT_SECTION;
	end
--END

--BEGIN: UPDATE SECTION
UPDATE_ITEM:
	begin
		update	dbo.Phone
		set		EntityTypeId = isNull(@EntityTypeId, EntityTypeId),
				ClientId = isNULL(@ClientId, ClientId),
				PersonId = isNULL(@PersonId, PersonId),
				AreaCode = isNULL(@AreaCode, AreaCode),
				PhoneNumber = isNULL(@PhoneNumber, PhoneNumber),
				PhoneNumberPost = isNULL(@PhoneNumberPost, PhoneNumberPost)
		where	PhoneId = @PhoneId;

		set	@ReturnValue = @PhoneId;

		goto EXIT_SECTION;
	end
--END

--BEGIN: DELETE SECTION
DELETE_ITEM:
	begin
		delete
		from	dbo.Phone
		where	PhoneId = @PhoneId;

		set	@ReturnValue = @PhoneId;

		goto EXIT_SECTION;
	end
--END

--EXIT SECTION
EXIT_SECTION:

END
GO
/****** Object:  StoredProcedure [dbo].[usp_GetClient]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Gets a specific client record, or gathers all client records
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetClient](
	@ClientId		int = null,
	@QueryId		int = 10			
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;

	goto EXIT_SECTION;

--BEGIN: Get item section
GET_ITEM:
	begin
		select	*
		from	dbo.Client client
		where	client.ClientId = @ClientId;

		goto EXIT_SECTION;
	end
--END: Get item section

--BEGIN: Get client collection
GET_COLLECTION:
	begin
		select		*
		from		dbo.Client client
		order by	client.ClientName;

		goto EXIT_SECTION;
	end
--END: Get client collection

--EXIT
EXIT_SECTION:

END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetEmployee]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Gets a specific client record, or gathers all client records
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetEmployee](
	@EmployeeId		int = null,
	@QueryId		int = 10,
	@PageNumber		int = 1			
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;
	if(@QueryId = 30) begin goto GET_PARTIAL_COLLECTION end;

	goto EXIT_SECTION;

--BEGIN: Get item section
GET_ITEM:
	begin
		select	*
		from	dbo.Employee e
		where	e.EmployeeId = @EmployeeId;

		goto EXIT_SECTION;
	end
--END: Get item section

--BEGIN: Get employee collection
GET_COLLECTION:
	begin
		select		*
		from		dbo.Employee e
		order by	e.EmployeeId;

		goto EXIT_SECTION;
	end
--END: Get employee collection

--BEGIN: Get partial collection
GET_PARTIAL_COLLECTION:
	begin
		with FullTable as (
		select		row_number() over (order by e.EmployeeId asc) as ResultNumber, *
		from		dbo.Employee e
		)
		select * from FullTable
		where	ResultNumber >= (@PageNumber - 1) * 20
		and		ResultNumber < @PageNumber * 20;

		goto EXIT_SECTION;
	end

--END

--EXIT
EXIT_SECTION:

END

GO
/****** Object:  StoredProcedure [dbo].[usp_GetPhone]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Levi Schwartzberg
-- Create date: 8/12/2021
-- Description:	Gets a specific client record, or gathers all client records
-- =============================================
CREATE PROCEDURE [dbo].[usp_GetPhone](
	@PhoneId		int = null,
	@QueryId		int = 10			
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    if(@QueryId = 10) begin goto GET_ITEM end;
	if(@QueryId = 20) begin goto GET_COLLECTION end;

	goto EXIT_SECTION;

--BEGIN: Get item section
GET_ITEM:
	begin
		select	*
		from	dbo.Phone p
		where	p.PhoneId = @PhoneId;

		goto EXIT_SECTION;
	end
--END: Get item section

--BEGIN: Get client collection
GET_COLLECTION:
	begin
		select		*
		from		dbo.Phone p
		order by	p.PhoneId;

		goto EXIT_SECTION;
	end
--END: Get client collection

--EXIT
EXIT_SECTION:

END

GO
/****** Object:  Table [dbo].[Address]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Address](
	[AddressId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NULL,
	[PersonId] [int] NULL,
	[EntityTypeId] [int] NOT NULL,
	[AddressNumber] [varchar](10) NULL,
	[Street] [varchar](100) NULL,
	[Street02] [varchar](100) NULL,
	[City] [varchar](100) NULL,
	[StateId] [int] NULL,
	[CountryId] [int] NULL,
	[DateCreate] [datetime] NULL,
 CONSTRAINT [PK_Address] PRIMARY KEY CLUSTERED 
(
	[AddressId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Client]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Client](
	[ClientId] [int] IDENTITY(1,1) NOT NULL,
	[ClientName] [varchar](100) NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_Client] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ClientContact]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ClientContact](
	[ClientContactId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
 CONSTRAINT [PK_ClientContact] PRIMARY KEY CLUSTERED 
(
	[ClientId] ASC,
	[EntityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Email]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Email](
	[EmailId] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [varchar](50) NOT NULL,
	[EmployeeId] [int] NULL,
	[EntityTypeId] [int] NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[HireDate] [datetime] NULL,
	[TermDate] [datetime] NULL,
	[BirthDate] [datetime] NULL,
	[PersonId] [int] NULL,
 CONSTRAINT [PK_Employee_1] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[EmployeeProject]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EmployeeProject](
	[EmployeeProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[VehicleId] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[Notes] [varchar](8000) NULL,
 CONSTRAINT [PK_EmployeeProject] PRIMARY KEY CLUSTERED 
(
	[EmployeeProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Entity]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Entity](
	[EntityId] [int] IDENTITY(1,1) NOT NULL,
	[EntityName] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[EntityType]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[EntityType](
	[EntityTypeId] [int] IDENTITY(1,1) NOT NULL,
	[EntityTypeName] [varchar](50) NOT NULL,
	[EntityId] [int] NOT NULL,
 CONSTRAINT [PK_EntityType] PRIMARY KEY CLUSTERED 
(
	[EntityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoyaltyAccount]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoyaltyAccount](
	[LoyaltyAccountId] [int] IDENTITY(1,1) NOT NULL,
	[LoyaltyCompanyId] [int] NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[MemberNumber] [varchar](50) NULL,
 CONSTRAINT [PK_LoyaltyAccount] PRIMARY KEY CLUSTERED 
(
	[LoyaltyCompanyId] ASC,
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LoyaltyCompany]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LoyaltyCompany](
	[CompanyName] [varchar](100) NULL,
	[LoyaltyCompanyId] [int] IDENTITY(1,1) NOT NULL,
	[EntityTypeId] [int] NULL,
 CONSTRAINT [PK_LoyaltyCompany] PRIMARY KEY CLUSTERED 
(
	[LoyaltyCompanyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Person]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Person](
	[PersonId] [int] IDENTITY(1,1) NOT NULL,
	[Title] [varchar](5) NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[DisplayFirstName] [varchar](50) NULL,
	[IsDeleted] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Phone]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phone](
	[PhoneId] [int] IDENTITY(1,1) NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[ClientId] [int] NULL,
	[PersonId] [int] NULL,
	[AreaCode] [int] NULL,
	[PhoneNumber] [int] NULL,
	[PhoneNumberPost] [int] NULL,
 CONSTRAINT [PK_Phone] PRIMARY KEY CLUSTERED 
(
	[PhoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Project]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Project](
	[ProjectId] [int] IDENTITY(1,1) NOT NULL,
	[ClientId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[Rate] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
	[ProjectName] [varchar](50) NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ProjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ProjectStatus]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ProjectStatus](
	[ProjectStatusId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[Notes] [varchar](8000) NULL,
	[PercentComplete] [int] NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_ProjectStatus] PRIMARY KEY CLUSTERED 
(
	[ProjectStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Review]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewId] [int] IDENTITY(1,1) NOT NULL,
	[ReviewName] [varchar](100) NOT NULL,
	[ReviewDate] [datetime] NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ReviewData]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ReviewData](
	[ReviewDataId] [int] IDENTITY(1,1) NOT NULL,
	[ReviewId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[ReviewDataValue] [varchar](500) NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_ReviewData] PRIMARY KEY CLUSTERED 
(
	[ReviewId] ASC,
	[EntityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Training]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Training](
	[TrainingId] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[TrainingName] [varchar](500) NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_Training] PRIMARY KEY CLUSTERED 
(
	[TrainingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TrainingData]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TrainingData](
	[TrainingDateId] [int] IDENTITY(1,1) NOT NULL,
	[TrainingId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[TrainingDataValue] [varchar](8000) NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_TrainingData] PRIMARY KEY CLUSTERED 
(
	[TrainingId] ASC,
	[EntityTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Vehicle](
	[VehicleId] [int] IDENTITY(1,1) NOT NULL,
	[Year] [int] NULL,
	[LicensePlate] [varchar](10) NULL,
	[VIN] [varchar](20) NULL,
	[Color] [varchar](10) NULL,
	[IsPurchase] [bit] NULL,
	[PurchasePrice] [int] NULL,
	[PurchaseDate] [datetime] NULL,
	[VehicleModelId] [int] NOT NULL,
 CONSTRAINT [PK_Vehicle] PRIMARY KEY CLUSTERED 
(
	[VehicleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VehicleMake]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VehicleMake](
	[VehicleMakeId] [int] IDENTITY(1,1) NOT NULL,
	[VehicleMakeName] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_VehicleMake] PRIMARY KEY CLUSTERED 
(
	[VehicleMakeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VehicleModel]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VehicleModel](
	[VehicleModelId] [int] IDENTITY(1,1) NOT NULL,
	[VehicleModelName] [varchar](50) NOT NULL,
	[VehicleMakeId] [int] NOT NULL,
 CONSTRAINT [PK_VehicleModel] PRIMARY KEY CLUSTERED 
(
	[VehicleModelId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[VehicleStatus]    Script Date: 8/18/2021 11:07:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[VehicleStatus](
	[VehicleStatusId] [int] IDENTITY(1,1) NOT NULL,
	[VehicleId] [int] NOT NULL,
	[EntityTypeId] [int] NOT NULL,
	[Notes] [varchar](8000) NULL,
	[CreateDate] [datetime] NULL,
 CONSTRAINT [PK_VehicleStatus] PRIMARY KEY CLUSTERED 
(
	[VehicleStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Index [IDX_EmployeeID]    Script Date: 8/18/2021 11:07:02 AM ******/
CREATE NONCLUSTERED INDEX [IDX_EmployeeID] ON [dbo].[Employee]
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [NonClusteredIndex-20210813-132445]    Script Date: 8/18/2021 11:07:02 AM ******/
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210813-132445] ON [dbo].[Employee]
(
	[EmployeeId] ASC,
	[PersonId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Client] ADD  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_ClientId]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_EntityTypeId]
GO
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [FK_Address_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [FK_Address_PersonId]
GO
ALTER TABLE [dbo].[ClientContact]  WITH CHECK ADD  CONSTRAINT [FK_ClientContact_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[ClientContact] CHECK CONSTRAINT [FK_ClientContact_ClientId]
GO
ALTER TABLE [dbo].[ClientContact]  WITH CHECK ADD  CONSTRAINT [FK_ClientContact_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[ClientContact] CHECK CONSTRAINT [FK_ClientContact_EntityTypeId]
GO
ALTER TABLE [dbo].[Email]  WITH CHECK ADD  CONSTRAINT [FK_Email_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Email] CHECK CONSTRAINT [FK_Email_EmployeeId]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_PersonId]
GO
ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_EmployeeId]
GO
ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_EntityTypeId]
GO
ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_ProjectId]
GO
ALTER TABLE [dbo].[EmployeeProject]  WITH CHECK ADD  CONSTRAINT [FK_EmployeeProject_VehicleId] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([VehicleId])
GO
ALTER TABLE [dbo].[EmployeeProject] CHECK CONSTRAINT [FK_EmployeeProject_VehicleId]
GO
ALTER TABLE [dbo].[LoyaltyAccount]  WITH CHECK ADD  CONSTRAINT [FK_LoyaltyAccount_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[LoyaltyAccount] CHECK CONSTRAINT [FK_LoyaltyAccount_EmployeeId]
GO
ALTER TABLE [dbo].[LoyaltyAccount]  WITH CHECK ADD  CONSTRAINT [FK_LoyaltyAccount_LoyaltyCompanyId] FOREIGN KEY([LoyaltyCompanyId])
REFERENCES [dbo].[LoyaltyCompany] ([LoyaltyCompanyId])
GO
ALTER TABLE [dbo].[LoyaltyAccount] CHECK CONSTRAINT [FK_LoyaltyAccount_LoyaltyCompanyId]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_ClientId]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_EntityTypeId]
GO
ALTER TABLE [dbo].[Phone]  WITH CHECK ADD  CONSTRAINT [FK_Phone_PersonId] FOREIGN KEY([PersonId])
REFERENCES [dbo].[Person] ([PersonId])
GO
ALTER TABLE [dbo].[Phone] CHECK CONSTRAINT [FK_Phone_PersonId]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_ClientId] FOREIGN KEY([ClientId])
REFERENCES [dbo].[Client] ([ClientId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_ClientId]
GO
ALTER TABLE [dbo].[Project]  WITH CHECK ADD  CONSTRAINT [FK_Project_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[Project] CHECK CONSTRAINT [FK_Project_EntityTypeId]
GO
ALTER TABLE [dbo].[ProjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_ProjectStatus_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[ProjectStatus] CHECK CONSTRAINT [FK_ProjectStatus_EntityTypeId]
GO
ALTER TABLE [dbo].[ProjectStatus]  WITH CHECK ADD  CONSTRAINT [FK_ProjectStatus_ProjectId] FOREIGN KEY([ProjectId])
REFERENCES [dbo].[Project] ([ProjectId])
GO
ALTER TABLE [dbo].[ProjectStatus] CHECK CONSTRAINT [FK_ProjectStatus_ProjectId]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_EmployeeId]
GO
ALTER TABLE [dbo].[ReviewData]  WITH CHECK ADD  CONSTRAINT [FK_ReviewData_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[ReviewData] CHECK CONSTRAINT [FK_ReviewData_EntityTypeId]
GO
ALTER TABLE [dbo].[ReviewData]  WITH CHECK ADD  CONSTRAINT [FK_ReviewData_ReviewId] FOREIGN KEY([ReviewId])
REFERENCES [dbo].[Review] ([ReviewId])
GO
ALTER TABLE [dbo].[ReviewData] CHECK CONSTRAINT [FK_ReviewData_ReviewId]
GO
ALTER TABLE [dbo].[Training]  WITH CHECK ADD  CONSTRAINT [FK_Training_EmployeeId] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Training] CHECK CONSTRAINT [FK_Training_EmployeeId]
GO
ALTER TABLE [dbo].[TrainingData]  WITH CHECK ADD  CONSTRAINT [FK_TrainingData_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[TrainingData] CHECK CONSTRAINT [FK_TrainingData_EntityTypeId]
GO
ALTER TABLE [dbo].[TrainingData]  WITH CHECK ADD  CONSTRAINT [FK_TrainingData_TrainingId] FOREIGN KEY([TrainingId])
REFERENCES [dbo].[Training] ([TrainingId])
GO
ALTER TABLE [dbo].[TrainingData] CHECK CONSTRAINT [FK_TrainingData_TrainingId]
GO
ALTER TABLE [dbo].[Vehicle]  WITH CHECK ADD  CONSTRAINT [FK_Vehicle_VehicleModelId] FOREIGN KEY([VehicleModelId])
REFERENCES [dbo].[VehicleModel] ([VehicleModelId])
GO
ALTER TABLE [dbo].[Vehicle] CHECK CONSTRAINT [FK_Vehicle_VehicleModelId]
GO
ALTER TABLE [dbo].[VehicleModel]  WITH CHECK ADD  CONSTRAINT [FK_VehicleModel_VehicleMakeId] FOREIGN KEY([VehicleMakeId])
REFERENCES [dbo].[VehicleMake] ([VehicleMakeId])
GO
ALTER TABLE [dbo].[VehicleModel] CHECK CONSTRAINT [FK_VehicleModel_VehicleMakeId]
GO
ALTER TABLE [dbo].[VehicleStatus]  WITH CHECK ADD  CONSTRAINT [FK_VehicleStatus_EntityTypeId] FOREIGN KEY([EntityTypeId])
REFERENCES [dbo].[EntityType] ([EntityTypeId])
GO
ALTER TABLE [dbo].[VehicleStatus] CHECK CONSTRAINT [FK_VehicleStatus_EntityTypeId]
GO
ALTER TABLE [dbo].[VehicleStatus]  WITH CHECK ADD  CONSTRAINT [FK_VehicleStatus_VehicleId] FOREIGN KEY([VehicleId])
REFERENCES [dbo].[Vehicle] ([VehicleId])
GO
ALTER TABLE [dbo].[VehicleStatus] CHECK CONSTRAINT [FK_VehicleStatus_VehicleId]
GO
USE [master]
GO
ALTER DATABASE [AstonEngineer] SET  READ_WRITE 
GO
