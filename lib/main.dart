import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uploaduser/provider/provider.dart';
import 'package:uploaduser/screen/Splash.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => PhotoProvider(),
    child: new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstSplash(),
    ),
  ));
}



