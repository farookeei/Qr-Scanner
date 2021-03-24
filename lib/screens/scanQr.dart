import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'dart:convert';

class ScanPage extends StatefulWidget {
  static const routeName = "/scan";

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String name = "";
  String address = "";
  String phoneNumber = "";

  String qrCodeResult = "Not Yet Scanned";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              "$name \n $address \n $phoneNumber",
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            qrCodeResult != "Not Yet Scanned"
                ? CustomRectangularBtn(
                    color: Theme.of(context).accentColor,
                    horizontalPadding: 15,
                    title: "Add",
                    onPressed: () {},
                  )
                : CustomRectangularBtn(
                    title: "Open Scanner",
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      String codeSanner =
                          await BarcodeScanner.scan(); //barcode scnner
                      setState(() {
                        // qrCodeResult = codeSanner;
                        Map<String, dynamic> map = jsonDecode(codeSanner);
                        name = map["name"];
                        address = map["address"];
                        phoneNumber = map["phoneNumber"];
                      });

                      // try{
                      //   BarcodeScanner.scan()    this method is used to scan the QR code
                      // }catch (e){
                      //   BarcodeScanner.CameraAccessDenied;   we can print that user has denied for the permisions
                      //   BarcodeScanner.UserCanceled;   we can print on the page that user has cancelled
                      // }
                    },
                    horizontalPadding: 15.0,
                  ),
          ],
        ),
      ),
    );
  }

  //its quite simple as that you can use try and catch staatements too for platform exception
}
