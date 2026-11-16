Create Database QuanLyBaiXeDB;
Go

Use QuanlyBaiXeDB;
Go

Create Table Slots (
	SlotId Varchar(10) Primary Key, --Mã vị trí (1-A)
	Status Nvarchar(50) Not Null,   --Trạng thái: Trống, Đang có xe
	LicensePlate Varchar(20) Null,	--Biển số xe
	VehicleType Nvarchar(20) Null,	--Loại xe: Ô tô, Xe máy
	CheckInTime Datetime null		--Thời gian vào
);
GO

Create Table Transactions (
	Id Int Identity(1,1) Primary Key,	--Mã giao dịch tự tăng
	LincensePlate Varchar(20) Not Null, --Biển số xe
	VehicleType Nvarchar(20) Not Null,	--Loại xe
	CheckInTime Datetime Not Null,		--Thời gian vào
	CheckOutTime Datetime Not Null,		--Thời gian ra
	Fee Decimal(18,2) Not Null,			--Cước phí thu được (VNĐ)
	SlotId Varchar(10) Not Null			--Vị trí đỗ
);
GO

	