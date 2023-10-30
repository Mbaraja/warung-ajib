import 'package:flutter/material.dart';
import 'product_description_screen.dart';
import 'product.dart';
import 'payment_screen.dart';
import 'UpdateUserPasswordscreen.dart';

class ProductListView extends StatefulWidget {
  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  List<Product> products = [
    Product(
        'Es Teh Muanis',
        'Es teh seger untuk cuaca semarang yang panas',
        3000,
        'esteh.jpeg'),
    Product(
        'Lumpia',
        'Lumpia isi ayam.',
        2000,
        'lumpia.jpeg'),
    Product(
        'Tempe Mendoan',
        'Tempe yang dibaluri tepung mendoan',
        1000,
        'Mendoan.jpeg'),
    Product(
        'Tahu Bulat',
        'Tahu Bulat digoreng dadakan ',
        1000,
        'tahubulat.jpeg'),
    Product(
        'Risol Mayo',
        'Risol yang berisi mayonaise, telur dan sosis',
        4000,
        'risolmayo.jpeg'),
    // Tambahkan produk lain di sini
  ];

  double totalSale = 0;

  // List untuk menyimpan produk yang dibeli
  List<Product> cartProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Menu makanan & minuman'),
        actions: [
          PopupMenuButton<String>(
            // Menu utama
            onSelected: (value) {
              // Implementasi aksi untuk setiap menu di sini
              if (value == 'Call Center') {
                _showContactDialog('Call Center', '089652098065');
              } else if (value == 'SMS Center') {
                _showContactDialog('SMS Center', '089652098065');
              } else if (value == 'Lokasi/Maps') {
                _showContactDialog('Lokasi/Maps',
                    'https://maps.app.goo.gl/fS3HeWzBbCQgL3oVA');
              } else if (value == 'Update User & Password') {
                // Navigasi ke tampilan UpdateUserPasswordScreen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateUserPasswordScreen(),
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                'Call Center',
                'SMS Center',
                'Lokasi/Maps',
                'Update User & Password'
              ].map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    cartProducts: cartProducts,
                    totalSale: totalSale,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Column(
            children: [
              ListTile(
                leading: Image.asset(product.imagePath),
                title: Text(product.name),
                subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ProductDescriptionScreen(product: product),
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  _startSale(product);
                },
                child: Text('Beli'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _startSale(Product product) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Beli ${product.name}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Harga: Rp ${product.price.toStringAsFixed(0)}'),
                  SizedBox(height: 10),
                  Text('Jumlah:'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal'),
                ),
                TextButton(
                  onPressed: () {
                    double subTotal = product.price * quantity;
                    setState(() {
                      totalSale += subTotal;
                      // Menambahkan produk yang dibeli ke dalam keranjang
                      for (int i = 0; i < quantity; i++) {
                        cartProducts.add(product);
                      }
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Beli'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showContactDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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
