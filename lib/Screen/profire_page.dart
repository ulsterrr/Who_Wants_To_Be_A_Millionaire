import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfirePage extends StatelessWidget {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtCPass = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cập nhật tài khoản'),
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
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 100,
                width: 550,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 325,
                height: 550,
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
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Chọn ảnh đại diện",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        controller: txtName,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.user,
                              color: Colors.red,
                            ),
                            hintText:
                                'Name: ${_auth.currentUser!.displayName == null ? 'Username' : _auth.currentUser!.displayName!}',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
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
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            hintText:
                                'Email: ${_auth.currentUser!.email == null ? '' : _auth.currentUser!.email!}',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        controller: txtPass,
                        obscureText: true,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.red,
                            ),
                            labelText: "Nhập vào mật khẩu",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        controller: txtCPass,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.eyeSlash,
                              color: Colors.red,
                            ),
                            labelText: "Xác nhận mật khẩu",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (txtPass.text != txtCPass.text) {
                          final snackBar = SnackBar(
                              content: Text('Mật khẩu không trùng khớp!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          try {
                            final user =
                                _auth.currentUser!.updatePassword(txtPass.text);
                            final snackBar = SnackBar(content: Text('susses'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          } catch (e) {
                            final snackBar =
                                SnackBar(content: Text('Có lỗi xảy ra!'));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        }
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
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            'Cập nhật',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
