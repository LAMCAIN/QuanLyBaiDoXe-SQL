USE QuanLyBaiDoXe;
GO

IF OBJECT_ID('sp_KiemTraDangNhap', 'P') IS NOT NULL
    DROP PROCEDURE sp_KiemTraDangNhap;
GO

CREATE PROCEDURE sp_KiemTraDangNhap
    @User NVARCHAR(50),
    @Pass NVARCHAR(50)
AS
BEGIN
    SELECT TenDangNhap, HoTen, Quyen 
    FROM TaiKhoan 
    WHERE TenDangNhap = @User AND MatKhau = @Pass;
END
GO

UPDATE TaiKhoan 
SET HoTen = N'Quản trị viên' 
WHERE TenDangNhap = 'admin';