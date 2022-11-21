import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupPage extends StatelessWidget {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  TextEditingController txtCPass = TextEditingController();
  final _authe = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tạo tài khoản'),
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
                      height: 10,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/ailatrieuphu.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
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
                            labelText: "Nhập vào tên đăng nhập",
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
                        controller: txtEmail,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            labelText: "Nhập vào email",
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
                        obscureText: true,
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
                      onTap: () async {
                        if (txtPass == txtCPass) {
                          final snackBar =
                              SnackBar(content: Text('Mật khẩu trùng khớp!'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          try {
                            final newUser =
                                _authe.createUserWithEmailAndPassword(
                                    email: txtEmail.text,
                                    password: txtPass.text);
                            if (newUser != null) {
                              Navigator.pop(context, 'Đăng ký thành công!');
                            } else {
                              final snackBar = SnackBar(
                                  content: Text('Tài khoản không hợp lệ'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
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
                            'Đăng ký',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.facebook,
                                color: Colors.blue)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.google,
                              color: Colors.redAccent,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.cyan,
                            )),
                      ],
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
