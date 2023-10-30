import 'package:flutter/material.dart';
import 'product.dart';

class PaymentScreen extends StatefulWidget {
  final List<Product> cartProducts;
  final double totalSale;

  PaymentScreen({required this.cartProducts, required this.totalSale});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  double paymentAmount = 0;
  double changeAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartProducts.length,
              itemBuilder: (context, index) {
                final product = widget.cartProducts[index];
                return ListTile(
                  title: Text(product.name),
                  subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                );
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Total Belanja'),
            subtitle: Text('Rp ${widget.totalSale.toStringAsFixed(0)}'),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Jumlah Pembayaran'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  paymentAmount = double.tryParse(value) ?? 0;
                });
              },
            ),
          ),
          Divider(),
          ListTile(
            title: Text('Total Transaksi'),
            subtitle: Text(
                'Rp ${(widget.totalSale + paymentAmount).toStringAsFixed(0)}'),
          ),
          ListTile(
            title: Text('Jumlah Pembayaran'),
            subtitle: Text('Rp ${paymentAmount.toStringAsFixed(0)}'),
          ),
          ListTile(
            title: Text('Kembalian'),
            subtitle: Text(
                'Rp ${(paymentAmount - widget.totalSale).toStringAsFixed(0)}'),
          ),
          ElevatedButton(
            onPressed: () {
              _showPaymentReceipt(context);
            },
            child: Text('Bayar'),
          ),
        ],
      ),
    );
  }

  void _showPaymentReceipt(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nota Pembayaran'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('Produk yang Dibeli:'),
              for (var product in widget.cartProducts)
                Text(
                    '${product.name} - Rp ${product.price.toStringAsFixed(0)}'),
              Divider(),
              ListTile(
                title: Text('Total Belanja'),
                subtitle: Text('Rp ${widget.totalSale.toStringAsFixed(0)}'),
              ),
              ListTile(
                title: Text('Jumlah Pembayaran'),
                subtitle: Text('Rp ${paymentAmount.toStringAsFixed(0)}'),
              ),
              ListTile(
                title: Text('Kembalian'),
                subtitle: Text(
                    'Rp ${(paymentAmount - widget.totalSale).toStringAsFixed(0)}'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
