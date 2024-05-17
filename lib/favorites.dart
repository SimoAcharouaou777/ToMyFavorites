import 'package:flutter/material.dart';
import 'json_storage.dart';

class FavoritesPage extends StatelessWidget {
  final JsonStorage storage = JsonStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: storage.readFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorites yet'));
          } else {
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: snapshot.data!.map((product) {
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
                      Text('\$${product['price']}'),
                    ],
                  ),
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
