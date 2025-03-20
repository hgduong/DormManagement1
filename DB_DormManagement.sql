CREATE DATABASE DormManagement;
GO

USE DormManagement;
GO

CREATE TABLE Accounts(
	Email VARCHAR(50) PRIMARY KEY,
	[password] VARCHAR(100),
	[Role] VARCHAR(50)
);
GO

CREATE TABLE Students(
	StudentID VARCHAR(8) PRIMARY KEY,
	StudentName NVARCHAR(50),
	DOB DATE,
	Gender VARCHAR(6) CHECK (Gender IN ('Male', 'Female')),
	Email VARCHAR(50)UNIQUE,
	Phone VARCHAR(15) UNIQUE,
	Department NVARCHAR (50) CHECK (Department IN (N'Software Engineer', N'Marketing', N'Artificial Intelligence')),
	constraint fk_Students_Email foreign key (Email) references Accounts(Email)
);
GO

CREATE TABLE Building(
	BuildingID CHAR(1) PRIMARY KEY,
	NumberOfFloors INT,
	NumberOfRooms INT
);
GO


CREATE TABLE Rooms(
	RoomID VARCHAR(4) PRIMARY KEY,
	Capacity INT CHECK (Capacity IN (3, 4, 6)),
	CurrentOccupants INT DEFAULT 0,
	RoomNumber INT CHECK (RoomNumber <= 20),
	Floor INT,
	RoomPrice DECIMAL(10, 2),
	BuildingID CHAR(1),
	constraint fk_Rooms_BuildingID foreign key (BuildingID) references Building(BuildingID)
);
GO

CREATE TABLE Staffs(
	StaffID VARCHAR(10) PRIMARY KEY,
	StaffName NVARCHAR(50),
	DOB DATE,
	Gender VARCHAR(6) CHECK (Gender IN ('Male', 'Female')),
	Email VARCHAR(50) UNIQUE,
	Phone VARCHAR(15) UNIQUE,
	Position NVARCHAR(50) CHECK (Position IN (N'Dorm Manager', N'Assignment Manager', N'Service Manager', N'Dorm Guard', N'Dorm Cleaner', N'Dorm Technician')),
	BuildingID CHAR(1),
	constraint fk_Staffs_Email foreign key (Email) references Accounts(Email)
);
GO

CREATE TABLE Assignments(
	AssignmentID VARCHAR(12) PRIMARY KEY,
	AssignmentDate DATE,
	AssignmentEnd DATE,
	CHECK (DAY(AssignmentDate) = 1),
	CHECK (MONTH(AssignmentDate) IN (1, 5, 9)),
	ReAssign NVARCHAR(10) CHECK (ReAssign IN (N'Yes', N'No')) DEFAULT N'Yes',
	StudentID VARCHAR(8),
	RoomID VARCHAR(4),
	StaffID VARCHAR(10),
	CONSTRAINT fk_Assignments_StudentID FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT fk_Assignments_RoomID FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    CONSTRAINT fk_Assignments_StaffID FOREIGN KEY (StaffID) REFERENCES Staffs(StaffID)
);
GO

CREATE TABLE Services(
	ServiceID varchar(3) PRIMARY KEY,
	ServiceName NVARCHAR(50),
	Cost DECIMAL(10, 2)
);
GO

CREATE TABLE ServiceUsage(
	UsageID VARCHAR(12) PRIMARY KEY,
	UsageDate DATE,
	UsageEnd DATE,
	RoomID VARCHAR(4) FOREIGN KEY REFERENCES Rooms(RoomID),
	ServiceID VARCHAR(3) FOREIGN KEY REFERENCES Services(ServiceID),
	StaffID VARCHAR(10) FOREIGN KEY REFERENCES Staffs(StaffID)
);
GO

CREATE TABLE Payments(
	PaymentID VARCHAR(13) PRIMARY KEY,
	Amount DECIMAL(10,2),
	PaymentMethod NVARCHAR(20) NULL,
	PaymentDeadline DATE,
	Status NVARCHAR(20) CHECK (Status IN (N'Pending', N'Completed', N'Expired')) DEFAULT N'Pending',
	StudentID VARCHAR(8) NULL FOREIGN KEY REFERENCES Students(StudentID),
	RoomID VARCHAR(4) FOREIGN KEY REFERENCES Rooms(RoomID),
	StaffID VARCHAR(10) FOREIGN KEY REFERENCES Staffs(StaffID),
	AssignmentID VARCHAR(12) NULL FOREIGN KEY REFERENCES Assignments(AssignmentID),
	UsageID VARCHAR(12) NULL FOREIGN KEY REFERENCES ServiceUsage(UsageID)
);
GO

