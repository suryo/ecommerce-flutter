import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<dynamic>> _carts;

  @override
  void initState() {
    super.initState();
    _carts = fetchCarts();
  }

  Future<List<dynamic>> fetchCarts() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/carts/user/5'));
    if (response.statusCode == 200) {
      return json.decode(response.body)['carts'];
    } else {
      throw Exception('Failed to load carts');
    }
  }

  Future<void> removeFromCart(int cartId) async {
    final response = await http.delete(Uri.parse('https://dummyjson.com/carts/$cartId'));

    if (response.statusCode == 200) {
      print('Product removed from cart successfully');
      // Implement your logic after removing product from cart
    } else {
      throw Exception('Failed to remove product from cart');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Padding(
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
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Your Cart',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: carts.length,
                      itemBuilder: (BuildContext context, int index) {
                        final cart = carts[index];
                        final products = cart['products'];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cart ${index + 1}',
                              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              itemBuilder: (BuildContext context, int index) {
                                final product = products[index];
                                return ListTile(
                                  leading: Image.network(
                                    product['thumbnail'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(product['title']),
                                  subtitle: Text('Price: \$${product['price']}, Quantity: ${product['quantity']}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      removeFromCart(cart['id']);
                                    },
                                  ),
                                );
                              },
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Total: \$${cart['total']}, Discounted Total: \$${cart['discountedTotal']}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      // Logika untuk checkout
                    },
                    child: Text('Checkout'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
