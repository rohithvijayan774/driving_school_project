import 'package:country_picker/country_picker.dart';
import 'package:driving_school/views/admin/manage_course.dart';
import 'package:driving_school/views/admin/manage_instructor.dart';
import 'package:driving_school/views/admin/manage_invoice.dart';
import 'package:driving_school/views/admin/users_list.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserController extends ChangeNotifier {
  //////////////////////////////////////////////////////////////////////////////
  List<Map<String, dynamic>> adminServiceList = [
    {
      'service name': 'Users',
      'image': 'assets/man 1.png',
      'onTap': const UsersList()
    },
    {
      'service name': 'Manage Course',
      'image': 'assets/settings 1.png',
      'onTap': const ManageCourse()
    },
    {
      'service name': 'Manage Invoice',
      'image': 'assets/taxation 1.png',
      'onTap': const ManageInvoice(),
    },
    {
      'service name': 'Manage Instructor',
      'image': 'assets/teacher 1.png',
      'onTap': const ManageInstructor(),
    },
    {
      'service name': 'Manage RC Renewal',
      'image': 'assets/logout 1.png',
      'onTap': 'const UsersList()'
    },
    {
      'service name': 'FAQ & Feedback',
      'image': 'assets/headphones 1.png',
      'onTap': 'const UsersList()'
    },
  ];

  List<Map<String, dynamic>> usersList = [
    {'name': 'Rohith', 'image': 'assets/man 1.png'},
    {'name': 'Sanay', 'image': 'assets/man 1.png'},
    {'name': 'Akbar', 'image': 'assets/man 1.png'},
  ];
  List<Map<String, dynamic>> instrctrList = [
    {'name': 'Rohith', 'image': 'assets/teacher 1.png'},
    {'name': 'Sanay', 'image': 'assets/teacher 1.png'},
    {'name': 'Akbar', 'image': 'assets/teacher 1.png'},
    {'name': 'Rohith', 'image': 'assets/teacher 1.png'},
    {'name': 'Sanay', 'image': 'assets/teacher 1.png'},
    {'name': 'Akbar', 'image': 'assets/teacher 1.png'},
  ];
  List<Map<String, dynamic>> courseList = [
    {'name': 'Uniform driving hours (colved)', 'price': 39.00},
    {'name': 'Uniform driving hours (colved)', 'price': 112.00},
    {'name': 'Uniform driving hours (colved)', 'price': 39.00},
    {'name': 'Uniform driving hours (colved)', 'price': 112.00},
  ];

  //////////////////////////////////////////////////////////////////////////////
  GlobalKey<FormState> numberKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();

  //---------------For country Pick-------------------

  Country selectedCountry = Country(
      phoneCode: "91",
      countryCode: "IN",
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: "India",
      example: 'India',
      displayName: 'India',
      displayNameNoCountryCode: "IN",
      e164Key: "");

  showCountries(context) {
    showCountryPicker(
      context: context,
      countryListTheme: const CountryListThemeData(bottomSheetHeight: 600),
      onSelect: (value) {
        selectedCountry = value;
        notifyListeners();
      },
    );
  }

  void setPhonenumber(String value, context) {
    numberController.text = value;
    if (value.length == 10) {
      sendOTP(value);

      FocusScope.of(context).unfocus();
    }
    notifyListeners();
  }

  sendOTP(String number) async {
    await Fluttertoast.showToast(
        msg: "This is Center Short Toast",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    print('sending OTP to $number');
    notifyListeners();
  }
}
