import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uploaduser/screen/HomeScreen.dart';
import 'package:uploaduser/screen/dashboard.dart';
import 'package:uploaduser/services/data_api.dart';
import 'package:uploaduser/widget/RoundedButton.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  //var response;
  showLoaderDialog(context) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            // height: 210,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.grey.withOpacity(0.5),
            //       spreadRadius: 5,
            //       blurRadius: 7,
            //       offset: Offset(0, 3), // changes position of shadow
            //     ),
            //   ],
            //   gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       colors: <Color>[Colors.deepOrange, Colors.red]),
            // ),
            child: Column(
              children: [
                SizedBox(height: 100,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage(
                    'assets/profile.png',
                  ),
              )),
            ),
                ),
               
              ],
            ),
          ),
         
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 8, top: 8), //

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.deepOrangeAccent,
                        style: BorderStyle.solid),
                  ),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: new BorderSide(
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                          style: BorderStyle.solid)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: new BorderSide(
                          width: 0,
                          color: Colors.black.withOpacity(0.5),
                          style: BorderStyle.solid)),
                  hintText: "Email",
                  hintStyle: new TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),

                  counterText: '',
                )),
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 8, top: 8), //

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(
                        width: 1.5,
                        color: Colors.deepOrangeAccent,
                        style: BorderStyle.solid),
                  ),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: new BorderSide(
                          width: 1.5,
                          color: Colors.black.withOpacity(0.5),
                          style: BorderStyle.solid)),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      borderSide: new BorderSide(
                          width: 0,
                          color: Colors.black.withOpacity(0.5),
                          style: BorderStyle.solid)),
                  hintText: "Password",
                  hintStyle: new TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),

                  counterText: '',
                )),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: RoundedButtonWidget(
                buttonText: "Login",
                onPressed: () async {
                  String email = emailController.text;
                  if (email.isEmpty || passwordController.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Please fill all the fields');
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => dashboard()));
                  } else {
                    SharedPreferences prefs = await preferences;
                    showLoaderDialog(context);
                    var response =
                        await login(email, passwordController.text);
                    print(response);
                    print("token");
                    print(response['token'].toString());
                    prefs.setString('loginStatus', 'ivisitUser');
                    prefs.setString('userKey', response['token'].toString());
                    if (response["token"] == "QpwL5tke4Pnpja7X4") {
                      Navigator.pop(context);
                      showLoaderDialog(context);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => dashboard()));
                    } else {

                      Fluttertoast.showToast(
                          msg: response["error"],
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.CENTER,
                          textColor: Colors.red,
                          fontSize: 15.0);
                      Navigator.pop(context);
                    }
                  }
                }),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 50);
    var controllpoint = Offset(50, size.height);
    var endpoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(
        controllpoint.dx, controllpoint.dy, endpoint.dx, endpoint.dy);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
