import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtCPass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông tin tài khoản'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 2, 1, 71),
                Colors.cyan,
                Color.fromARGB(255, 1, 25, 44),
              ])),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.2,
              ),
              Container(
                width: size.width * 0.8,
                height: size.height * 0.6,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(_auth
                                  .currentUser!.photoURL ==
                              null
                          ? 'https://cdn.icon-icons.com/icons2/1378/PNG/512/avatardefault_92824.png'
                          : _auth.currentUser!.photoURL!),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: txtName,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: '${_auth.currentUser!.displayName!}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        readOnly: true,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: '${_auth.currentUser!.email!}',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfirePage()),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 250,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromARGB(255, 2, 1, 71),
                                  Colors.cyan,
                                  Color.fromARGB(255, 1, 25, 44),
                                ])),
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              Text(
                                ' Chỉnh sửa',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
