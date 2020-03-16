import 'package:flutter/material.dart';
import 'package:flutterforms/src/bloc/login_bloc.dart';
import 'package:flutterforms/src/bloc/provider.dart';
import 'package:flutterforms/src/pages/login_page.dart';
import 'package:flutterforms/src/providers/user_provider.dart';
import 'package:flutterforms/src/utils/utils.dart' as Utils;

class RegisterPage extends StatelessWidget {
  static final routeName = 'register';
  final userProvider = new UserProvider();

  RegisterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
          _loginForm(context),
        ],
      ),
    );
  }

  _createBackground(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final backPurple = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(63, 63, 156, 1.0),
            Color.fromRGBO(90, 70, 178, 1.0),
          ],
        ),
      ),
    );
    final circle = SafeArea(
      child: Container(
        width: 100.0,
        height: 100.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.05),
        ),
      ),
    );

    return Stack(children: <Widget>[
      backPurple,
      Positioned(
        child: circle,
        top: 90.0,
        left: 30.0,
      ),
      Positioned(
        child: circle,
        top: -40.0,
        right: -30.0,
      ),
      Positioned(
        child: circle,
        bottom: -50.0,
        right: -10.0,
      ),
      Positioned(
        child: circle,
        bottom: 120.0,
        right: 20.0,
      ),
      Positioned(
        child: circle,
        bottom: -50.0,
        left: -20.0,
      ),
      Container(
        padding: EdgeInsets.only(top: 80.0),
        child: Column(
          children: <Widget>[
            Icon(
              Icons.person_pin_circle,
              color: Colors.white,
              size: 100.0,
            ),
            SizedBox(
              height: 10.0,
              width: double.infinity,
            ),
            Text(
              'Leonor Guzman',
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ],
        ),
      ),
    ]);
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 180.0,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Text(
                  'Register',
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 60.0,
                ),
                _createEmail(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _createPassword(bloc),
                SizedBox(
                  height: 30.0,
                ),
                _createButton(bloc, context)
              ],
            ),
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 50.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(0.0, 5.0),
                      spreadRadius: 3.0),
                ]),
          ),
          FlatButton(
            child: Text('Go to Login'),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginPage.routeName),
          ),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.alternate_email,
                  color: Colors.deepPurple,
                ),
                counterText: snapshot.data,
                errorText: snapshot.error,
                hintText: 'example@email.com',
                labelText: 'Email'),
            onChanged: bloc.updateEmail,
          ),
        );
      },
    );
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStrem,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: Colors.deepPurple,
              ),
              labelText: 'Password',
              errorText: snapshot.error,
            ),
            onChanged: bloc.updatePassword,
          ),
        );
      },
    );
  }

  Widget _createButton(LoginBloc bloc, BuildContext context) {
    return StreamBuilder(
      stream: bloc.isValidFormStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          elevation: 0.0,
          color: Colors.deepPurple,
          textColor: Colors.white,
          child: Container(
            child: Text('Email'),
          ),
          onPressed: snapshot.hasData ? () => _login(bloc, context) : null,
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async{
   final res = await userProvider.newUser(bloc.email, bloc.password);
    res['ok']
        ? Navigator.pushNamed(context, LoginPage.routeName)
        : Utils.showAlerts(context, res['msj']);
  }
}
