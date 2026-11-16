USE QuanLyBaiXeDB;
GO

-- 1. Xóa các thủ tục cũ
IF OBJECT_ID('sp_GetAllSlots', 'P') IS NOT NULL DROP PROCEDURE sp_GetAllSlots;
IF OBJECT_ID('sp_UpdateSlotCheckIn', 'P') IS NOT NULL DROP PROCEDURE sp_UpdateSlotCheckIn;
IF OBJECT_ID('sp_ProcessCheckOut', 'P') IS NOT NULL DROP PROCEDURE sp_ProcessCheckOut;
GO

-- 2. Xóa bảng Transactions và Slots cũ
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Slots;
GO

-- 3. Tạo lại bảng Slots 
CREATE TABLE Slots (
    SlotId VARCHAR(10) PRIMARY KEY,       
    Status NVARCHAR(50) NOT NULL,         
    LicensePlate VARCHAR(20) NULL,        
    VehicleType NVARCHAR(20) NULL,        
    CheckInTime DATETIME NULL             
);
GO

-- 4. Tạo lại bảng Transactions 
CREATE TABLE Transactions (
    Id INT IDENTITY(1,1) PRIMARY KEY,     
    LicensePlate VARCHAR(20) NOT NULL,    
    VehicleType NVARCHAR(20) NOT NULL,    
    CheckInTime DATETIME NOT NULL,        
    CheckOutTime DATETIME NOT NULL,       
    Fee DECIMAL(18,2) NOT NULL,           
    SlotId VARCHAR(10) NOT NULL           
);
GO

-- 5. Lấy danh sách ô đỗ
CREATE PROCEDURE sp_GetAllSlots
AS
BEGIN
    SELECT SlotId, Status, LicensePlate, VehicleType, CheckInTime 
    FROM Slots;
END
GO

-- 6. Cập nhật check-in
CREATE PROCEDURE sp_UpdateSlotCheckIn
    @SlotId VARCHAR(10),
    @LicensePlate VARCHAR(20),
    @VehicleType NVARCHAR(20),
    @CheckInTime DATETIME
AS
BEGIN
    UPDATE Slots 
    SET Status = N'Đang gửi', 
        LicensePlate = @LicensePlate, 
        VehicleType = @VehicleType, 
        CheckInTime = @CheckInTime
    WHERE SlotId = @SlotId;
END
GO

-- 7. Xử lý check-out và lưu lịch sử
CREATE PROCEDURE sp_ProcessCheckOut
    @SlotId VARCHAR(10),
    @LicensePlate VARCHAR(20),
    @VehicleType NVARCHAR(20),
    @CheckInTime DATETIME,
    @CheckOutTime DATETIME,
    @Fee DECIMAL(18,2)
AS
BEGIN
    -- Trả lại trạng thái trống cho ô đỗ
    UPDATE Slots 
    SET Status = N'Trống', 
        LicensePlate = NULL, 
        VehicleType = NULL, 
        CheckInTime = NULL
    WHERE SlotId = @SlotId;

    -- Ghi nhận lịch sử giao dịch
    INSERT INTO Transactions (LicensePlate, VehicleType, CheckInTime, CheckOutTime, Fee, SlotId)
    VALUES (@LicensePlate, @VehicleType, @CheckInTime, @CheckOutTime, @Fee, @SlotId);
END
GO