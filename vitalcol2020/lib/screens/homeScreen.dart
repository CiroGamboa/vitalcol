import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nombre = "";

  @override
  void initState() {
    super.initState();
    carritoInfo();
  }

  carritoInfo() {
    FirebaseAuth.instance.currentUser().then((currentUser) =>
        (currentUser == null)
            ? nombre = ""
            : Firestore.instance
                .collection("users")
                .document(currentUser.uid)
                .get()
                .then(
                (DocumentSnapshot result) {
                  setState(() {
                    nombre = result.data['nombre_usuario'];
                  });
                },
              ).catchError((err) => print(err)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Flexible(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    "Hola $nombre te damos la bienvenida!",
                    style: TextStyle(
                      color: Color(0xFF319966),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                  Image.asset('assets/enfermera.png'),
                ],
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 10.0, right: 10.0, bottom: 15.0),
                child: MaterialButton(
                  onPressed: ()=> Navigator.pushNamed(context, "/camera"),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF319966), Color(0xFF2F9BC5)],
                      ),
                    ),
                    child: Center(
                      child: Text("Agregar Formula Medica",
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 10.0, right: 10.0, bottom: 15.0),
                child: MaterialButton(
                  onPressed: ()=> Navigator.pushNamed(context, "/calendar"),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF319966), Color(0xFF2F9BC5)],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Ver Citas y Medicamentos Programados",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
