import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_user/core/models/user_details_model.dart';
import 'package:qr_user/core/provider/userDetailsProvider.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/handlingNotifications.dart';

class GeneratePage extends StatefulWidget {
  static const routeName = "/generate-qr";

  @override
  State<StatefulWidget> createState() => GeneratePageState();
}

bool showQr = true;

class GeneratePageState extends State<GeneratePage> {
  String qrData = ""; // already generated qr code when the page opens
  var _isInit = true;

  var _initValues = {
    'name': '',
    'address': '',
    'phoneNumber': '',
  };

  @override
  void initState() {
    super.initState();
    handleNotifications(context);
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      try {
        final _provider =
            Provider.of<UserdetailsProvider>(context, listen: false);
        _provider.accessDetails();
        final UserDetailsModel userDetails = _provider.userDetailsData;
        if (userDetails.name == null) {
          _initValues = {
            'name': '',
            'address': '',
            'phoneNumber': '',
          };
        } else {
          _initValues = {
            'name': userDetails.name,
            'address': userDetails.address,
            'phoneNumber': userDetails.phoneNumber.toString(),
          };
        }

        print("${userDetails.name} ${userDetails.phoneNumber}");
      } catch (e) {
        print(e);
      }
    }
    // _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              showQr
                  ? Text("Not yet generated")
                  : QrImage(
                      data:
                          '{"name": "${_initValues["name"]}", "address": "${_initValues["address"]}", "phoneNumber": "${_initValues["phoneNumber"]}"}'),
              const SizedBox(
                height: 40.0,
              ),
              CustomRectangularBtn(
                onPressed: () {
                  setState(() {
                    showQr = false;
                  });
                },
                title: "Generate QR",
                color: Theme.of(context).accentColor,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// CustomRectangularBtn(
//                 onPressed: () async {
//                   if (qrdataFeed.text.isEmpty) {
//                     setState(() {
//                       qrData = "";
//                     });
//                   } else {
//                     setState(() {
//                       qrData = qrdataFeed.text;
//                     });
//                   }
//                 },
//                 title: "Generate QR",
//                 color: Theme.of(context).accentColor,
//               ),