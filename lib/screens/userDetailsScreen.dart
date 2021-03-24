import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_user/core/models/user_details_model.dart';
import 'package:qr_user/core/provider/userDetailsProvider.dart';
import 'package:qr_user/core/services/dependecyInjection.dart';
import 'package:qr_user/core/validators/validator.dart';
import 'package:qr_user/widgets/customRectBtn.dart';
import 'package:qr_user/widgets/customTextFormField.dart';

class UserDetailsScreen extends StatefulWidget {
  static const routeName = "/UserDetailsScreen";

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  // final _priceFocusNode = FocusNode();
  Validators _validators = locator<Validators>();
  void _saveForm() {
    if (!_formKey.currentState.validate()) return null;
    _formKey.currentState.save();
    Provider.of<UserdetailsProvider>(context, listen: false)
        .addDetails(_editedDetails);
    Navigator.pop(context);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _editedDetails =
      UserDetailsModel(address: "", name: "", phoneNumber: null);
  var _isInit = true;

  var _initValues = {
    'name': '',
    'address': '',
    'phoneNumber': '',
  };

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     // final userId = ModalRoute.of(context).settings.arguments as String;
  //     // _editedDetails = Provider.of<UserdetailsProvider>(context, listen: false)
  //     //     .findById(userId);
  //     final UserDetailsModel userDetails =
  //         Provider.of<UserdetailsProvider>(context, listen: false)
  //             .userDetailsData;
  //     print("object");
  //     _initValues = {
  //       'name': userDetails.name,
  //       'address': userDetails.address,
  //       'phoneNumber': userDetails.phoneNumber.toString(),
  //     };
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              CustomTextFormField(
                initValues: _initValues["name"],
                keyboardType: TextInputType.name,
                label: "Enter name",
                validators: _validators.nameValidator,
                onSaved: (value) {
                  _editedDetails = UserDetailsModel(
                      address: _editedDetails.address,
                      phoneNumber: _editedDetails.phoneNumber,
                      name: value);
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                initValues: _initValues["phoneNumber"],
                keyboardType: TextInputType.phone,
                label: "Enter phone number",
                validators: _validators.phoneNumberCheck,
                onSaved: (value) {
                  _editedDetails = UserDetailsModel(
                      address: _editedDetails.address,
                      name: _editedDetails.name,
                      phoneNumber: int.parse(value));
                },
              ),
              const SizedBox(height: 12),
              CustomTextFormField(
                initValues: _initValues["address"],
                keyboardType: TextInputType.text,
                label: "Enter address",
                validators: _validators.nameValidator,
                onSaved: (value) {
                  _editedDetails = UserDetailsModel(
                      name: _editedDetails.name,
                      address: value,
                      phoneNumber: _editedDetails.phoneNumber);
                },
              ),
              const SizedBox(height: 12),
              CustomRectangularBtn(
                color: Theme.of(context).accentColor,
                title: "SUBMIT",
                onPressed: _saveForm,
              )
            ],
          ),
        ),
      ),
    );
  }
}
