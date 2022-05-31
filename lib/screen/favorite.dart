import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uploaduser/screen/UserDetails.dart';

import '../main.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: Hive.box(favorites_box).listenable(),
          builder: (context, Box box, child) {
            List names = List.from(box.values);
            print("offline data $names");
            if(names.length == 0){
              return Center(child: Text("No favorite yet."));
            }

            return ListView(children: [
              body(names),
              // ...names.map((e) => body(e))
            ]);
          }),
    );
  }

  Widget body(data) {
    double h = MediaQuery.of(context).size.height;

    return Container(
      //  color: Colors.deepOrange,
      child: GridView.count(
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        shrinkWrap: true,
        crossAxisSpacing: 0,
        childAspectRatio: 2.3 / 2.8,
        children: data.map<Widget>((e) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(
                            id: e["id"],
                            offline: true,
                            data: e,
                          )));
            },
            child: Column(
              children: [
                Card(
                    elevation: 2,
                    child: Container(
                        height: MediaQuery.of(context).size.height * 0.25,
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
                              child: Image.network(e["picture"].toString()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${e["title"].toString()}.${e["firstName"].toString()} ${e["lastName"].toString()}",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ))),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
