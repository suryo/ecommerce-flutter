import 'package:flutter/material.dart';

class TransactionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions History'),
      ),
      body: ListView.builder(
        itemCount: 10, // Ganti dengan jumlah transaksi yang ada
        itemBuilder: (context, index) {
          // Ganti dengan data transaksi yang sesuai
          String transactionTitle = 'Transaction ${index + 1}';
          String transactionDate = 'Date: ${DateTime.now().toString()}';
          String transactionAmount = 'Amount: \$100'; // Ganti dengan jumlah transaksi yang sesuai

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              title: Text(transactionTitle),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(transactionDate),
                  SizedBox(height: 4),
                  Text(transactionAmount),
                ],
              ),
              trailing: Icon(Icons.arrow_forward_ios), // Icon untuk menuju ke detail transaksi
              onTap: () {
                // Tambahkan navigasi untuk menuju ke detail transaksi di sini
              },
            ),
          );
        },
      ),
    );
  }
}
