import 'package:flutter/material.dart';
import 'package:flutterforms/src/bloc/provider.dart';
import 'package:flutterforms/src/models/Product.dart';
import 'package:flutterforms/src/pages/product_page.dart';
import 'package:flutterforms/src/providers/productos_provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  HomePage({Key key}) : super(key: key);
  final productsProvider = new ProductsProvider();

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: _createList(),
      floatingActionButton: _buttonAdd(context),
    );
  }

  _buttonAdd(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: () => Navigator.pushNamed(context, ProductPage.routeName),
      child: Icon(Icons.add),
    );
  }

  Widget _createList() {
    return FutureBuilder(
        future: productsProvider.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          final List<Product> producst = snapshot.data;
          print(producst);
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: producst.length,
                  itemBuilder: (BuildContext context, int i) =>
                      _createItemProduct(context, producst[i]))
              : Center(child: CircularProgressIndicator());
        });
  }

  _createItemProduct(BuildContext context, Product producst) {
    return Dismissible(
      onDismissed: (direction) {
        productsProvider.deleteProduct(producst.id);
      },
      child: ListTile(
        title: Text('${producst.title} - ${producst.value}'),
        subtitle: Text(producst.id),
        onTap: () => Navigator.pushNamed(context, ProductPage.routeName, arguments: producst),
      ),
      background: Container(
        color: Colors.red,
      ),
      key: UniqueKey(),
    );
  }
}
