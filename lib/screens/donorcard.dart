import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:ug_blood_donate/components/custom_card.dart';
import 'package:ug_blood_donate/screens/qr_generator.dart';

class DonorCard extends StatefulWidget {
  @override
  State<DonorCard> createState() => _DonorCardState();
}

class _DonorCardState extends State<DonorCard> {
  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout for
    // the major Material Components.
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.navigate_before_sharp,
            color: Colors.black,
            size: 24.0,
          ),
          title: const Text("Donor Card"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.edit_note_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                // do something
              },
            )
          ],
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),

        // body is the majority of the screen.
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.pink,
                    child: Column(
                      children: <Widget>[
                        Positioned(
                            child: Row(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                            ),
                            Text(
                              "Donor Card",
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 140,
                            ),
                            const Text(
                              "Blood Donation",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            )
                          ],
                        )),
                        Row(
                          children: const [
                            Positioned(
                              left: 0.0,
                              child: Text(
                                "1500",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 70,
                                ),
                              ),
                            ),
                            Text(
                              "Points ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Positioned(
                              left: 0.0,
                              child: Text(
                                "****** ***** **** ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Text(
                              "7056 ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              width: 145,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Positioned(
                              left: 0.0,
                              child: Text(
                                "MAWEJJE ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const Text(
                              "MARK WILLIAM ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 90,
                            ),
                            CustomCard(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (_) => QRGenerator()));
                              },
                              child: Image.asset('assets/images/qr.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
