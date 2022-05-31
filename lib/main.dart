import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:uploaduser/provider/provider.dart';
import 'package:uploaduser/screen/Splash.dart';
const favorites_box = "favorites";
const api_box = "api_box";
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox(favorites_box);
  await Hive.openBox(api_box);
  runApp(
    StreamProvider<InternetConnectionStatus>(
      initialData: InternetConnectionStatus.connected,
        create: (_) {
          return InternetConnectionChecker().onStatusChange;
        },
      child: ChangeNotifierProvider(
        
      create: (_) => PhotoProvider(),
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirstSplash(),
      ),
      ),
    ));
}



