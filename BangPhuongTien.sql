use QuanlyBaiDoXe
go

create table Xe (
	MaThe int identity(1,1) primary key,
	BienSo NVARCHAR(20) not null,
	LoaiXe NVARCHAR(50),
	ThoiGianVao datetime default getdate(),
	TrangThai NVARCHAR(30) default N'Đang gửi'
);
go

insert into Xe (BienSo, LoaiXe, TrangThai)
values (N'29A-123.45', N'Ô tô', N'Đang gửi'),
	   (N'30B-999.99', N'Xe máy', N'Đang gửi');
go