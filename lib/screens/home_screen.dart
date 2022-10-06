import 'dart:ui';

import 'package:flutter/material.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu),
                    SizedBox(width: 160.0,),
                    Icon(Icons.qr_code),
                    Icon(Icons.notification_add),
                  ],
                ),
                ListTile(
                  title: const Text(
                    'Welcome home',
                    style: TextStyle(color: Colors.white54),
                  ),
                  subtitle: const Text(
                    'Batricia Salfiora',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  trailing: ClipRRect(
                    clipBehavior: Clip.hardEdge,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset('images/mark.jpg'),
                  ),
                ),
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 250, 248, 248),
                    radius: 50,
                    child: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 36.0,
                    child: Text(
                      'AB+',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                  ),
                  title: const Text(
                    '28 blood bag',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text(
                    'The total blood you donate',
                    style: TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: const ListTile(
                        title: Text(
                          'Its time to donor!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle:
                            Text('Click to find the loction of the donor!'),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.orange,
                          child: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                        )),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.0),
                          topRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        )),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Service',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    height: 250,
                    width: 120.0,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/rafiki.png"),
                          fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.0),
                          topRight: Radius.circular(40.0),
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 10),
                          child: const Card(
                            child: Icon(Icons.search,
                            color: Colors.yellowAccent,),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, bottom: 20),
                          child: const Text('Find\nPatient',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.0
                          ),),
                        ),
                       
                      ],
                    ),
                  )
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: const BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
            ),
          ),
        ],
      ),
    );
  }
}
