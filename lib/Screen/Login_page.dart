import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Forgot_page.dart';
import 'Signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

class LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPass = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void click() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
                width: 400,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 325,
                height: 530,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('images/ailatrieuphu.png'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Đăng nhập tài khoản của bạn",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 260,
                      height: 60,
                      child: TextField(
                        controller: txtEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            suffix: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.red,
                            ),
                            hintText: "Nhập vào email",
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
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
                            hintText: 'Nhập vào mật khẩu',
                            labelText: "Mật Khẩu",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 30, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPage()),
                              );
                            },
                            child: const Text(
                              "Quên mật khẩu",
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final newUser = _auth.signInWithEmailAndPassword(
                              email: txtEmail.text, password: txtPass.text);
                          _auth.authStateChanges().listen((event) {
                            if (event != null) {
                              txtEmail.clear();
                              txtPass.clear();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'home',
                                (route) => false,
                              );
                            } else {
                              final snackBar = SnackBar(
                                  content:
                                      Text('Email hoặc mật khẩu không đúng'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                        } catch (e) {
                          final snackBar =
                              SnackBar(content: Text('Lỗi kết nối server'));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                            'Đăng nhập',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(
                              color: Colors.black, fontStyle: FontStyle.normal),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupPage()),
                            );
                          },
                          child: Text(
                            'Tạo tài khoản',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                            onPressed: click,
                            icon: const Icon(FontAwesomeIcons.facebook,
                                color: Colors.blue)),
                        IconButton(
                            onPressed: () async {
                              signInWithGoogle();
                            },
                            icon: const Icon(
                              FontAwesomeIcons.google,
                              color: Colors.redAccent,
                            )),
                        IconButton(
                            onPressed: click,
                            icon: const Icon(
                              FontAwesomeIcons.twitter,
                              color: Colors.cyan,
                            )),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
