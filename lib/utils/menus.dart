final _item1 = Items(
  title: "Data Kelas",
  img: "assets/img/data_kelas.svg",
);
final _item2 = Items(
  title: "Data Siswa",
  img: "assets/img/data_siswa.svg",
);
final _item3 = Items(
  title: "Pembayaran SPP",
  img: "assets/img/pembayaran_spp.svg",
);
final _item4 = Items(
  title: "Riwayat Pembayaran",
  img: "assets/img/riwayat_pembayaran.svg",
);
final _item5 = Items(
  title: "Laporan",
  img: "assets/img/laporan.svg",
);

class Items {
  String title;
  String img;
  Items({this.title, this.img});

  static final myList = [_item1, _item2, _item3, _item4, _item5];
}
