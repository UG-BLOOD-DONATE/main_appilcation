// ignore_for_file: prefer_const_constructors

import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ug_blood_donate/home.dart';

class F_donors extends StatelessWidget {
  const F_donors({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'this section read a local json file',
      home: FindDonors(),
    );
  }
}

class FindDonors extends StatefulWidget {
  const FindDonors({Key? key}) : super(key: key);

  @override
  State<FindDonors> createState() => _FindDonorsState();
}

class _FindDonorsState extends State<FindDonors> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/user_data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["users"];
    });
  }

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: const Icon(Icons.arrow_back, size: 32.0),
          onPressed: () => Navigator.pop(context, true),
        ),
        centerTitle: true,
        title: const Text(
          'Find Donors',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color.fromARGB(255, 254, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            AnimSearchBar(
              width: 400,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              animationDurationInMilli: 1000,
              helpText: "find don....",
              autoFocus: true,
            ),

            ElevatedButton(
              onPressed: readJson,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(234, 239, 52, 83),
              ),
              child: const Text('Load Data'),
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(5),
                          child: ListTile(
                            leading: Image.network(
                              _items[index]["image"],
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? strackTrace) {
                                return Text('error occured');
                              },
                            ),
                            title: Text(_items[index]["name"]),
                            subtitle: Row(children: [
                              Icon(
                                Icons.location_on_rounded,
                                color: Color.fromARGB(234, 239, 52, 83),
                              ),
                              Text(_items[index]["location"])
                            ]),
                            trailing: Text(_items[index]["booldtype"]),

                            //   child: Stack(children: <Widget>[
                            //     Container(
                            //         height: 50,
                            //         width: 35,
                            //         child: Image.asset(
                            //             'assets/images/Picture1.png')),
                            //     Center(child: Text(_items[index]["booldtype"])),
                            //   ]),
                            // ),
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
