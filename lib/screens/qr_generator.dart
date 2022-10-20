import 'package:flutter/material.dart';
//import 'package:flutter_qr_genetator/qr_scanner.dart';
//import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ug_blood_donate/utils/firebase.dart';

class QRGenerator extends StatefulWidget {
  const QRGenerator({Key? key}) : super(key: key);

  @override
  _QRGeneratorState createState() => _QRGeneratorState();
}

class _QRGeneratorState extends State<QRGenerator> {
  currentUserId() {
    print("${firebaseAuth.currentUser?.uid}");
    return firebaseAuth.currentUser?.uid;
  }

// This will set the text value
  // void setTextValue(val) {
  //   setState(() {
  //     text = val;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String text = currentUserId();
    return Scaffold(
      appBar: AppBar(
        title: const Text(' QR Generator'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // TextFormField(
                //   decoration: const InputDecoration(
                //     labelText: 'Enter your text for QR code',
                //   ),
                //   onChanged: (val) {
                //     setTextValue(val);
                //   },
                //   maxLines: 1,
                //   keyboardType: TextInputType.text,
                // ),
                QrImage(
                  data: text,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                // ElevatedButton(
                //   onPressed: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (BuildContext context) {
                //       return const qrscanner();
                //     }),
                //   ),
                //   child: const Text('Scanner'),
                //   style: ButtonStyle(
                //     backgroundColor:
                //         MaterialStateProperty.all<Color>(Colors.pink),
                //     shape: MaterialStateProperty.all(
                //       RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(25),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