CREATE TABLE MaintenanceRequests(
	RequestID VARCHAR (10) PRIMARY KEY,
	RequestDate DATE,
	ProblemDescription NVARCHAR(50),
	Status NVARCHAR(20) DEFAULT N'Not Complete', 
	CompletionDate DATE DEFAULT NULL,
	RoomID VARCHAR(4) FOREIGN KEY REFERENCES Rooms(RoomID),
	StaffID VARCHAR(10) FOREIGN KEY REFERENCES Staffs(StaffID)
);
GO

CREATE TABLE Request(
	StudentID VARCHAR(8) FOREIGN KEY REFERENCES Students(StudentID),
	RoomID VARCHAR(4) FOREIGN KEY REFERENCES Rooms(RoomID),
	BuildingID CHAR(1) FOREIGN KEY REFERENCES Building(BuildingID),
	ServiceID VARCHAR(3) FOREIGN KEY REFERENCES Services(ServiceID) NULL,
	[Description] VARCHAR(100),
	Position VARCHAR(50),
	[Status] VARCHAR(50) DEFAULT 'Pending'
);
GO



																																				--TẠO CÁC PROCEDURE

--Nhập dữ liệu vào Students với ID được kết hợp từ mã chuyên ngành + giá trị tự tăng
CREATE PROCEDURE InsertIntoStudents
	@StudentName NVARCHAR(50),
	@DOB DATE,
	@Gender VARCHAR(6),
	@Email VARCHAR(50),
	@Phone VARCHAR(15),
	@Department NVARCHAR(50)
AS
BEGIN
	--Kiểm tra format của Email
	IF @Email NOT LIKE '%@%.%'
	BEGIN
		RAISERROR('Invalid Email format.', 16, 1);
	END

	--Tạo StaffID theo Postion của Staff
	DECLARE @NewID INT;
    DECLARE @StudentID VARCHAR(10);
	DECLARE @DepID VARCHAR(2);
	DECLARE @AcademicYear INT;
	--Tạo mã theo Position
	IF @Department = N'Software Engineer'
	SET @DepID = 'SE'
	IF @Department = N'Marketing'
	SET @DepID = 'MA'
	IF @Department = N'Artificial Intelligence'
	SET @DepID = 'AI'
    -- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(StudentID, 3, 6) AS INT)), 0) + 1
    FROM Students
    WHERE StudentID LIKE @DepID + '%';
    -- Kết hợp PosID và NewID để tạo StaffID
    SET @StudentID = @DepID + RIGHT('000000' + CAST(@NewID AS VARCHAR), 6);

    -- Nhập dữ liệu mới
    INSERT INTO Students(StudentID, StudentName, DOB, Gender, Email, Phone, Department)
    VALUES (@StudentID, @StudentName, @DOB, @Gender, @Email, @Phone, @Department);
END
GO

-- Nhập dữ liệu vào Building với ID tự động gán từ A, B, C,...
CREATE PROCEDURE InsertIntoBuilding
    @NumberOfFloors INT
AS
BEGIN
	--Kiểm tra điều kiện dữ liệu nhập vào
	IF @NumberOfFloors > 4
	BEGIN
		RAISERROR ('Cannot insert data. NumberOfFloors must not exceed 4.', 16, 1);
		RETURN;
	END
	ELSE
	BEGIN
    DECLARE @lastID CHAR(1);
    DECLARE @newID CHAR(1);

    -- Lấy giá trị BuildingID cuối cùng
    SELECT @lastID = MAX(BuildingID) FROM Building;

    -- Nếu không có giá trị nào, bắt đầu từ 'A'
    IF @lastID IS NULL
    BEGIN
        SET @newID = 'A';
    END
    ELSE
    BEGIN
        -- Tính toán BuildingID mới dựa trên giá trị cuối cùng
        SET @newID = CHAR(ASCII(@lastID) + 1);
    END

	--Lấy giá trị của NumberOfRooms
	DECLARE @NumberOfRooms INT
	SET @NumberOfRooms = @NumberOfFloors * 10

    -- Nhập dữ liệu mới
    INSERT INTO Building (BuildingID, NumberOfFloors, NumberOfRooms) VALUES (@newID, @NumberOfFloors, @NumberOfRooms);
	END
END
GO

--Nhập dữ liệu vào Rooms với ID có dạng 'A101' - "BuildingID + Floor + RoomNumber"
CREATE PROCEDURE InsertIntoRooms
	@RoomNumber INT,
	@BuildingID CHAR(1),
	@Floor INT,
	@Capacity INT
