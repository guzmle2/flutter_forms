import 'package:flutter/material.dart';
import 'package:flutterforms/src/bloc/provider.dart';
import 'package:flutterforms/src/pages/home_page.dart';
import 'package:flutterforms/src/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.routeName,
        routes: {
          HomePage.routeName: (BuildContext context) => HomePage(),
          LoginPage.routeName: (BuildContext context) => LoginPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple
        ),
      ),
    );
  }
}

