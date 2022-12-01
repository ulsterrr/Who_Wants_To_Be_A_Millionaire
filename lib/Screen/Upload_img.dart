import 'package:flutter/material.dart';

class ImageUpload extends StatefulWidget {
  @override
  State<ImageUpload> createState() => ImageUploadState();
}

class ImageUploadState extends State<ImageUpload> {
  late String imageUrl;

  @override
  Widget build(BuildContext context) {
    backgroundColor:
    Colors.white;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Upload Image',
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    border: Border.all(color: Colors.white),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(2, 2),
                        spreadRadius: 2,
                        blurRadius: 1,
                      ),
                    ],
                  ),
                  child: (imageUrl != null)
                      ? Image.network(imageUrl)
                      : Image.network('https://i.imgur.com/sUFH1Aq.png')),
            ],
          ),
        ));
  }
}