AS
BEGIN
	--Kiểm tra @Floor có tương ứng với NumberOfFloors từ bảng Building không
	DECLARE @NumberOfFloors INT
	SELECT @NumberOfFLoors = NumberOfFloors FROM Building WHERE @BuildingID = BuildingID
	IF @Floor > @NumberOfFloors
	BEGIN
		RAISERROR ('Cannot insert data. @Floor must not exceed NumberOfFloors.', 16, 1);
        RETURN;
    END
	
	-- Kiểm tra điều kiện dữ liệu nhập vào
	IF @RoomNumber > 10
	BEGIN 
		RAISERROR ('Cannot insert data. @RoomNumber must not exceed 10.', 16, 1);
		RETURN;
	END
	ELSE
	BEGIN
		DECLARE @RoomID VARCHAR(4);

		--Xét RoomID theo định dang 'A101'
		IF @RoomNumber < 10
		BEGIN
		SET @RoomID = CONCAT(@BuildingID, '', @Floor, '0', @RoomNumber);
		END
		ELSE
		BEGIN
		SET @RoomID = CONCAT(@BuildingID, '', @Floor, '', @RoomNumber);
		END

		--Nhập @RoomPrice theo giá loại phòng
	DECLARE @RoomPrice DECIMAL(10, 2)
	IF @Capacity = 3
	SET @RoomPrice = 2400000
	IF @Capacity = 4
	SET @RoomPrice = 1680000
	IF @Capacity = 6
	SET @RoomPrice = 1200000
		--Nhập dữ liệu mới
		INSERT INTO Rooms (RoomID, Capacity, RoomNumber, Floor, RoomPrice, BuildingID) VALUES (@RoomID, @Capacity, @RoomNumber, @Floor, @RoomPrice, @BuildingID);
	END
END
GO

--Nhập dữ liệu vào Staffs với ID được kết hợp từ mã công việc + giá trị tự tăng
CREATE PROCEDURE InsertIntoStaffs
	@StaffName NVARCHAR(50),
	@DOB DATE,
	@Gender VARCHAR(6),
	@Email VARCHAR(50),
	@Phone VARCHAR(15),
	@Position NVARCHAR(50),
	@BuildingID CHAR(1)
AS
BEGIN
	--Kiểm tra format của Email
	IF @Email NOT LIKE '%@%.%'
	BEGIN
		RAISERROR('Invalid Email format.', 16, 1);
	END

	--Tạo StaffID theo Postion của Staff
	DECLARE @NewID INT;
    DECLARE @StaffID VARCHAR(10);
	DECLARE @PosID VARCHAR(2);
	--Tạo mã theo Position
	IF @Position = N'Dorm Manager'
	SET @PosID = 'DM'
	IF @Position = N'Assignment Manager'
	SET @PosID = 'AM'
	IF @Position = N'Service Manager'
	SET @PosID = 'SM'
	IF @Position = N'Dorm Guard'
	SET @PosID = 'DG'
	IF @Position = N'Dorm Cleaner'
	SET @PosID = 'DC'
	IF @Position = N'Dorm Technician'
	SET @PosID = 'DT'
    -- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(StaffID, 3, 6) AS INT)), 0) + 1
    FROM Staffs
    WHERE StaffID LIKE @PosID + '%';
    -- Kết hợp PosID và NewID để tạo StaffID
    SET @StaffID = @PosID + RIGHT('000000' + CAST(@NewID AS VARCHAR), 6);

    -- Nhập dữ liệu mới
    INSERT INTO Staffs (StaffID, StaffName, DOB, Gender, Email, Phone, Position, BuildingID)
    VALUES (@StaffID, @StaffName, @DOB, @Gender, @Email, @Phone, @Position, @BuildingID);
END
GO

--Nhập dữ liệu vào Assignments
CREATE PROCEDURE InsertIntoAssignments
	@AssignmentDate DATE,
	@StudentID VARCHAR(8),
	@RoomID VARCHAR(4),
	@StaffID VARCHAR(10)
