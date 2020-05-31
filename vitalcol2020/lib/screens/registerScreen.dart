import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = new GlobalKey<FormState>();
  String _nombre, _apellido, _celular, _correo, _contrasena, _contrasena2;

  Future<Null> register() async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _correo.trim(), password: _contrasena.trim())
        .then(
      (currentUser) async {
        Firestore.instance
            .collection("users")
            .document(currentUser.user.uid)
            .setData(
              {
                "id_usuario": currentUser.user.uid,
                "nombre_usuario": _nombre.trim(),
                "apellido_usuario": _apellido.trim(),
                "celular": _celular.trim(),
                "email": _correo.trim()
              },
            )
            .then((result) => Navigator.pushReplacementNamed(context, '/home'))
            .catchError((err) => print(err));
      },
    ).catchError(
      (err) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Ups!"),
              content: Text("Ocurrio un error, vuelve a intentarlo"),
              actions: <Widget>[
                FlatButton(
                  child: Text("Volver"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Formato de email invalido';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 6) {
      return 'La Contraseña debe tener minimo 6 caracteres';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final barra = AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Color(0xFF319966),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        "Registrate",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );

    final nombre = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        autofocus: false,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _nombre = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'Nombre',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final apellido = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        autofocus: false,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _apellido = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_outline),
          labelText: 'Apellido',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final celular = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        autofocus: false,
        validator: (val) {
          return val.isEmpty ? "Este campo es obligatorio" : null;
        },
        onSaved: (val) => _celular = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.phone),
          labelText: 'Celular',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final correo = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        validator: emailValidator,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        onSaved: (val) => _correo = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: 'Correo',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final contrasena = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        validator: pwdValidator,
        onSaved: (val) => _contrasena = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          labelText: 'Contraseña',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final contrasena2 = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: TextFormField(
        autofocus: false,
        obscureText: true,
        validator: pwdValidator,
        onSaved: (val) => _contrasena2 = val,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          labelText: 'Verificar Contraseña',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        ),
      ),
    );

    final registrar = Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 40.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
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
              onPressed: () async {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  if (_contrasena.trim() == _contrasena2.trim()) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Container(
                            height: 100.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Color(0xFF319966),
                                valueColor: new AlwaysStoppedAnimation<Color>(
                                    Colors.white),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    register();
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Ups!"),
                        content: Text(
                            "Las Contraseñas no coinciden, vuelve a intentarlo"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Volver"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                'REGISTRARSE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: barra,
      body: ListView(
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                nombre,
                apellido,
                celular,
                correo,
                contrasena,
                contrasena2,
              ],
            ),
          ),
          registrar,
        ],
      ),
    );
  }
}
