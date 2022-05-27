import 'package:flutter/material.dart';

class Favorite extends StatelessWidget {
  const Favorite({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
      child: Center(child: Text("No favourite List")),
      ),
    );
  }
}