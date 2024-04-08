import 'package:flutter/material.dart';

class WalkthroughPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Walkthrough'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selamat datang di SCommerce',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            Text(
              'Langkah-langkah untuk memulai aplikasi:',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.0),
            ListTile(
              leading: Icon(Icons.navigate_next),
              title: Text('Langkah 1: Buka aplikasi SCOMMERCE'),
            ),
            ListTile(
              leading: Icon(Icons.navigate_next),
              title: Text('Langkah 2: Temukan materi belajar yang menarik'),
            ),
            ListTile(
              leading: Icon(Icons.navigate_next),
              title: Text('Langkah 3: Ikuti langkah-langkahnya dan pelajari dengan baik'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login'); // Navigasi ke halaman berikutnya setelah walkthrough selesai
              },
              child: Text('Lanjutkan'),
            ),
          ],
        ),
      ),
    );
  }
}
