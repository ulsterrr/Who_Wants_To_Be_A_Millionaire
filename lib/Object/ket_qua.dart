class KetQua {
  int? MaKQ;
  int? NguoiChoi;
  int? Diem;
  String? ThoiGian;

  KetQua(
      {this.MaKQ,
      required this.NguoiChoi,
      required this.Diem,
      required this.ThoiGian});

  Map<String, dynamic> toMap() {
    return {
      'MaKQ': MaKQ,
      'NguoiChoi': NguoiChoi,
      'Diem': Diem,
      'ThoiGian': ThoiGian
    };
  }

  @override
  String toString() {
    return 'DapAn{MaKQ:$MaKQ,NguoiChoi:$NguoiChoi,Diem:$Diem,ThoiGian:$ThoiGian}';
  }
}
