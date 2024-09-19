import 'dart:io';

// Fungsi untuk mengkonversi nilai huruf menjadi nilai angka
double konversiNilai(String nilaiHuruf) {
  switch (nilaiHuruf.toUpperCase()) {
    case 'A':
      return 4.0;
    case 'B':
      return 3.0;
    case 'C':
      return 2.0;
    case 'D':
      return 1.0;
    case 'E':
      return 0.0;
    default:
      return -1.0; // untuk validasi
  }
}

void main() {
  print('==============================================');
  print(' Program Menghitung IPK Mahasiswa');
  print('==============================================');

  int jumlahSemester;

  while (true) {
    stdout.write('Masukkan jumlah semester (min 2, maks 14): ');
    String? inputSemester = stdin.readLineSync();

    try {
      jumlahSemester = int.parse(inputSemester!);
      if (jumlahSemester >= 2 && jumlahSemester <= 14) break;
      print('Jumlah semester tidak valid, harap masukkan nilai antara 2 hingga 14.');
    } catch (e) {
      print('Input tidak valid. ULANGI.');
    }
  }

  // Inisialisasi variabel untuk total SKS dan total NR yang akan digunakan untuk menghitung IPK
  double totalNilai = 0;
  int totalSKS = 0;

  // Variabel untuk menyimpan transkrip
  List<String> transkrip = [];

  for (int i = 1; i <= jumlahSemester; i++) {
    print('--------------------------------------------');
    int jumlahMatkul;

    while (true) {
      stdout.write('Masukkan jumlah mata kuliah semester $i (min 2): ');
      String? inputMatkul = stdin.readLineSync();

      try {
        jumlahMatkul = int.parse(inputMatkul!);
        if (jumlahMatkul >= 2) break;
        print('Jumlah mata kuliah harus minimal 2.');
      } catch (e) {
        print('Input tidak valid. ULANGI.');
      }
    }

    // Inisialisasi variabel untuk menyimpan nilai dan SKS semester ini
    double totalNilaiSemester = 0;
    int totalSKSSemester = 0;

    transkrip.add('Hasil Semester $i:');
    transkrip.add('| Mata Kuliah         | SKS  | Nilai |');
    transkrip.add('|---------------------|------|-------|');

    for (int j = 1; j <= jumlahMatkul; j++) {
      stdout.write('Masukkan nama matkul ke $j: ');
      String namaMatkul = stdin.readLineSync()!;

      int sks;
      while (true) {
        stdout.write('Masukkan jumlah SKS matkul $namaMatkul: ');
        String? inputSKS = stdin.readLineSync();

        try {
          sks = int.parse(inputSKS!);
          if (totalSKSSemester + sks <= 24) break;
          print('Total SKS tidak boleh melebihi 24 per semester.');
        } catch (e) {
          print('Input tidak valid. ULANGI.');
        }
      }

      String nilaiHuruf;
      double nilai;
      while (true) {
        stdout.write('Masukkan nilai matkul (A/B/C/D/E): ');
        nilaiHuruf = stdin.readLineSync()!;
        nilai = konversiNilai(nilaiHuruf);
        if (nilai >= 0) break;
        print('Nilai huruf tidak valid, harap masukkan nilai antara A hingga E.');
      }

      // Tambahkan informasi ke transkrip dalam format tabel
      transkrip.add(
          '| ${namaMatkul.padRight(19)} | ${sks.toString().padLeft(4)} | ${nilaiHuruf.padLeft(5)} |');

      // Hitung total nilai semester
      totalNilaiSemester += nilai * sks;
      totalSKSSemester += sks;
    }

    double nr = totalNilaiSemester / totalSKSSemester;
    transkrip.add('|---------------------|------|-------|');
    transkrip.add('Total SKS Semester $i : $totalSKSSemester');
    transkrip.add('NR Semester $i : ${nr.toStringAsFixed(2)}');
    transkrip.add('-----------------------------------------------');

    // Tambahkan nilai semester ini ke total keseluruhan
    totalNilai += totalNilaiSemester;
    totalSKS += totalSKSSemester;
  }

  // Hitung IPK
  double ipk = totalNilai / totalSKS;

  // Tampilkan transkrip akhir
  print('===============================================');
  print('                Transkrip Nilai                ');
  print('===============================================');
  for (String line in transkrip) {
    print(line);
  }
  print('Total SKS : $totalSKS');
  print('IPK : ${ipk.toStringAsFixed(2)}');
  print('===============================================');
}
