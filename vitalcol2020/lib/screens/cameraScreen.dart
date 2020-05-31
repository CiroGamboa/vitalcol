import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.Dart' as http;
import 'package:toast/toast.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  File imageFile;
  final picker = ImagePicker();

  Future openGallery() async {
    final picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future openCamera() async {
    final picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Seleccione"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Galería"),
                    onTap: () {
                      openGallery();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Cámara"),
                    onTap: () {
                      openCamera();
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  //dialogo de confirmación de envío
  Future<void> _showConfirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Enviar imagen"),
            content: Text("¿Está seguro que desea enviar esta imagen?"),
            actions: <Widget>[
              _buttonCancelDialog(),
              SizedBox(
                width: 5,
              ),
              _buttonAceptDialog()
            ],
          );
        });
  }

  Widget _buttonCancelDialog() {
    return RaisedButton(
        color: Colors.white,
        textColor: Colors.black,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(
          "Cancelar",
        ));
  }

  Widget _buttonAceptDialog() {
    return RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          Navigator.of(context).pop();
          Toast.show("Se ha enviado la imágen", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        },
        child: Text(
          "Aceptar",
        ));
  }

  //retorna  texto si no se ha seleccionado alguna imagen
  Widget _decideImageView() {
    if (imageFile == null) {
      return Text(
        "No se ha seleccionado ninguna imagen",
        //style: TextStyle(color: Colors.white, fontSize: 15),
      );
    } else {
      return Image.file(imageFile,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 250);
    }
  }

  Widget _buttonSelectImage() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [const Color(0xFF319966), const Color(0xFF2F9BC5)],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: FlatButton(
          onPressed: () {
            _showChoiceDialog(context);
          },
          child: Text("Seleccionar imagen", style: TextStyle(color: Colors.white)),
        ));
  }

  Widget _buttonPostImage() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                colors: [const Color(0xFF319966), const Color(0xFF2F9BC5)],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp)),
        child: FlatButton(
          onPressed: () {
            _showConfirmDialog(context);
          },
          child: Text("Enviar", style: TextStyle(color: Colors.white),),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Cámara", style: TextStyle(color: Color(0xFF319966)),),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _decideImageView(),
              _buttonSelectImage(),
              _buttonPostImage()
            ],
          ),
        ),
      ),
    );
  }
}
