import 'dart:io';
import '../lib/mahasiswa.dart';
import '../lib/matakuliah.dart';
import '../lib/krs.dart';

void main() {
  List<Mahasiswa> daftarMahasiswa = [];
  List<MataKuliah> daftarMataKuliah = [];
  List<KRS> daftarKRS = [];

  while (true) {
    print("\n=== Sistem Akademik ===");
    print("1. Tambah Mahasiswa");
    print("2. Tambah Mata Kuliah");
    print("3. Cetak KRS");
    print("4. Input Nilai Mahasiswa");
    print("5. Transkrip Nilai");
    print("6. Keluar");
    stdout.write("Pilih menu: ");
    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case "1":
        stdout.write("Masukkan NIM Mahasiswa: ");
        String? nim = stdin.readLineSync();
        stdout.write("Masukkan Nama Mahasiswa: ");
        String? nama = stdin.readLineSync();
        stdout.write("Masukkan Semester: ");
        int semester = int.parse(stdin.readLineSync()!);

        daftarMahasiswa.add(Mahasiswa(nim: nim!, nama: nama!, semester: semester));
        print("Mahasiswa berhasil ditambahkan.");
        break;

      case "2":
        stdout.write("Masukkan Kode Mata Kuliah: ");
        String? kode = stdin.readLineSync();
        stdout.write("Masukkan Nama Mata Kuliah: ");
        String? nama = stdin.readLineSync();
        stdout.write("Masukkan Jumlah SKS: ");
        int sks = int.parse(stdin.readLineSync()!);

        daftarMataKuliah.add(MataKuliah(kode: kode!, nama: nama!, sks: sks));
        print("Mata kuliah berhasil ditambahkan.");
        break;

      case "3":
        stdout.write("Masukkan NIM Mahasiswa: ");
        String? nim = stdin.readLineSync();

        var mahasiswa = daftarMahasiswa.firstWhere(
          (mhs) => mhs.nim == nim,
          orElse: () => Mahasiswa(nim: "", nama: "", semester: 0),
        );

        if (mahasiswa.nim.isEmpty) {
          print("Mahasiswa tidak ditemukan.");
          break;
        }

        print("\n=== Daftar Mata Kuliah ===");
        for (int i = 0; i < daftarMataKuliah.length; i++) {
          print("${i + 1}. ${daftarMataKuliah[i].nama} (Kode: ${daftarMataKuliah[i].kode}, SKS: ${daftarMataKuliah[i].sks})");
        }

        stdout.write("Masukkan nomor mata kuliah yang dipilih (pisahkan dengan koma): ");
        String? input = stdin.readLineSync();
        List<int> pilihanMK = input!.split(",").map((e) => int.parse(e) - 1).toList();

        List<MataKuliah> mkDipilih = [];
        for (var index in pilihanMK) {
          if (index >= 0 && index < daftarMataKuliah.length) {
            mkDipilih.add(daftarMataKuliah[index]);
          }
        }

        daftarKRS.add(KRS(mahasiswa: mahasiswa, daftarMataKuliah: mkDipilih));
        print("KRS berhasil dibuat.");
        break;

      case "4":
        stdout.write("Masukkan NIM Mahasiswa: ");
        String? nim = stdin.readLineSync();

        var krs = daftarKRS.firstWhere(
          (k) => k.mahasiswa.nim == nim,
          orElse: () => KRS(mahasiswa: Mahasiswa(nim: "", nama: "", semester: 0), daftarMataKuliah: []),
        );

        if (krs.daftarMataKuliah.isEmpty) {
          print("KRS tidak ditemukan.");
          break;
        }

        for (var mk in krs.daftarMataKuliah) {
          stdout.write("Masukkan nilai untuk mata kuliah ${mk.nama}: ");
          double nilai = double.parse(stdin.readLineSync()!);

          krs.tambahNilai(mk, nilai);
        }
        print("Nilai berhasil dimasukkan.");
        break;

      case "5":
        stdout.write("Masukkan NIM Mahasiswa: ");
        String? nim = stdin.readLineSync();

        var krs = daftarKRS.firstWhere(
          (k) => k.mahasiswa.nim == nim,
          orElse: () => KRS(mahasiswa: Mahasiswa(nim: "", nama: "", semester: 0), daftarMataKuliah: []),
        );

        if (krs.daftarMataKuliah.isEmpty) {
          print("Transkrip tidak ditemukan.");
          break;
        }

        print("\n=== Transkrip Nilai ===");
        print("Mahasiswa: ${krs.mahasiswa.nama} (NIM: ${krs.mahasiswa.nim})");
        for (var nilai in krs.daftarNilai) {
          print("- ${nilai.mataKuliah.nama}: ${nilai.nilai}");
        }
        print("IPK: ${krs.hitungIPK().toStringAsFixed(2)}");
        break;

      case "6":
        print("Sistem ditutup. Terima kasih!");
        exit(0);

      default:
        print("Pilihan tidak valid. Coba lagi.");
    }
  }
}
