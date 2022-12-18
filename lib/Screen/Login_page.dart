import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:who_wants_to_be_a_millionaire/Screen/button.dart';
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
  bool _passwordVisible = true;
  @override
  void initState() {
    _passwordVisible = false;
  }

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
              // const SizedBox(
              //   height: 50,
              // ),
              SizedBox(
                height: 100,
                width: 400,
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
                        obscureText: !_passwordVisible,
                        decoration: InputDecoration(
                            suffix: IconButton(
                              icon: Icon(
                                _passwordVisible
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  _passwordVisible = !_passwordVisible;
                                });
                              },
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
                    // GestureDetector(
                    //   onTap: () async {
                    //     try {
                    //       final newUser = _auth.signInWithEmailAndPassword(
                    //           email: txtEmail.text, password: txtPass.text);
                    //       _auth.authStateChanges().listen((event) {
                    //         if (event != null) {
                    //           txtEmail.clear();
                    //           txtPass.clear();
                    //           Navigator.pushNamedAndRemoveUntil(
                    //             context,
                    //             'home',
                    //             (route) => false,
                    //           );
                    //         } else {
                    //           final snackBar = SnackBar(
                    //             content: Text(
                    //               'Email hoặc mật khẩu không đúng',
                    //               style: const TextStyle(
                    //                 color: Colors.white,
                    //                 fontSize: 18.0,
                    //               ),
                    //             ),
                    //             action: SnackBarAction(
                    //               label: 'X',
                    //               textColor: Colors.white,
                    //               onPressed: () {},
                    //             ),
                    //             backgroundColor: Colors.red,
                    //           );
                    //           ScaffoldMessenger.of(context)
                    //               .showSnackBar(snackBar);
                    //         }
                    //       });
                    //     } catch (e) {
                    //       final snackBar = SnackBar(
                    //         content: Text(
                    //           'Lỗi kết nối!',
                    //           style: const TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 18.0,
                    //           ),
                    //         ),
                    //         backgroundColor: Colors.red,
                    //       );
                    //       ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    //     }
                    //   },
                    //   child: Container(
                    //     alignment: Alignment.center,
                    //     width: 250,
                    //     decoration: const BoxDecoration(
                    //         borderRadius: BorderRadius.all(Radius.circular(50)),
                    //         gradient: LinearGradient(
                    //             begin: Alignment.centerLeft,
                    //             end: Alignment.centerRight,
                    //             colors: [
                    //               Color.fromARGB(255, 2, 1, 71),
                    //               Colors.cyan,
                    //               Color.fromARGB(255, 1, 25, 44),
                    //             ])),
                    //     child: const Padding(
                    //       padding: EdgeInsets.all(12.0),
                    //       child: Text(
                    //         'Đăng nhập',
                    //         style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 20,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    buildButtonLogin(
                        context, 'Đăng nhập', txtPass.text, txtEmail.text),
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
                              var user = await signInWithGoogle();
                              print('\n\n$user\n\n');
                              if (user != null) {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'home',
                                  (route) => false,
                                );
                              } else {
                                final snackBar = SnackBar(
                                  content: Text(
                                    'Lỗi đăng nhập!',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
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
