class Menu {
  int id;
  String nama;
  int harga;
  String tipe;
  String gambar;
  String catatan;
  int count;

  Menu(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.tipe,
      required this.gambar,
      required this.catatan,
      required this.count});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        tipe: json['tipe'],
        gambar: json['gambar'],
        catatan: '',
        count: 0);
  }
}