AS
BEGIN
	--Tạo định dạng tự động cho AssigmentID
	DECLARE @AssignmentID VARCHAR(12)
	DECLARE @NewID INT
	-- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(AssignmentID, 10, 3) AS INT)), 0) + 1
    FROM Assignments
    WHERE SUBSTRING(AssignmentID, 2, 8) = @StudentID;
	-- Kết hợp PosID và NewID để tạo StaffID
    SET @AssignmentID = 'A' + @StudentID + RIGHT('000' + CAST(@NewID AS VARCHAR(3)), 3);

	--Đổi ngày đăng ký phù hợp với yêu cầu
	DECLARE @today DATE = GETDATE();
	DECLARE @adjustedDate DATE;

	IF (MONTH(@today) > 1 AND MONTH(@today) < 5) OR (MONTH(@today) = 1 AND DAY(@today) > 1)
		SET @adjustedDate = DATEFROMPARTS(YEAR(@today), 5, 1);
	ELSE IF (MONTH(@today) > 5 AND MONTH(@today) < 9) OR (MONTH(@today) = 5 AND DAY(@today) > 1)
		SET @adjustedDate = DATEFROMPARTS(YEAR(@today), 9, 1);
	ELSE IF MONTH(@today) > 9 OR (MONTH(@today) = 9 AND DAY(@today) > 1)
		SET @adjustedDate = DATEFROMPARTS(YEAR(@today)+1, 1, 1);
	ELSE IF (MONTH(@today) = 1 AND DAY(@today) = 1) OR (MONTH(@today) = 5 AND DAY(@today) = 1) OR (MONTH(@today) = 9 AND DAY(@today) = 1)
		SET @adjustedDate = @today;

	--Kiểm tra xem phòng đã hết chỗ chưa
	DECLARE @CurrentOccupants INT
	DECLARE @Capacity INT
	SELECT @CurrentOccupants = CurrentOccupants, @Capacity = Capacity
	FROM Rooms
	WHERE @RoomID = RoomID
	IF @CurrentOccupants = @Capacity
	BEGIN
		RAISERROR('This room is currently full, please register for another room.', 16, 1);
        RETURN;
	END

	--Cập nhật AssignmentEnd theo AssignmentDate
	DECLARE @AssignmentEnd DATE
	SET @AssignmentEnd = DATEADD(MONTH, 4, @adjustedDate)

	--Nhập dữ liệu mới
	INSERT INTO Assignments(AssignmentID, AssignmentDate, AssignmentEnd, StudentID, RoomID, StaffID) VALUES
	(@AssignmentID, @adjustedDate, @AssignmentEnd, @StudentID, @RoomID, @StaffID)
END
GO

--Cập nhật ReAssign
CREATE PROCEDURE Update_ReAssign
	@AssignmentID VARCHAR(12)
AS
BEGIN
	UPDATE Assignments
	SET ReAssign = N'No'
	WHERE AssignmentID = @AssignmentID
END
GO

--Nhập dữ liệu vào Services
CREATE PROCEDURE InsertIntoServices
	@ServiceName NVARCHAR(50),
	@Cost DECIMAL(10, 2)
AS
BEGIN
	--Nhập ServiceID tự động
	DECLARE @ServiceID VARCHAR(3)
	DECLARE @NewID INT
	SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(ServiceID, 2, 2) AS INT)), 0) + 1
    FROM Services
    -- Kết hợp PosID và NewID để tạo StaffID
    SET @ServiceID = 'S' + RIGHT('00' + CAST(@NewID AS VARCHAR), 2);

	--Nhập dữ liệu mới
	INSERT INTO Services(ServiceID, ServiceName, Cost) VALUES
	(@ServiceID, @ServiceName, @Cost)
END
GO

--Nhập dữ liệu vào ServiceUsage
CREATE PROCEDURE InsertIntoServiceUsage
	@UsageDate DATE,
	@RoomID VARCHAR(4),
	@ServiceID VARCHAR(3),
	@StaffID VARCHAR(10)
AS
BEGIN
	--Tạo định dạng tự động cho UsageID
	DECLARE @UsageID VARCHAR(12)
	DECLARE @NewID INT
	-- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(UsageID, 9, 4) AS INT)), 0) + 1
    FROM ServiceUsage
    WHERE ServiceID = @ServiceID AND RoomID = @RoomID;
	-- Kết hợp PosID và NewID để tạo StaffID
    SET @UsageID = 'U' + @ServiceID + @RoomID + RIGHT('0000' + CAST(@NewID AS VARCHAR(4)), 4);

	--Cập nhật UsageEnd theo UsageDate
	DECLARE @UsageEnd DATE
	SET @UsageEnd = DATEADD(MONTH, 1, @UsageDate)


	--Nhập dữ liệu mới
	INSERT INTO ServiceUsage(UsageID, UsageDate, UsageEnd, ServiceID, RoomID, StaffID) VALUES
	(@UsageID, @UsageDate, @UsageEnd, @ServiceID, @RoomID, @StaffID)
END
GO

--Nhập dữ liệu vào Payment theo Assignment
CREATE PROCEDURE InsertIntoPayments_Assignments
	@Amount DECIMAL(10, 2),
	@PaymentDeadline DATE,
	@StudentID VARCHAR(8),
	@RoomID VARCHAR(4),
	@StaffID VARCHAR(10),
	@AssignmentID VARCHAR(12)
