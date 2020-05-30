import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final formKey = new GlobalKey<FormState>();
  String _email, _password;


  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
    Widget build(BuildContext context) {
      final logo = Container(
          height: 200.0, width: 150.0, child: Image.asset("assets/logo.png"));

      final email = TextFormField(
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _email = val,
        decoration: InputDecoration(
          hintText: 'Correo',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

      final password = TextFormField(
        autofocus: false,
        obscureText: true,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _password = val,
        decoration: InputDecoration(
          hintText: 'Contraseña',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
        ),
      );

      final loginButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: Container(
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF319966), Color(0xFF2F9BC5)],
              ),
            ),
            child: MaterialButton(
              minWidth: 200.0,
              height: 55.0,
              onPressed: (){},
              child: Text('INGRESAR', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      );
      final facebookButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: Container(
            width: 114.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              border: Border.all(width: 2.0, color: Color(0xFF3b5998)),
            ),
            child: MaterialButton(
              minWidth: 50.0,
              height: 42.0,
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0.0),
                    width: 15.0,
                    height: 15.0,
                    child: Image.asset("assets/facebook.png"),
                  ),
                  Text('Facebook', style: TextStyle(color: Color(0xFF3b5998))),
                ],
              ),
            ),
          ),
        ),
      );
      final googleButton = Padding(
        padding: EdgeInsets.symmetric(vertical: 5.0),
        child: Material(
          borderRadius: BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: Container(
            width: 114.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
              border: Border.all(width: 2.0, color: Color(0xFFF04335)),
            ),
            child: MaterialButton(
              minWidth: 50.0,
              height: 42.0,
              onPressed: (){},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(0.0),
                    width: 15.0,
                    height: 15.0,
                    child: Image.asset("assets/google.png"),
                  ),
                  Text(' Google', style: TextStyle(color: Color(0xFFF04335))),
                ],
              ),
            ),
          ),
        ),
      );

      final forgotLabel = Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            'Recuperar contraseña',
            style: TextStyle(color: Colors.black54),
          ),
          onPressed: () {},
        ),
      );

      final registarLabel = Container(
        alignment: Alignment.center,
        child: FlatButton(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No tienes cuenta? ',
                style: TextStyle(color: Colors.black54),
              ),
              Text(
                'Registrate',
                style:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          onPressed: () {},
        ),
      );

      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(height: 48.0),
              Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    email,
                    SizedBox(height: 8.0),
                    password,
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              forgotLabel,
              loginButton,
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  "O Ingresa usando",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: Row(
                  children: <Widget>[
                    facebookButton,
                    Expanded(child: Divider(color: Colors.transparent)),
                    googleButton,
                  ],
                ),
              ),
              registarLabel
            ],
          ),
        ),
      );
  }
}
