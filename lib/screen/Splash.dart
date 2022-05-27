import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uploaduser/screen/HomeScreen.dart';
import 'package:uploaduser/screen/Login.dart';
import 'package:uploaduser/screen/dashboard.dart';

class FirstSplash extends StatefulWidget {
  @override
  _FirstSplashState createState() => _FirstSplashState();
}

class _FirstSplashState extends State<FirstSplash> {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  String? loginStatus = 'uploaduser';

  checkLoginCredentials() async {
    SharedPreferences prefs = await preferences;
    setState(() {
      loginStatus = prefs.getString('loginStatus');
    });

    Timer(Duration(seconds: 4), () async {
      //  Student Login  Credentials

      //  Parent Login  Credentials
      if (loginStatus == "ivisitUser") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => dashboard(),
        ));
      }
      //  Parent And Student LoginPage
      else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login(),
        ));
      }
    });
  }

  @override
  void initState() {
    checkLoginCredentials();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  'assets/profile.png',
                ),
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "I-Visit",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            )
            // SizedBox(height: MediaQuery.of(context).size.height * .20),
            // Theme(
            //     data: Theme.of(context).copyWith(accentColor: Colors.blue),
            //     child: Container(
            //       height: 25,
            //       width: 25,
            //       child: CircularProgressIndicator(
            //         strokeWidth: 3,
            //         backgroundColor: Colors.black,
            //         valueColor:
            //             new AlwaysStoppedAnimation<Color>(Colors.orange),
            //       ),
            //     ))
          ],
        ),
      ),
    );
  }
}
