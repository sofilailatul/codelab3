void main() {
  String namaLengkap = "Sofi Lailatul Aniftasrari";
  String nim = "2241760073";

  for (int i = 2; i <= 201; i++) {
    bool isPrime = true;
    for (int j = 2; j <= i / 2; j++) {
      if (i % j == 0) {
        isPrime = false;
        break;
      }
    }
    if (isPrime) {
      print("Bilangan prima: $i");
      print("Nama: $namaLengkap");
      print("NIM: $nim");
      print("");
    }
  }
}
