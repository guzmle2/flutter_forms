import 'dart:convert';

import 'package:flutterforms/src/models/Product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider {
  final String _url = 'https://flutter-varios-2020.firebaseio.com/';

  Future<bool> createProduct(Product product) async {
    final url = '$_url/products.json';
    final resp = await http.post(url, body: productToJson(product));
    final decodeData = json.decode(resp.body);
    return true;
  }

  Future<bool> updateProduct(Product product) async {
    final url = '$_url/products/${product.id}.json';
    final resp = await http.put(url, body: productToJson(product));
    final decodeData = json.decode(resp.body);
    return true;
  }

  Future<List<Product>> getProducts() async {
    final url = '$_url/products.json';
    final resp = await http.get(url);
    final List<Product> retorno = new List();
    final Map<String, dynamic> decodeData = json.decode(resp.body);
    if (decodeData == null) return [];
    decodeData.forEach((id, product) {
      final temp = new Product.fromJson(product);
      temp.id = id;
      retorno.add(temp);
    });
    return retorno;
  }

  Future<bool> deleteProduct(String id) async {
    final url = '$_url/products/$id.json';
    final resp = await http.delete(url);
    return true;
  }
}
