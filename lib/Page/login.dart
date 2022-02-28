import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sepah/Models/user_model.dart';
import 'package:sepah/Static/url.dart';
import 'package:sepah/Static/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formkey = GlobalKey<FormState>();

  String? userName;
  String? password;
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();

  bool validAndSaveUser() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void ValidAndSubmitUser() {
    if (validAndSaveUser()) {
      formkey.currentState!.reset();
      setState(() {
        Login();
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      child: SafeArea(
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 60.0,
                      ),
                      Image.asset(
                        "assets/logo1.png",
                        height: 200.0,
                      ),
                      const SizedBox(
                        height: 70.0,
                      ),
                      Container(
                        // color: Colors.red,
                        height: myHeight * 0.1,
                        width: myWidth * 0.9,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: controllerUser,
                                validator: (value) => value!.isEmpty
                                    ? "لطفا نام کاربری خود را وارد کنید"
                                    : null,
                                onSaved: (value) => userName = value,
                                // initialValue: "farid",
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.person),
                                    hintText: "نام کاربری ",
                                    hintStyle: TextStyle(fontSize: 14.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.red,
                        height: myHeight * 0.1,
                        width: myWidth * 0.9,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: TextFormField(
                                controller: controllerPass,
                                validator: (value) => value!.isEmpty
                                    ? "لطفا رمز عبور خود را وارد کنید"
                                    : null,
                                onSaved: (value) => password = value,
                                // initialValue: "123",
                                obscureText: true,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    icon: Icon(Icons.lock),
                                    hintText: "رمز عبور ",
                                    hintStyle: TextStyle(fontSize: 14.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: myHeight * 0.15,
                  // width: myWidth,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: InkWell(
                        onTap: ValidAndSubmitUser,
                        child: Container(
                          height: myHeight * 0.07,
                          width: myWidth * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Center(
                            child: Text(
                              "ورود",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Login() async {
    String url = UrlStaticFile.url + 'user/login';
    var data = json.encode({"username": userName, "password": password});
    final responce = await http.post(Uri.parse(url),
        body: data, headers: {"Content-Type": "application/json"});
    if (responce.statusCode == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> result = json.decode(responce.body);
      prefs.setString('token', result['token']);
      UserStaticFile.user_id = result["user_id"];
      UserStaticFile.username = utf8.decode(result["username"].codeUnits);
      UserStaticFile.first_name = utf8.decode(result["first_name"].codeUnits);
      UserStaticFile.last_name = utf8.decode(result["last_name"].codeUnits);
      UserStaticFile.nameKarbari = utf8.decode(result["nameKarbari"].codeUnits);
      UserStaticFile.shobe = utf8.decode(result["shobe"].codeUnits);
      UserStaticFile.phone_number =
          utf8.decode(result["phone_number"].codeUnits);
      UserStaticFile.shahrestan = utf8.decode(result["shahrestan"].codeUnits);
      UserStaticFile.shahrestan_int = result["shahrestan_int"];
      UserStaticFile.code = result["code"];
      UserStaticFile.token = result['token'];
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const Home(),
      ));
    } else {
      final snackBar = SnackBar(
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
        duration: const Duration(seconds: 2),
        content: const Text(
          "نام کاربری یا رمز عبور وارد شده صحیح نیست لطفا دوباره امتحان کنید",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: "Vazir",
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