AS
BEGIN
	--Tạo PaymentID tự động
	DECLARE @PaymentID VARCHAR(13)
	DECLARE @NewID INT

	-- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(PaymentID, 11, 3) AS INT)), 0) + 1
    FROM Payments
    WHERE StudentID = @StudentID;
	-- Kết hợp PosID và NewID để tạo StaffID
    SET @PaymentID = 'PA' + @StudentID + RIGHT('000' + CAST(@NewID AS VARCHAR(3)), 3);

	INSERT INTO Payments(PaymentID, Amount, PaymentDeadline, StudentID, RoomID, StaffID, AssignmentID)
	VALUES (@PaymentID, @Amount, @PaymentDeadline, @StudentID, @RoomID, @StaffID, @AssignmentID)
END
GO

--Nhập dữ liệu vào MaintenanceRequests
CREATE PROCEDURE InsertIntoMaintenanceRequests
	@RequestDate DATE,
	@ProblemDescription NVARCHAR(50),
	@RoomID VARCHAR(4),
	@StaffID VARCHAR(10)
AS
BEGIN
	--Tạo ID tự động
	DECLARE @RequestID VARCHAR(10)
	DECLARE @NewID INT
	-- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(RequestID, 7, 4) AS INT)), 0) + 1
    FROM MaintenanceRequests
    WHERE RoomID = @RoomID;
	-- Kết hợp PosID và NewID để tạo StaffID
    SET @RequestID = 'MR' + @RoomID + RIGHT('0000' + CAST(@NewID AS VARCHAR(4)), 4);

	--Nhập dữ liệu mới
	INSERT INTO MaintenanceRequests(RequestID, ProblemDescription, RequestDate, RoomID, StaffID)
	VALUES (@RequestID, @ProblemDescription, @RequestDate, @RoomID, @StaffID)
END
GO

--Cập nhật ngày hoàn thành request
CREATE PROCEDURE Update_CompletionDate
	@CompletionDate DATE,
	@RequestID VARCHAR(10)
AS
BEGIN
	UPDATE MaintenanceRequests
	SET CompletionDate = @CompletionDate
	WHERE RequestID = @RequestID
END
GO

CREATE PROCEDURE Update_PaymentMethod
	@PaymentID VARCHAR(13),
	@PaymentMethod NVARCHAR(50)
AS
BEGIN
	Update Payments
	SET PaymentMethod = @PaymentMethod
	WHERE PaymentID = @PaymentID
END
GO



																																					--TẠO CÁC TRIGGER

--Tự động tạo Payments khi Sinh viên đăng ký phòng
CREATE TRIGGER AutoInsertIntoPayments_Assignments
ON Assignments
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @SID VARCHAR(8)
	DECLARE @RID VARCHAR(4)
	DECLARE @StfID VARCHAR(10)
	SELECT @SID = StudentID, @RID = RoomID, @StfID = StaffID
	FROM inserted

	--Nhập PaymetDeadline
	DECLARE @PaymentDl DATE
	SELECT @PaymentDl = DATEADD(DAY, -5, AssignmentDate)
	FROM inserted

	--Nhập Amount dựa theo giá phòng
	DECLARE @Amt DECIMAL(10,2)
	SELECT @Amt = Rooms.RoomPrice
	FROM inserted JOIN Rooms ON inserted.RoomID = Rooms.RoomID

	--Nhập dữ liệu mới
	DECLARE @AID VARCHAR(12)
	SELECT @AID = AssignmentID
	FROM inserted
	
	EXEC InsertIntoPayments_Assignments @Amount = @Amt, @PaymentDeadline = @PaymentDl, @StudentID = @SID, @RoomID = @RID, @StaffID = @StfID, @AssignmentID = @AID
END
GO

--Tự động tạo Payments khi Assignment hết hạn và sinh viên đồng ý đăng ký tiếp
CREATE TRIGGER Create_Payments_ReAssign_Assignment
ON Assignments
AFTER INSERT
AS
BEGIN

	IF EXISTS (SELECT 1 FROM Assignments JOIN Payments ON Assignments.AssignmentID = Payments.AssignmentID WHERE DATEADD(DAY, - 10, AssignmentEnd) < GETDATE() AND ReAssign = N'Yes' AND Status = 'Completed')
	BEGIN
		DECLARE @SID VARCHAR(8)
		DECLARE @RID VARCHAR(4)
		DECLARE @StfID VARCHAR(10)
		DECLARE @PaymentDl DATE
		DECLARE @Amt DECIMAL(10,2)
		DECLARE @AID VARCHAR(12)
		SELECT @Amt = RoomPrice, @PaymentDl = DATEADD(DAY, -5, AssignmentEnd), @SID = Assignments.StudentID, @RID = Assignments.RoomID, @StfID = Assignments.StaffID, @AID = Assignments.AssignmentID
		FROM Assignments JOIN Rooms ON Assignments.RoomID = Rooms.RoomID JOIN Payments ON Assignments.AssignmentID = Payments.AssignmentID
		WHERE DATEADD(DAY, - 10, AssignmentEnd) < GETDATE() AND ReAssign = N'Yes' AND Status = 'Completed'
		EXEC InsertIntoPayments_Assignments @Amount = @Amt, @PaymentDeadline = @PaymentDl, @StudentID = @SID, @RoomID = @RID, @StaffID = @StfID, @AssignmentID = @AID

		UPDATE Assignments
		SET AssignmentEnd = DATEADD(MONTH, 4, AssignmentEnd), AssignmentDate = DATEADD(MONTH, 4, AssignmentDate)
		FROM Assignments JOIN Payments ON Assignments.AssignmentID = Payments.AssignmentID
		WHERE DATEADD(DAY, - 10, AssignmentEnd) < GETDATE() AND ReAssign = N'Yes' AND Status = 'Completed' 
		
	END
