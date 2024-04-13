import 'package:flutter/material.dart';
import 'package:fl_ecommerce/modules/screens/welcome/home_page.dart';
import 'package:fl_ecommerce/modules/screens/products/products_page.dart';
import 'package:fl_ecommerce/modules/screens/cart/cart_page.dart';
import 'package:fl_ecommerce/modules/screens/transactions/transactions_page.dart';
import 'package:fl_ecommerce/modules/screens/account/account_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _selectedIndex = 0;
  int _cartItemCount = 10; // Jumlah barang dalam keranjang
  late String _username;

late GlobalKey<CartPageState> cartPageKey; // Pindahkan deklarasi ke sini

  List<Widget> _pages = [
    HomePage(),
    ProductsPage(),
    CartPage(), // Gunakan GlobalKey di CartPage
    TransactionsPage(),
    AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _getUsername();
    cartPageKey = GlobalKey<CartPageState>(); 
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
      appBar: AppBar(
        title: Text('Landing'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFFD4F00),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sidebar',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Welcome, $_username!', // Display username here
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text('Home'),
              onTap: () {
                _navigateToPage(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Privacy Policy'),
              onTap: () {
                _navigateToPage(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Terms & Conditions'),
              onTap: () {
                _navigateToPage(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text('Information On Data Protections'),
              onTap: () {
                _navigateToPage(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      _cartItemCount.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.orange, // Warna item yang dipilih
        unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
        onTap: _navigateToPage,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
      print('Index page: $index'); // Cetak indeks halaman yang dipilih

    if (index == 2) {
      print('harusnya ini di cart');
      // Jika halaman yang dipilih adalah CartPage, tampilkan alert
      cartPageKey.currentState?.showAlert();
      print('harusnya ini di cart');
    }
  }
}
