import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _username;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  Future<void> _getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? ''; // Retrieve username from SharedPreferences
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // Image Slider for Banners
          CarouselSlider(
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
            items: [
              'https://via.placeholder.com/500x200', // Banner 1
              'https://via.placeholder.com/500x200', // Banner 2
              'https://via.placeholder.com/500x200', // Banner 3
            ].map((item) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          // Welcome Message
          _username.isNotEmpty
              ? Text(
                  'Welcome, $_username!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Container(), // Display username if available, otherwise display an empty container
          SizedBox(height: 20),
          // Other Widgets Below the Image Slider
          // Kategori produk atau pilihan terpopuler
          Text(
            'Kategori Populer',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                // Daftar kategori atau pilihan terpopuler
                CategoryItem(icon: Icons.phone_android, label: 'Smartphone'),
                CategoryItem(icon: Icons.laptop, label: 'Laptop'),
                CategoryItem(icon: Icons.headset, label: 'Headset'),
                CategoryItem(icon: Icons.watch, label: 'Smartwatch'),
                // Tambahkan kategori lainnya sesuai kebutuhan
              ],
            ),
          ),
          SizedBox(height: 20),
          // Produk terbaru
          Text(
            'Produk Terbaru',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Daftar produk terbaru
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 1', // Nama produk
            price: 100, // Harga produk
            discountPercentage: 10, // Persentase diskon (jika ada)
            rating: 4.5, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 2', // Nama produk
            price: 200, // Harga produk
            discountPercentage: null, // Tidak ada diskon
            rating: 4.0, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 3', // Nama produk
            price: 150, // Harga produk
            discountPercentage: 5, // Persentase diskon (jika ada)
            rating: 4.8, // Rating produk
          ),
          SizedBox(height: 20),
          // Produk terlaris
          Text(
            'Produk Terlaris',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Daftar produk terlaris
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 4', // Nama produk
            price: 180, // Harga produk
            discountPercentage: null, // Tidak ada diskon
            rating: 4.7, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 5', // Nama produk
            price: 220, // Harga produk
            discountPercentage: 8, // Persentase diskon (jika ada)
            rating: 4.6, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 6', // Nama produk
            price: 250, // Harga produk
            discountPercentage: 12, // Persentase diskon (jika ada)
            rating: 4.9, // Rating produk
          ),
          SizedBox(height: 20),
          // Rekomendasi produk
          Text(
            'Rekomendasi Produk',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Daftar rekomendasi produk
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 7', // Nama produk
            price: 130, // Harga produk
            discountPercentage: 15, // Persentase diskon (jika ada)
            rating: 4.4, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 8', // Nama produk
            price: 170, // Harga produk
            discountPercentage: null, // Tidak ada diskon
            rating: 4.3, // Rating produk
          ),
          ProductItem(
            imageUrl: 'https://via.placeholder.com/150', // URL gambar produk
            title: 'Product 9', // Nama produk
            price: 190, // Harga produk
            discountPercentage: 7, // Persentase diskon (jika ada)
            rating: 4.2, // Rating produk
          ),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan kategori produk
class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFFD4F00),
            child: Icon(icon, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(label),
        ],
      ),
    );
  }
}

// Widget untuk menampilkan item produk
class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final double? discountPercentage;
  final double rating;

  const ProductItem({
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.discountPercentage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Image.network(imageUrl),
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Price: \$${price.toStringAsFixed(2)}'),
            if (discountPercentage != null)
              Text('Discount: ${discountPercentage!.toStringAsFixed(2)}%'),
            Text('Rating: $rating'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Tambahkan logika untuk menambahkan produk ke keranjang belanja di sini
          },
        ),
      ),
    );
  }
}