END
GO

--Tự động tạo Payments khi Sinh viên đăng ký dịch vụ
CREATE TRIGGER InsertIntoPayments_Services
ON ServiceUsage
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	
	--Tạo PaymentID tự động
	DECLARE @PaymentID VARCHAR(13)
	DECLARE @NewID INT
	DECLARE @RoomID VARCHAR(4)
	DECLARE @StaffID VARCHAR(10)
	SELECT @RoomID = RoomID, @StaffID = StaffID
	FROM inserted
	-- Tính toán giá trị ID tự tăng mới
    SELECT @NewID = ISNULL(MAX(CAST(SUBSTRING(PaymentID, 7, 7) AS INT)), 0) + 1
    FROM Payments
    WHERE RoomID = @RoomID;
	-- Kết hợp PosID và NewID để tạo StaffID
    SET @PaymentID = 'PS' + @RoomID + RIGHT('0000000' + CAST(@NewID AS VARCHAR(7)), 7);

	--Nhập PaymetDeadline
	DECLARE @PaymentDeadline DATE
	SELECT @PaymentDeadline = DATEADD(DAY, 5, UsageDate)
	FROM inserted

	--Nhập Amount dựa theo giá dịch vụ
	DECLARE @Amount DECIMAL(10,2)
	SELECT @Amount = Services.Cost
	FROM inserted JOIN Services ON inserted.ServiceID = Services.ServiceID

	--Nhập dữ liệu mới
	DECLARE @UsageID VARCHAR(12)
	SELECT @UsageID = UsageID
	FROM inserted

	INSERT INTO Payments(PaymentID, Amount, PaymentDeadline, RoomID, StaffID, UsageID)
	VALUES (@PaymentID, @Amount, @PaymentDeadline, @RoomID, @StaffID, @UsageID)
END
GO

--Cập nhật Status của Maintenance sau khi hoàn thành
CREATE TRIGGER Update_Status_Maintenance
ON MaintenanceRequests
AFTER UPDATE
AS
BEGIN
	IF UPDATE(CompletionDate)
	BEGIN
		UPDATE MaintenanceRequests
		SET Status = 'Completed'
		FROM MaintenanceRequests JOIN inserted ON MaintenanceRequests.RequestID = inserted.RequestID
	END
END
GO

--Xử lý CurrentOccupants khi có Assignment mới
CREATE TRIGGER Update_CurrentOccupants
ON Assignments
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON

	UPDATE Rooms
	SET CurrentOccupants = CurrentOccupants + 1
	FROM Rooms r
	JOIN inserted i ON i.RoomID = r.RoomID
END
GO

--Xử lý khi sinh viên muốn huỷ phòng trong tương lai
CREATE TRIGGER Not_ReAssign
ON Assignments
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON

	IF UPDATE(ReAssign)
	BEGIN
		DECLARE @AssignmentID VARCHAR(12)
		SELECT @AssignmentID = AssignmentID
		FROM inserted
		DELETE FROM Payments WHERE Status = N'Pending' AND AssignmentID = @AssignmentID
		UPDATE Rooms
		SET CurrentOccupants = CurrentOccupants - 1
		FROM Rooms JOIN inserted ON Rooms.RoomID = inserted.RoomID
		WHERE inserted.ReAssign = N'No'
	END
END
GO

