class Voucher {
  int id;
  String kode;
  int nominal;
  String createdAt;
  String updatedAt;

  Voucher({
    required this.id,
    required this.kode,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
        id: json['id'],
        kode: json['kode'],
        nominal: json['nominal'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
