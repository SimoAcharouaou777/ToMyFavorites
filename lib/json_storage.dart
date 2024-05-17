import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class JsonStorage {
  ValueNotifier<List<Map<String, dynamic>>> favoritesNotifier = ValueNotifier([]);

  JsonStorage() {
    _loadFavorites();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/favorites.json');
  }

  Future<void> _loadFavorites() async {
    favoritesNotifier.value = await readFavorites();
  }

  Future<List<Map<String, dynamic>>> readFavorites() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        return List<Map<String, dynamic>>.from(json.decode(contents));
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<void> writeFavorites(List<Map<String, dynamic>> favorites) async {
    final file = await _localFile;
    await file.writeAsString(json.encode(favorites));
    favoritesNotifier.value = favorites;
  }
}
