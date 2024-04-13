import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPage extends StatefulWidget {
  final int userId = 1;
  const CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late Future<List<dynamic>> _carts;

  @override
  void initState() {
    super.initState();
    _showAlert();
    _reloadCarts();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    reloadPage();
  }

  Future<void> reloadPage() async {
      print('harusnya ini reload page');
    // Panggil metode untuk me-reload halaman atau melakukan tugas tertentu
    _reloadCarts(); // Contoh: Me-reload data pada halaman cart
  }

  void showAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome to Cart"),
          content: Text("You have entered the Cart page."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showAlert() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Welcome to Cart"),
          content: Text("You have entered the Cart page."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _reloadCarts() async {
    setState(() {
      _carts = fetchCarts();
      _showAlert();
    });
  }

  Future<List<dynamic>> fetchCarts() async {
    final response = await http.get(Uri.parse(
        'http://api.zonainformatika.com/api/users/${widget.userId}/carts'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load carts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: RefreshIndicator(
        onRefresh: _reloadCarts,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: FutureBuilder<List<dynamic>>(
            future: _carts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final carts = snapshot.data!;
                if (carts.isEmpty) {
                  return Center(child: Text('No items in cart'));
                }
                return ListView.builder(
                  itemCount: carts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cart = carts[index];
                    return ListTile(
                      title: Text(cart['title'] ?? ''),
                      subtitle: Text(
                          'Price: \$${cart['price']}, Quantity: ${cart['quantity']}'),
                      leading: cart['thumbnail'] != null
                          ? Image.network(cart['thumbnail'])
                          : Icon(Icons.image_not_supported),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deleteCart(cart['id']);
                        },
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> deleteCart(int cartId) async {
    final response = await http
        .delete(Uri.parse('http://api.zonainformatika.com/api/carts/$cartId'));
    if (response.statusCode == 200) {
      // Cart berhasil dihapus, reload tampilan
      _reloadCarts();
    } else {
      // Gagal menghapus cart, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to delete cart'),
      ));
    }
  }
}