--Cập nhật trạng thái Payments và huỷ phòng với các Payments hết hạn
CREATE TRIGGER Update_Status_Payments
ON Payments
AFTER UPDATE
AS
BEGIN
	SET NOCOUNT ON
	
	--Cập nhật trạng thái
	IF UPDATE(PaymentMethod)
	BEGIN
		UPDATE Payments
		SET Status = N'Completed'
		FROM Payments JOIN inserted ON Payments.PaymentID = inserted.PaymentID
	END
	IF EXISTS (SELECT 1 FROM Payments WHERE PaymentDeadline < GETDATE() AND PaymentMethod IS NULL)
	BEGIN
		UPDATE Payments
		SET Status = N'Expired'
		WHERE PaymentMethod IS NULL AND PaymentDeadline < GETDATE()

		UPDATE Rooms
		SET CurrentOccupants = CurrentOccupants - 1
		FROM Rooms JOIN Payments ON Rooms.RoomID = Payments.RoomID JOIN Assignments ON Payments.AssignmentID = Assignments.AssignmentID
		WHERE Status = N'Expired' AND ReAssign = N'Yes'

		UPDATE Assignments
		SET ReAssign = N'No'
		FROM Assignments JOIN Payments ON Assignments.AssignmentID = Payments.AssignmentID
		WHERE Status = N'Expired' AND ReAssign = N'Yes'
	END
END
GO

																																	--INSERT DỮ LIỆU

--Nhập dữ liệu vào Building																																			--
BEGIN
EXEC InsertIntoBuilding 4;
EXEC InsertIntoBuilding 4;
EXEC InsertIntoBuilding 4;
END
GO

--Nhập dữ liệu vào Rooms
BEGIN
EXEC InsertIntoRooms 1, 'A', 1, 6;
EXEC InsertIntoRooms 2, 'A', 1, 6;
EXEC InsertIntoRooms 3, 'A', 1, 6;
EXEC InsertIntoRooms 4, 'A', 1, 6;
EXEC InsertIntoRooms 5, 'A', 1, 6;
EXEC InsertIntoRooms 6, 'A', 1, 4;
EXEC InsertIntoRooms 7, 'A', 1, 4;
EXEC InsertIntoRooms 8, 'A', 1, 4;
EXEC InsertIntoRooms 9, 'A', 1, 3;
EXEC InsertIntoRooms 10, 'A', 1, 3;
EXEC InsertIntoRooms 1, 'A', 2, 6;
EXEC InsertIntoRooms 2, 'A', 2, 6;
EXEC InsertIntoRooms 3, 'A', 2, 6;
EXEC InsertIntoRooms 4, 'A', 2, 6;
EXEC InsertIntoRooms 5, 'A', 2, 6;
EXEC InsertIntoRooms 6, 'A', 2, 4;
EXEC InsertIntoRooms 7, 'A', 2, 4;
EXEC InsertIntoRooms 8, 'A', 2, 4;
EXEC InsertIntoRooms 9, 'A', 2, 3;
EXEC InsertIntoRooms 10, 'A', 2, 3;
EXEC InsertIntoRooms 1, 'A', 3, 6;
EXEC InsertIntoRooms 2, 'A', 3, 6;
EXEC InsertIntoRooms 3, 'A', 3, 6;
EXEC InsertIntoRooms 4, 'A', 3, 6;
EXEC InsertIntoRooms 5, 'A', 3, 6;
EXEC InsertIntoRooms 6, 'A', 3, 4;
EXEC InsertIntoRooms 7, 'A', 3, 4;
EXEC InsertIntoRooms 8, 'A', 3, 4;
EXEC InsertIntoRooms 9, 'A', 3, 3;
EXEC InsertIntoRooms 10, 'A', 3, 3;
EXEC InsertIntoRooms 1, 'A', 4, 6;
EXEC InsertIntoRooms 2, 'A', 4, 6;
EXEC InsertIntoRooms 3, 'A', 4, 6;
EXEC InsertIntoRooms 4, 'A', 4, 6;
EXEC InsertIntoRooms 5, 'A', 4, 6;
EXEC InsertIntoRooms 6, 'A', 4, 4;
EXEC InsertIntoRooms 7, 'A', 4, 4;
EXEC InsertIntoRooms 8, 'A', 4, 4;
EXEC InsertIntoRooms 9, 'A', 4, 3;
EXEC InsertIntoRooms 10, 'A', 4, 3;

