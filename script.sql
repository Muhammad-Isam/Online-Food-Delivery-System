GO
	create function [dbo].[getReservedUserID]
				(@username varchar(25))
				returns int
		as
		begin
		declare @UserID int;
		select top 1 @UserID=u.UserID
		from Reservation r, [User] u
		where Username=@username AND u.UserID=r.UserID
		order by ReservationID desc
		return @UserID
		end
GO
/****** Object:  UserDefinedFunction [dbo].[getUserReservationID]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create function [dbo].[getUserReservationID]
		(@username varchar(25))
		returns int
		as
		begin
		declare @ResID int;
		select top 1 @ResID=ReservationID from Reservation r, [User] u
		where Username=@username AND u.UserID=r.UserID
		order by ReservationID desc
		return @ResID
		end
GO
/****** Object:  Table [dbo].[Feedback]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [int] IDENTITY(1,1) NOT NULL,
	[ReservationID] [int] NULL,
	[Date] [datetime] NULL,
	[Comment] [varchar](50) NULL,
	[Rating] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FeedbackID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[Email] [varchar](25) NULL,
	[Password] [varchar](25) NULL,
	[Role] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Reservation]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservation](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[VehiclePlate] [varchar](25) NULL,
	[LotID] [int] NULL,
	[SpaceID] [int] NULL,
	[ParkDate] [date] NULL,
	[ParkTime] [time](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getFeedback]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	   create function [dbo].[getFeedback]()
		returns table
		as
		return (Select (FirstName+' '+LastName)'Name', Comment from Feedback f, [User] u, Reservation r
		where f.ReservationID=r.ReservationID AND u.UserID=r.ReservationID)
GO
/****** Object:  UserDefinedFunction [dbo].[getUserFeedback]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		create function [dbo].[getUserFeedback]
		(@username varchar(25))
		returns table
		as
		return
		(select top 1 ReservationID from Reservation r, [User] u
		where Username=@username AND u.UserID=r.UserID
		order by ReservationID desc)
GO
/****** Object:  View [dbo].[viewReservations]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
		create view [dbo].[viewReservations]
		as
		select ReservationID, (FirstName+' '+LastName)'Name',VehiclePlate,LotID,SpaceID,ParkDate,ParkTime
		from Reservation r, [User] u
		where r.userID=u.UserID
GO
/****** Object:  Table [dbo].[SubscriptionCategory]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubscriptionCategory](
	[SubID] [int] IDENTITY(1,1) NOT NULL,
	[SubCategory] [varchar](25) NULL,
	[HourlyRate] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[SubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[viewSubCats]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	   create view [dbo].[viewSubCats]
	   as
	   select distinct SubCategory
	   from SubscriptionCategory
GO
/****** Object:  Table [dbo].[ParkingLot]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParkingLot](
	[LotID] [int] IDENTITY(1,1) NOT NULL,
	[SubID] [int] NULL,
	[Capacity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[LotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParkingSpace]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParkingSpace](
	[SpaceID] [int] NOT NULL,
	[LotID] [int] NULL,
	[LotName] [varchar](25) NULL,
PRIMARY KEY CLUSTERED 
(
	[SpaceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[ReservationID] [int] NULL,
	[ExitTime] [time](7) NULL,
	[Date] [date] NULL,
	[TotalAmount] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vehicle]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle](
	[VehicleID] [int] IDENTITY(1,1) NOT NULL,
	[LicensePlate] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VehicleOwner]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VehicleOwner](
	[VehicleID] [int] NULL,
	[UserID] [int] NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Feedback] ON 

INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (1, 1, CAST(N'2024-01-10T09:30:00.000' AS DateTime), N'Good service!', 4)
INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (2, 2, CAST(N'2024-01-11T11:45:00.000' AS DateTime), N'Satisfactory.', 3)
INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (3, 3, CAST(N'2024-01-12T13:15:00.000' AS DateTime), N'Excellent experience!', 5)
INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (4, 4, CAST(N'2024-01-13T15:30:00.000' AS DateTime), N'Not happy with the service.', 1)
INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (5, 5, CAST(N'2024-01-14T17:45:00.000' AS DateTime), N'Highly recommended!', 5)
INSERT [dbo].[Feedback] ([FeedbackID], [ReservationID], [Date], [Comment], [Rating]) VALUES (6, 5, CAST(N'2024-01-05T21:02:01.567' AS DateTime), N'LUMBER1', 5)
SET IDENTITY_INSERT [dbo].[Feedback] OFF
GO
SET IDENTITY_INSERT [dbo].[ParkingLot] ON 

INSERT [dbo].[ParkingLot] ([LotID], [SubID], [Capacity]) VALUES (1, 1, 20)
INSERT [dbo].[ParkingLot] ([LotID], [SubID], [Capacity]) VALUES (2, 2, 30)
INSERT [dbo].[ParkingLot] ([LotID], [SubID], [Capacity]) VALUES (3, 3, 40)
SET IDENTITY_INSERT [dbo].[ParkingLot] OFF
GO
INSERT [dbo].[ParkingSpace] ([SpaceID], [LotID], [LotName]) VALUES (1, 1, N'Lot A')
INSERT [dbo].[ParkingSpace] ([SpaceID], [LotID], [LotName]) VALUES (2, 2, N'Lot B')
INSERT [dbo].[ParkingSpace] ([SpaceID], [LotID], [LotName]) VALUES (3, 3, N'Lot C')
GO
SET IDENTITY_INSERT [dbo].[Reservation] ON 

INSERT [dbo].[Reservation] ([ReservationID], [UserID], [VehiclePlate], [LotID], [SpaceID], [ParkDate], [ParkTime]) VALUES (1, 3, N'1', 1, 1, CAST(N'2024-01-10' AS Date), CAST(N'09:30:00' AS Time))
INSERT [dbo].[Reservation] ([ReservationID], [UserID], [VehiclePlate], [LotID], [SpaceID], [ParkDate], [ParkTime]) VALUES (2, 4, N'2', 2, 2, CAST(N'2024-01-11' AS Date), CAST(N'11:45:00' AS Time))
INSERT [dbo].[Reservation] ([ReservationID], [UserID], [VehiclePlate], [LotID], [SpaceID], [ParkDate], [ParkTime]) VALUES (3, 5, N'3', 3, 3, CAST(N'2024-01-12' AS Date), CAST(N'13:15:00' AS Time))
INSERT [dbo].[Reservation] ([ReservationID], [UserID], [VehiclePlate], [LotID], [SpaceID], [ParkDate], [ParkTime]) VALUES (4, 6, N'4', 3, 3, CAST(N'2024-01-13' AS Date), CAST(N'15:30:00' AS Time))
INSERT [dbo].[Reservation] ([ReservationID], [UserID], [VehiclePlate], [LotID], [SpaceID], [ParkDate], [ParkTime]) VALUES (5, 7, N'5', 3, 3, CAST(N'2024-01-14' AS Date), CAST(N'17:45:00' AS Time))
SET IDENTITY_INSERT [dbo].[Reservation] OFF
GO
SET IDENTITY_INSERT [dbo].[SubscriptionCategory] ON 

INSERT [dbo].[SubscriptionCategory] ([SubID], [SubCategory], [HourlyRate]) VALUES (1, N'Gold', CAST(25.00 AS Decimal(10, 2)))
INSERT [dbo].[SubscriptionCategory] ([SubID], [SubCategory], [HourlyRate]) VALUES (2, N'Silver', CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[SubscriptionCategory] ([SubID], [SubCategory], [HourlyRate]) VALUES (3, N'Platinum', CAST(35.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[SubscriptionCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionID], [UserID], [ReservationID], [ExitTime], [Date], [TotalAmount]) VALUES (2, 3, 1, CAST(N'11:45:00' AS Time), CAST(N'2024-01-10' AS Date), CAST(12.50 AS Decimal(10, 2)))
INSERT [dbo].[Transaction] ([TransactionID], [UserID], [ReservationID], [ExitTime], [Date], [TotalAmount]) VALUES (3, 4, 2, CAST(N'13:15:00' AS Time), CAST(N'2024-01-11' AS Date), CAST(18.75 AS Decimal(10, 2)))
INSERT [dbo].[Transaction] ([TransactionID], [UserID], [ReservationID], [ExitTime], [Date], [TotalAmount]) VALUES (4, 5, 3, CAST(N'15:30:00' AS Time), CAST(N'2024-01-12' AS Date), CAST(15.00 AS Decimal(10, 2)))
INSERT [dbo].[Transaction] ([TransactionID], [UserID], [ReservationID], [ExitTime], [Date], [TotalAmount]) VALUES (5, 6, 4, CAST(N'17:45:00' AS Time), CAST(N'2024-01-13' AS Date), CAST(10.50 AS Decimal(10, 2)))
INSERT [dbo].[Transaction] ([TransactionID], [UserID], [ReservationID], [ExitTime], [Date], [TotalAmount]) VALUES (6, 7, 5, CAST(N'19:00:00' AS Time), CAST(N'2024-01-14' AS Date), CAST(25.00 AS Decimal(10, 2)))
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (1, N'Emad', N'Emad', N'Tariq', N'emad@gmail.com', N'abc', N'Admin')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (2, N'Sofia123', N'Sofia', N'Haider', N'sofia@gmail.com', N'sofia789', N'Admin')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (3, N'ahsan1', N'Ahsan', N'Naeem', N'Ahsan@gmail.com', N'ahsan789', N'User')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (4, N'SophieM', N'Sophie', N'Miller', N'sophie.miller@example.com', N'sophie123', N'User')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (5, N'RyanK', N'Ryan', N'Khan', N'ryan.khan@example.com', N'ryan456', N'User')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (6, N'EmmaC', N'Emma', N'Clark', N'emma.clark@example.com', N'emma789', N'User')
INSERT [dbo].[User] ([UserID], [Username], [FirstName], [LastName], [Email], [Password], [Role]) VALUES (7, N'LilyR', N'Lily', N'Roberts', N'lily.roberts@example.com', N'lily789', N'User')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET IDENTITY_INSERT [dbo].[Vehicle] ON 

INSERT [dbo].[Vehicle] ([VehicleID], [LicensePlate]) VALUES (1, N'ABC123')
INSERT [dbo].[Vehicle] ([VehicleID], [LicensePlate]) VALUES (2, N'XYZ789')
INSERT [dbo].[Vehicle] ([VehicleID], [LicensePlate]) VALUES (3, N'DEF456')
INSERT [dbo].[Vehicle] ([VehicleID], [LicensePlate]) VALUES (4, N'GHI789')
INSERT [dbo].[Vehicle] ([VehicleID], [LicensePlate]) VALUES (5, N'JKL012')
SET IDENTITY_INSERT [dbo].[Vehicle] OFF
GO
INSERT [dbo].[VehicleOwner] ([VehicleID], [UserID]) VALUES (1, 3)
INSERT [dbo].[VehicleOwner] ([VehicleID], [UserID]) VALUES (2, 4)
INSERT [dbo].[VehicleOwner] ([VehicleID], [UserID]) VALUES (3, 5)
INSERT [dbo].[VehicleOwner] ([VehicleID], [UserID]) VALUES (4, 6)
INSERT [dbo].[VehicleOwner] ([VehicleID], [UserID]) VALUES (5, 7)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unq_email]    Script Date: 1/6/2024 3:40:39 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [unq_email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [unq_username]    Script Date: 1/6/2024 3:40:39 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [unq_username] UNIQUE NONCLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservation] ([ReservationID])
GO
ALTER TABLE [dbo].[ParkingLot]  WITH CHECK ADD FOREIGN KEY([SubID])
REFERENCES [dbo].[SubscriptionCategory] ([SubID])
GO
ALTER TABLE [dbo].[ParkingSpace]  WITH CHECK ADD FOREIGN KEY([LotID])
REFERENCES [dbo].[ParkingLot] ([LotID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([LotID])
REFERENCES [dbo].[ParkingLot] ([LotID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([SpaceID])
REFERENCES [dbo].[ParkingSpace] ([SpaceID])
GO
ALTER TABLE [dbo].[Reservation]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservation] ([ReservationID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[VehicleOwner]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[VehicleOwner]  WITH CHECK ADD FOREIGN KEY([VehicleID])
REFERENCES [dbo].[Vehicle] ([VehicleID])
GO
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD CHECK  (([Rating]>=(1) AND [Rating]<=(5)))
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD CHECK  (([Role]='User' OR [Role]='Admin'))
GO
/****** Object:  StoredProcedure [dbo].[checkout]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
	create procedure [dbo].[checkout] 
	   @username varchar(25),@exitime time,@date date ,@amount int
	   as
	   begin
	   declare @UserID int, @ResID int;
	   set @userid=dbo.getReservedUserID(@username);
	   set @ResID=dbo.getUserReservationID(@username);
	   insert into [transaction](UserID,ReservationID,ExitTime,Date,TotalAmount) values (@userid,@ResID,@exitime,@date,@amount)
	   end
GO
/****** Object:  StoredProcedure [dbo].[DeleteUser]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteUser]
    @UserID INT
AS
BEGIN
    DELETE FROM [User]
    WHERE UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteVehicle]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteVehicle]
    @VehicleID INT
AS
BEGIN
    DELETE FROM Vehicle
    WHERE VehicleID = @VehicleID;
END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteVehicleOwner]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteVehicleOwner]
    @VehicleID INT,
    @UserID INT
AS
BEGIN
    DELETE FROM VehicleOwner
    WHERE VehicleID = @VehicleID AND UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[requestParking]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   create procedure [dbo].[requestParking]
	   @username int, @liscenceplate int, @lotid int ,@spaceid int, @parkdate date , @parktime time
	   as
	   begin
	   declare @uID int;
	   select @uID=UserID from [User]
	   where Username=@username
	   insert into Reservation (UserID,VehiclePlate,LotID,SpaceID,ParkDate,ParkTime) values (@uID,@liscenceplate,@lotid,@spaceid,@parkdate,@parktime)
	   end
GO
/****** Object:  StoredProcedure [dbo].[submitFeedback]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   create procedure [dbo].[submitFeedback]
	   @ResID int, @Comment varchar(50), @Rating int
	   as
	   begin
	   Insert into Feedback(ReservationID,Date,Comment,Rating) values (@ResID,getdate(),@Comment,@Rating)
	   end
GO
/****** Object:  StoredProcedure [dbo].[UpdateReservation]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateReservation]
    @ReservationID INT,
    @UserID INT,
    @VehiclePlate varchar(25),
    @LotID INT,
    @SpaceID INT,
    @ParkDate DATE,
    @ParkTime TIME
AS
BEGIN
    UPDATE Reservation
    SET UserID = @UserID,
        VehiclePlate = @VehiclePlate,
        LotID = @LotID,
        SpaceID = @SpaceID,
        ParkDate = @ParkDate,
        ParkTime = @ParkTime   WHERE ReservationID = @ReservationID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSubscriptionCategory]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSubscriptionCategory]
    @SubID INT,
    @SubCategory VARCHAR(25),
    @HourlyRate DECIMAL(10, 2)
AS
BEGIN
    UPDATE SubscriptionCategory
    SET SubCategory = @SubCategory,
        HourlyRate = @HourlyRate
    WHERE SubID = @SubID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateTransaction]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateTransaction]
    @TransactionID INT,
    @UserID INT,
    @ReservationID INT,
    @ExitTime TIME,
    @Date DATE,
    @TotalAmount DECIMAL(10, 2)
AS
BEGIN
    UPDATE [Transaction]
    SET UserID = @UserID,
        ReservationID = @ReservationID,
        ExitTime = @ExitTime,
        [Date] = @Date,
        TotalAmount = @TotalAmount
    WHERE TransactionID = @TransactionID;
END;

GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateUser]
    @UserID INT,
    @Username VARCHAR(50),
    @FirstName VARCHAR(50),
    @LastName VARCHAR(50),
    @Email VARCHAR(25),
    @Password VARCHAR(25),
    @Role VARCHAR(20)
AS
BEGIN
    UPDATE [User]
    SET Username = @Username,
        FirstName = @FirstName,
        LastName = @LastName,
        Email = @Email,
        Password = @Password,
        Role = @Role
    WHERE UserID = @UserID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicle]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVehicle]
    @VehicleID INT,
    @NewLicensePlate VARCHAR(20)
AS
BEGIN
    UPDATE Vehicle
    SET LicensePlate = @NewLicensePlate
    WHERE VehicleID = @VehicleID;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateVehicleOwner]    Script Date: 1/6/2024 3:40:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateVehicleOwner]
    @VehicleID INT,
    @UserID INT,
    @NewVehicleID INT,
    @NewUserID INT
AS
BEGIN
    UPDATE VehicleOwner
    SET VehicleID = @NewVehicleID,
        UserID = @NewUserID
    WHERE VehicleID = @VehicleID AND UserID = @UserID;
END;
GO
USE [master]
GO
ALTER DATABASE [Parkingmanagment] SET  READ_WRITE 
GO
