import 'mahasiswa.dart';
import 'matakuliah.dart';
import 'nilai.dart';

class KRS {
  final Mahasiswa mahasiswa;
  final List<MataKuliah> daftarMataKuliah;
  final List<Nilai> daftarNilai = [];

  KRS({
    required this.mahasiswa,
    required this.daftarMataKuliah,
  });

  void tambahNilai(MataKuliah mk, double nilai) {
    daftarNilai.add(Nilai(mataKuliah: mk, nilai: nilai));
  }

  double hitungIPK() {
    if (daftarNilai.isEmpty) return 0.0;
    double totalNilai = 0.0;
    int totalSKS = 0;
    for (var nilai in daftarNilai) {
      totalNilai += nilai.nilai * nilai.mataKuliah.sks;
      totalSKS += nilai.mataKuliah.sks;
    }
    return totalNilai / totalSKS;
  }
}
