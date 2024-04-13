import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Map<String, dynamic>> _productDetail;

  @override
  void initState() {
    super.initState();
    _productDetail = fetchProductDetail();
  }

  Future<Map<String, dynamic>> fetchProductDetail() async {
    final response =
        await http.get(Uri.parse('http://api.zonainformatika.com/api/products/${widget.productId}'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load product detail');
    }
  }

  Future<void> addToCart(int productId, int quantity) async {
    final response = await http.post(
      Uri.parse('http://api.zonainformatika.com/api/carts'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_id': 1,
        'product_id': productId,
        'quantity': quantity,
      }),
    );

    // if (response.statusCode == 200) {
    //   print('Product added to cart successfully');
    //   // Implement your logic after adding product to cart
    // } else {
    //   throw Exception('Failed to add product to cart');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _productDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final productDetail = snapshot.data!;
            List<dynamic> images = json.decode(productDetail['images']);

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        PageView.builder(
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return Image.network(images[index]);
                          },
                        ),
                        Positioned(
                          top: 16,
                          left: 16,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${productDetail['discount_percentage']}% Off',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Title: ${productDetail['title']}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Price: \$${productDetail['price']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Discount: ${productDetail['discount_percentage']}%',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Rating: ${productDetail['rating']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Brand: ${productDetail['brand']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Category: ${productDetail['category']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Description: ${productDetail['description']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      addToCart(productDetail['id'], 1);
                    },
                    child: Text('Add to Cart'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
