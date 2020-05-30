import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File imageFile;
  final picker = ImagePicker();

  Future openGallery() async {
    final picture= await picker.getImage(source: ImageSource.gallery);
    this.setState((){
      imageFile=File(picture.path);
    });
    Navigator.of(context).pop();
  }

  Future openCamera() async {
    final picture= await picker.getImage(source: ImageSource.camera);
    this.setState((){
      imageFile=File(picture.path);
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
                  Padding(padding: EdgeInsets.all(8.0),),
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
  //retorna  texto si no se ha seleccionado alguna imagen
  Widget _decideImageView(){
    if(imageFile==null){
      return Text("No se ha seleccionado ninguna imagen",
      style: TextStyle(color:Colors.white, fontSize: 15),);
    }
    else{
      return  Image.file(
        imageFile,
        width: MediaQuery.of(context).size.width, 
        height: MediaQuery.of(context).size.height-200);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Cámara"),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [const Color(0xFF319966), const Color(0xFF2F9BC5)],
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          stops: [0.0,1.0],
          tileMode: TileMode.clamp)
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _decideImageView(),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(10)
                ),
                onPressed: () {
                  _showChoiceDialog(context);
                },
                child: Text("Selecciona la imagen"),
              )
            ],
          ),
        ),
      ),
    );
  }
}