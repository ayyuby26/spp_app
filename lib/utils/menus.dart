Items item1 = Items(title: "Data Kelas", img: "assets/img/data_kelas.svg");
Items item2 = Items(title: "Data Siswa", img: "assets/img/data_siswa.svg");
Items item3 = Items(title: "Pembayaran SPP", img: "assets/img/pembayaran_spp.svg");
Items item4 = Items(title: "Riwayat Pembayaran", img: "assets/img/riwayat_pembayaran.svg");
Items item5 = Items(title: "Laporan", img: "assets/img/laporan.svg");

class Items {
  String title;
  String img;
  Items({this.title, this.img});
}

List<Items> myList = [item1, item2, item3, item4, item5];
const List<String> menu = [
  "Data Kelas",
  "Data Siswa",
  "Pembayaran SPP",
  "Riwayat Pembayaran",
  "Pembayaran SPP",
  "Laporan"
];
