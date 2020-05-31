import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarController _calendarController;

  String _id = "";

  Map<int, String> meses = {
    1: "Ene.",
    2: "Feb.",
    3: "Mar.",
    4: "Abr.",
    5: "May.",
    6: "Jun.",
    7: "Jul.",
    8: "Ago.",
    9: "Sep.",
    10: "Oct.",
    11: "Nov.",
    12: "Dic."
  };

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    FirebaseAuth.instance.currentUser().then((value) {
      setState(() {
        _id = value.uid;
      });
    });
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          "${meses[DateTime.now().month]} ${DateTime.now().day}, ${DateTime.now().year}",
          style: TextStyle(
            color: Color(0xFF319966),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection("Medicamentos")
            .where("idUsuario", isEqualTo: _id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text(
                  "No tienes programado aun ningun medicamento para el dia de hoy"),
            );
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15.0),
                  child: Container(
                    width: double.infinity,
                    height: 120.0,
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          width: 80,
                          child: Center(
                            child: Text("Fecha"),
                          ),
                        ),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              topLeft: Radius.circular(20.0),                              
                            ),
                            child: Container(
                              color: index % 2 == 0
                                  ? Color(0xFF319966)
                                  : Color(0xFF2F9BC5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: snapshot.data.documents.length,
            );
          }
        },
      ),
    );
  }
}
