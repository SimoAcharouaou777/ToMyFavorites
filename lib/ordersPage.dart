import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'json_storage.dart';

class OrdersPage extends StatefulWidget {
  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Outfit 1',
      'price': 10,
      'isFavorite': false,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 2',
      'price': 20,
      'isFavorite': false,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 3',
      'price': 30,
      'isFavorite': false,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
    {
      'name': 'Product 4',
      'price': 40,
      'isFavorite': false,
      'image':
          'https://images.bewakoof.com/uploads/grid/app/casual-outfits-for-men-bewakoof-blog-16-1615892384.jpg',
    },
  ];

  final JsonStorage storage = JsonStorage();

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    List<Map<String, dynamic>> favorites = await storage.readFavorites();
    setState(() {
      products.forEach((product) {
        product['isFavorite'] = favorites.any((fav) => fav['name'] == product['name']);
      });
    });
  }

  Future<void> _updateFavorites(Map<String, dynamic> product, bool isFavorite) async {
    List<Map<String, dynamic>> favorites = await storage.readFavorites();
    if (isFavorite) {
      favorites.add(product);
    } else {
      favorites.removeWhere((fav) => fav['name'] == product['name']);
    }
    await storage.writeFavorites(favorites);
  }

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
            return ProductCard(
              product: product,
              onFavoriteChanged: (isFavorite) {
                setState(() {
                  product['isFavorite'] = isFavorite;
                });
                _updateFavorites(product, isFavorite);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final ValueChanged<bool> onFavoriteChanged;

  ProductCard({required this.product, required this.onFavoriteChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Image.network(product['image'], fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product['name']),
          ),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: product['isFavorite'] ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              onFavoriteChanged(!product['isFavorite']);
              if (product['isFavorite']) {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.success,
                  text: 'Added to favorites!',
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
