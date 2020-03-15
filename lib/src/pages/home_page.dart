import 'package:flutter/material.dart';
import 'package:flutterforms/src/bloc/provider.dart';

class HomePage extends StatelessWidget {
  static final routeName = 'home';

  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: <Widget>[
          Text('Email: ${bloc.email}'),
          Divider(),
          Text('Password:  ${bloc.password}'),
        ],
      ),
    );
  }
}