EXEC InsertIntoRooms 1, 'B', 1, 6;
EXEC InsertIntoRooms 2, 'B', 1, 6;
EXEC InsertIntoRooms 3, 'B', 1, 6;
EXEC InsertIntoRooms 4, 'B', 1, 6;
EXEC InsertIntoRooms 5, 'B', 1, 6;
EXEC InsertIntoRooms 6, 'B', 1, 4;
EXEC InsertIntoRooms 7, 'B', 1, 4;
EXEC InsertIntoRooms 8, 'B', 1, 4;
EXEC InsertIntoRooms 9, 'B', 1, 3;
EXEC InsertIntoRooms 10, 'B', 1, 3;
EXEC InsertIntoRooms 1, 'B', 2, 6;
EXEC InsertIntoRooms 2, 'B', 2, 6;
EXEC InsertIntoRooms 3, 'B', 2, 6;
EXEC InsertIntoRooms 4, 'B', 2, 6;
EXEC InsertIntoRooms 5, 'B', 2, 6;
EXEC InsertIntoRooms 6, 'B', 2, 4;
EXEC InsertIntoRooms 7, 'B', 2, 4;
EXEC InsertIntoRooms 8, 'B', 2, 4;
EXEC InsertIntoRooms 9, 'B', 2, 3;
EXEC InsertIntoRooms 10, 'B', 2, 3;
EXEC InsertIntoRooms 1, 'B', 3, 6;
EXEC InsertIntoRooms 2, 'B', 3, 6;
EXEC InsertIntoRooms 3, 'B', 3, 6;
EXEC InsertIntoRooms 4, 'B', 3, 6;
EXEC InsertIntoRooms 5, 'B', 3, 6;
EXEC InsertIntoRooms 6, 'B', 3, 4;
EXEC InsertIntoRooms 7, 'B', 3, 4;
EXEC InsertIntoRooms 8, 'B', 3, 4;
EXEC InsertIntoRooms 9, 'B', 3, 3;
EXEC InsertIntoRooms 10, 'B', 3, 3;
EXEC InsertIntoRooms 1, 'B', 4, 6;
EXEC InsertIntoRooms 2, 'B', 4, 6;
EXEC InsertIntoRooms 3, 'B', 4, 6;
EXEC InsertIntoRooms 4, 'B', 4, 6;
EXEC InsertIntoRooms 5, 'B', 4, 6;
EXEC InsertIntoRooms 6, 'B', 4, 4;
EXEC InsertIntoRooms 7, 'B', 4, 4;
EXEC InsertIntoRooms 8, 'B', 4, 4;
EXEC InsertIntoRooms 9, 'B', 4, 3;
EXEC InsertIntoRooms 10, 'B', 4, 3;

EXEC InsertIntoRooms 1, 'C', 1, 6;
EXEC InsertIntoRooms 2, 'C', 1, 6;
EXEC InsertIntoRooms 3, 'C', 1, 6;
EXEC InsertIntoRooms 4, 'C', 1, 6;
EXEC InsertIntoRooms 5, 'C', 1, 6;
EXEC InsertIntoRooms 6, 'C', 1, 4;
EXEC InsertIntoRooms 7, 'C', 1, 4;
EXEC InsertIntoRooms 8, 'C', 1, 4;
EXEC InsertIntoRooms 9, 'C', 1, 3;
EXEC InsertIntoRooms 10, 'C', 1, 3;
EXEC InsertIntoRooms 1, 'C', 2, 6;
EXEC InsertIntoRooms 2, 'C', 2, 6;
EXEC InsertIntoRooms 3, 'C', 2, 6;
EXEC InsertIntoRooms 4, 'C', 2, 6;
EXEC InsertIntoRooms 5, 'C', 2, 6;
EXEC InsertIntoRooms 6, 'C', 2, 4;
EXEC InsertIntoRooms 7, 'C', 2, 4;
EXEC InsertIntoRooms 8, 'C', 2, 4;
EXEC InsertIntoRooms 9, 'C', 2, 3;
EXEC InsertIntoRooms 10, 'C', 2, 3;
EXEC InsertIntoRooms 1, 'C', 3, 6;
EXEC InsertIntoRooms 2, 'C', 3, 6;
EXEC InsertIntoRooms 3, 'C', 3, 6;
EXEC InsertIntoRooms 4, 'C', 3, 6;
EXEC InsertIntoRooms 5, 'C', 3, 6;
EXEC InsertIntoRooms 6, 'C', 3, 4;
EXEC InsertIntoRooms 7, 'C', 3, 4;
EXEC InsertIntoRooms 8, 'C', 3, 4;
EXEC InsertIntoRooms 9, 'C', 3, 3;
EXEC InsertIntoRooms 10, 'C', 3, 3;
EXEC InsertIntoRooms 1, 'C', 4, 6;
EXEC InsertIntoRooms 2, 'C', 4, 6;
EXEC InsertIntoRooms 3, 'C', 4, 6;
EXEC InsertIntoRooms 4, 'C', 4, 6;
EXEC InsertIntoRooms 5, 'C', 4, 6;
EXEC InsertIntoRooms 6, 'C', 4, 4;
EXEC InsertIntoRooms 7, 'C', 4, 4;
EXEC InsertIntoRooms 8, 'C', 4, 4;
EXEC InsertIntoRooms 9, 'C', 4, 3;
EXEC InsertIntoRooms 10, 'C', 4, 3;
END
GO


--Nhập dữ liệu vào Services
BEGIN
EXEC InsertIntoServices 'Internet','200000';
EXEC InsertIntoServices 'Laundry','50000';
END
GO