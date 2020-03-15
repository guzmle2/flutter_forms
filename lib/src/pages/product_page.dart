import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:flutterforms/src/models/Product.dart';
import 'package:flutterforms/src/providers/productos_provider.dart';
import 'package:flutterforms/src/utils/utils.dart' as Utils;

class ProductPage extends StatefulWidget {
  static final routeName = 'product';

  ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() {
    return _ProductPageState();
  }
}

class _ProductPageState extends State<ProductPage> {
  final faker = new Faker();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Product product = new Product();
  final productsProvider = new ProductsProvider();
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Product prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      product = prodData;
    } else {
      product.title = faker.company.position();
      product.value = faker.randomGenerator.integer(1000).toDouble();
    }
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Product'),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.photo_size_select_actual,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.camera_alt,
              ),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  _createName(),
                  _createPrice(),
                  _createAvailable(context),
                  SizedBox(height: 20.0),
                  _createButton(context),
                ],
              ),
            ),
          ),
        ));
    ;
  }

  Widget _createName() {
    return TextFormField(
      initialValue: product.title,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Product',
      ),
      onSaved: (value) => product.title = value,
      validator: (value) => value.length < 3 ? 'Input name to product' : null,
    );
  }

  Widget _createPrice() {
    return TextFormField(
      initialValue: product.value.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Price',
      ),
      onSaved: (value) => product.value = double.parse(value),
      validator: (value) => Utils.isNumeric(value) ? null : 'Invalid price',
    );
  }

  _createButton(BuildContext context) {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      icon: Icon(Icons.save),
      label: Text('Save'),
      onPressed: _uploading ? null : _submitAction,
    );
  }

  _submitAction() {
    if (!formKey.currentState.validate()) return;

    setState(() => _uploading = true);
    formKey.currentState.save();
    product.id != null
        ? productsProvider.updateProduct(product)
        : productsProvider.createProduct(product);

    showSnackBar('Successfull!');
    Navigator.pop(context);
  }

  Widget _createAvailable(BuildContext context) {
    return SwitchListTile(
      title: Text('Available'),
      value: product.available,
      activeColor: Theme.of(context).primaryColor,
      onChanged: (bool value) => (setState(() => product.available = value)),
    );
  }

  Widget showSnackBar(String msj) {
    final snackBar = SnackBar(
      content: Text(msj),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
