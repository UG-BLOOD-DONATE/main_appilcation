//import 'package:alan_voice/alan_voice.dart';

import 'package:flutter/material.dart';
import 'package:ug_blood_donate/Doctor_side/screen/create_event.dart';

void main() {
  runApp(const Request_page());
}

class Request_page extends StatefulWidget {
  const Request_page({super.key});

  @override
  State<Request_page> createState() => _Request_pageState();
}

class _Request_pageState extends State<Request_page> {
  _Request_pageState() {
    /// Init Alan Button with project key from Alan Studio
    //AlanVoice.addButton("2facc136948794a72cc9accffc83bf352e956eca572e1d8b807a3e2338fdd0dc/stage");

    /// Handle commands from Alan Studio
    // AlanVoice.onCommand.add((command) {
    //   debugPrint("got new command ${command.toString()}");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(248, 249, 247, 247),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const ListTile(
                    title: Text(
                      '  Hello! Nusrat.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    subtitle: Text(
                      '  Hello! Nusrat.',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    trailing: Icon(Icons.notification_add, size: 40.0),
                  ),
                  const Divider(),
                  const Divider(),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Hospital',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const Divider(),
                  const TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Select Blood Group',
                      suffixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const Divider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage()),
                          );
                        },
                        child: Card(
                          color: Colors.red,
                          child: Container(
                            decoration: BoxDecoration(
                              //color: const Color.fromARGB(255, 243, 248, 247),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 182, 2, 2)
                                      .withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextButton(
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                              ),
                              onPressed: () {},
                              child: const Text('Send Request'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 4.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.search,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Find Donars',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 4.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.bloodtype,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Request',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 8.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.campaign_outlined,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Campaign',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      //color: const Color.fromARGB(255, 243, 248, 247),
                      borderRadius: BorderRadius.circular(50.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 255, 254, 254)
                              .withOpacity(0.5),
                          spreadRadius: 20,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 32),
                              child: Column(
                                children: const [
                                  Icon(Icons.assistant_navigation,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Assistant',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 4.0),
                              child: Column(
                                children: const [
                                  Icon(
                                    Icons.map_outlined,
                                    color: Colors.red,
                                    size: 40.0,
                                  ),
                                  Text(
                                    'Map',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                //color: const Color.fromARGB(255, 243, 248, 247),
                                borderRadius: BorderRadius.circular(50.0),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 255, 254, 254)
                                            .withOpacity(0.5),
                                    spreadRadius: 20,
                                    blurRadius: 7,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32.0, horizontal: 8.0),
                              child: Column(
                                children: const [
                                  Icon(Icons.report,
                                      color: Colors.red, size: 40.0),
                                  Text(
                                    'Report',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Donation Request'),
                        Text('See all'),
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('images/dice1.png'),
                            Column(
                              children: [
                                const Text(
                                  'Sabrina Binte Zahir',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Labaid Hospital',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                Text(
                                  'Science Lab, Dhaka 1205',
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                                Text(
                                  'Time: 02:00 PM, 19 January 2022',
                                  style: TextStyle(color: Colors.grey[500]),
                                )
                              ],
                            ),
                            Image.asset('images/dice1.png')
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Decline',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'Donate Now',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
