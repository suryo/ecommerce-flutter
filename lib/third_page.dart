import 'package:flutter/material.dart';

class ThirdPage extends StatelessWidget {
  final int angkaPertama;

  ThirdPage({required this.angkaPertama});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'name': 'iPhone',
        'description': 'iPhone is the stylist phone ever',
        'price': 1000,
        'image': 'iphone.png',
      },
      {
        'name': 'Pixel',
        'description': 'Pixel is the most featureful phone ever',
        'price': 800,
        'image': 'pixel.png',
      },
    ];

    int index = angkaPertama == 0 ? 0 : 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Ketiga'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            title: Text(products[index]['name']),
            subtitle: Text(products[index]['description']),
            trailing: Text('\$${products[index]['price']}'),
            leading: Image.asset('assets/${products[index]['image']}'),
          ),
        ],
      ),
    );
  }
}
