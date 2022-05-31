import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uploaduser/models/data.dart';
import 'package:uploaduser/services/data_api.dart';
import 'package:uploaduser/services/userModel.dart';

import '../main.dart';

class UserDetailsScreen extends StatefulWidget {
  PhotosApi? photosApi = PhotosApi();
  var id;
  bool? offline;
  var data;

  UserDetailsScreen({this.id, this.photosApi, this.offline, this.data});
  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  @override
  void initState() {
    // getdata();
    // PhotosApi().userInformation(widget.id);
    userInformation(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: const Text(
            'Visit Details',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.offline == false
                  ? Container(
                      child: FutureBuilder(
                        future: userInformation(widget.id),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                                child: CircularProgressIndicator(
                              backgroundColor: Colors.red,
                            ));
                          } else {
                            var information = snapshot.data;
                            if (information.length == 0) {
                              return Center(
                                  child: Text(
                                "No Details ",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ));
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      if (Hive.box(favorites_box)
                                          .containsKey(widget.id)) {
                                        Hive.box(favorites_box)
                                            .delete(widget.id);
                                      } else {
                                        Hive.box(favorites_box).put(
                                          widget.id,
                                          information,
                                        );
                                      }
                                      setState(() {});
                                    },
                                    icon: Icon(Hive.box(favorites_box)
                                            .containsKey(widget.id)
                                        ? Icons.favorite
                                        : Icons.favorite_border)),
                                Center(
                                  child: Image.network(
                                    information["picture"],
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${information["title"]}. ${information["firstName"]} ${information["lastName"]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Text(
                                    "Gender: ${information["gender"]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Date Of Birth: ${DateFormat('d MMM, yyyy').format(DateTime.parse(information["dateOfBirth"]))}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Register Date: ${DateFormat('d MMM, yyyy').format(DateTime.parse(information["registerDate"]))}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Text(
                                    "Email: ${information["email"]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                    "Phone: ${information["phone"]}",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 15),
                                  child: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 10, top: 5),
                                  child: Text(
                                      "${information["location"]["street"]},${information["location"]["city"]},${information["location"]["state"]},${information["location"]["country"]}"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                      "https://i0.wp.com/www.cssscript.com/wp-content/uploads/2018/03/Simple-Location-Picker.png?fit=561%2C421&ssl=1"),
                                )
                              ],
                            );
                          }
                        },
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                             
                                Hive.box(favorites_box).delete(widget.id);
                              
                              setState(() {});
                            },
                            icon: Icon(
                                Hive.box(favorites_box).containsKey(widget.id)
                                    ? Icons.favorite
                                    : Icons.favorite_border)),
                        Center(
                          child: Image.network(
                            widget.data["picture"],
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "${widget.data["title"]}. ${widget.data["firstName"]} ${widget.data["lastName"]}",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: Text(
                            "Gender: ${widget.data["gender"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Date Of Birth: ${DateFormat('d MMM, yyyy').format(DateTime.parse(widget.data["dateOfBirth"]))}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Register Date: ${DateFormat('d MMM, yyyy').format(DateTime.parse(widget.data["registerDate"]))}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: Text(
                            "Email: ${widget.data["email"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            "Phone: ${widget.data["phone"]}",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 15),
                          child: Text(
                            "Address",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                              "${widget.data["location"]["street"]},${widget.data["location"]["city"]},${widget.data["location"]["state"]},${widget.data["location"]["country"]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                              "https://i0.wp.com/www.cssscript.com/wp-content/uploads/2018/03/Simple-Location-Picker.png?fit=561%2C421&ssl=1"),
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
