import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class OrdersPage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Outfit 1',
      'price': 10,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 2',
      'price': 20,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 3',
      'price': 30,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 4',
      'price': 40,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: products.map((product) {
            return ProductCard(product: product);
          }).toList(),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(widget.product['image'], fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.product['name']),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
              if (isFavorite) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Added to favorites',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
