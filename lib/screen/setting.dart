import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uploaduser/screen/Login.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<SharedPreferences> preferences = SharedPreferences.getInstance();
  var version;

  showLogoutDialog(context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            content: Container(
              height: 200,
              child: Column(
                children: <Widget>[
                  Text('Are you sure you want to logout?',
                      style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                          color: Colors.black,
                          child: Text(
                            'Logout',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            SharedPreferences prefs = await preferences;
                            prefs.clear();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Login(),
                                ),
                                (route) => false);
                          }),
                      RaisedButton(
                        child: Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  checkVersion() async{
     PackageInfo packageInfo = await PackageInfo.fromPlatform();
     setState(() {
        version = packageInfo.version;
     });
     print(version);
     
  }

  @override
  void initState() {
    // checkVersion();
    SchedulerBinding.instance!.addPostFrameCallback((_) => checkVersion());
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Logout",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              
                IconButton(
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                    icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          ),
            Divider(thickness: 2,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("version $version",style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              ],
            ),
          ),
            Divider(thickness: 2,),
        ],
      ),
    );
  }
}
