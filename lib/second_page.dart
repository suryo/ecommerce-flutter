import 'package:flutter/material.dart';
import 'package:fl_ecommerce/third_page.dart'; // Mengimpor file ThirdPage.dart

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  int result = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penjumlahan Dua Angka'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: num1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Angka Pertama',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: num2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Masukkan Angka Kedua',
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       int num1 = int.tryParse(num1Controller.text) ?? 0;
            //       int num2 = int.tryParse(num2Controller.text) ?? 0;
            //       result = num1 + num2;
            //     });
            //   },
              onPressed: hitungPenjumlahan,
              child: Text('Hitung Penjumlahan'),
            ),
            SizedBox(height: 20.0),
            Text(
              'Hasil Penjumlahan: $result',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPage(
                      angkaPertama: int.tryParse(num1Controller.text) ?? 0,
                    ),
                  ),
                );
              },
              child: Text('Kirim Angka Pertama ke Halaman Ketiga'),
            ),
          ],
        ),
      ),
    );
  }

    void hitungPenjumlahan() {
    setState(() {
        int num1 = int.tryParse(num1Controller.text) ?? 0;
        int num2 = int.tryParse(num2Controller.text) ?? 0;
        result = num1 + num2;
    });
    }

}

