import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uploaduser/provider/provider.dart';
import 'package:uploaduser/screen/UserDetails.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  fetchData() {
    Provider.of<PhotoProvider>(context, listen: false).callPhotoApi();
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      fetchData();
    });
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(body: Consumer<PhotoProvider>(
      builder: (context, data, __) {
        if (data.photos!.length != 0) {
          return body(data);
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text("Loading.."),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          );
        }
      },
    ));
  }

  Widget body(data) {
    double h = MediaQuery.of(context).size.height;

    return Container(
            //  color: Colors.deepOrange,
            child: GridView.count(
              controller: _controller,
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
              shrinkWrap: true,
              childAspectRatio: 2.3 / 2.8,
              children: data.photos.map<Widget>((e) {
                if (e == data.photos.length - 1) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserDetailsScreen(
                                    id: e.id,
                                  )));
                    },
                    child: Column(
                      children: [
                        Card(
                            elevation: 2,
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Image.network(e.picture.toString()),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${e.title.toString()}.${e.firstName.toString()} ${e.lastName.toString()}",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    ),
                  );
                }
              }).toList(),
            ),
          );
      
  }
}
