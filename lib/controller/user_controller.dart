import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:driving_school/models/invoice_model.dart';
import 'package:driving_school/models/user_model.dart';
import 'package:driving_school/utils/authentication_dialogue_widget.dart';
import 'package:driving_school/views/admin/manage_contact.dart';
import 'package:driving_school/views/admin/manage_course.dart';
import 'package:driving_school/views/admin/manage_instructor.dart';
import 'package:driving_school/views/admin/manage_invoice.dart';
import 'package:driving_school/views/admin/manage_rc.dart';
import 'package:driving_school/views/admin/users_list.dart';
import 'package:driving_school/views/user/contact_us.dart';
import 'package:driving_school/views/user/courses.dart';
import 'package:driving_school/views/user/history.dart';
import 'package:driving_school/views/user/invoice.dart';
import 'package:driving_school/views/user/select_instructor.dart';
import 'package:driving_school/views/user/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
      'onTap': const ManageRC(),
    },
    {
      'service name': 'FAQ & Feedback',
      'image': 'assets/headphones 1.png',
      'onTap': const ManageContact(),
    },
  ];

  List<Map<String, dynamic>> userServiceList = [
    {
      'service name': 'Profile',
      'image': 'assets/man 1.png',
      'onTap': const UserProfile()
    },
    {
      'service name': 'Course',
      'image': 'assets/settings 1.png',
      'onTap': const Courses()
    },
    {
      'service name': 'Invoice',
      'image': 'assets/taxation 1.png',
      'onTap': const Invoice(),
    },
    {
      'service name': 'Instructor',
      'image': 'assets/teacher 1.png',
      'onTap': const ChooseInstructor(),
    },
    {
      'service name': 'History',
      'image': 'assets/logout 1.png',
      'onTap': const History(),
    },
    {
      'service name': 'Contact',
      'image': 'assets/headphones 1.png',
      'onTap': const ContactUs(),
    },
  ];

  List<Map<String, dynamic>> usersList = [
    {'name': 'Rohith', 'image': 'assets/man 1.png', 'phone': 9876543210},
    {'name': 'Sanay', 'image': 'assets/man 1.png', 'phone': 9876543210},
    {'name': 'Akbar', 'image': 'assets/man 1.png', 'phone': 9876543210},
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
    {'name': 'Uniform driving hours (colved)', 'price': 1.00},
    {'name': 'Uniform driving hours (colved)', 'price': 112.00},
    {'name': 'Uniform driving hours (colved)', 'price': 39.00},
    {'name': 'Uniform driving hours (colved)', 'price': 112.00},
  ];

  //////////////////////////////////////////////////////////////////////////////

  GlobalKey<FormState> numberKey = GlobalKey<FormState>();
  GlobalKey<FormState> userDetailsKey = GlobalKey<FormState>();
  TextEditingController numberController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();

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
      sendOTP(context);

      FocusScope.of(context).unfocus();
    }
    notifyListeners();
  }

  String? otpError;
  String verificationCode = '';
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  String? otpCode;

  String? _uid;
  String get uid => _uid!;

  Future<void> sendOTP(context) async {
    showDialog(
      context: context,
      builder: (context) {
        return const AuthenticationDialogueWidget(
          message: 'Authenticating, Please wait...',
        );
      },
    );
    String userPhoneNumber = numberController.text.trim();
    await firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+${selectedCountry.phoneCode}$userPhoneNumber",
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {
        otpError = error.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              error.toString(),
              style: GoogleFonts.epilogue(
                color: Colors.white,
              ),
            ),
          ),
        );

        Navigator.pop(context);

        log("Verification failed $error");
      },
      codeSent: (String verificationId, int? forceResendingToken) {
        verificationCode = verificationId;
        log(verificationCode);
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'OTP Sent to +${selectedCountry.phoneCode}$userPhoneNumber',
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    _uid = firebaseAuth.currentUser!.uid;
    log("OTP Sent to +${selectedCountry.phoneCode}$userPhoneNumber");

    notifyListeners();
  }

  verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
    required Function onSuccess,
  }) async {
    showDialog(
      context: context,
      builder: (context) {
        return const AuthenticationDialogueWidget(
          message: 'Verifying OTP...',
        );
      },
    );
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOTP);
      User? user = (await firebaseAuth.signInWithCredential(credential)).user;
      if (user != null) {
        _uid = user.uid;
        onSuccess();
      }
      log("OTP correct");
    } catch (e) {
      Navigator.pop(context);
      log('$e');
    }
    notifyListeners();
  }

  /////////////////DATEBASE OPERATIONS/////////////////////////////////////////
  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await firebaseFirestore.collection('users').doc(_uid).get();

    if (snapshot.exists) {
      log('USER EXISTS');
      return true;
    } else {
      log('NEW USER');
      return false;
    }
  }

  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  Future<void> saveUser(
    String userID,
    String userName,
    String userEmail,
    int userNumber,
  ) async {
    _userModel = UserModel(
      userID: userID,
      userName: userName,
      userEmail: userEmail,
      userNumber: userNumber,
    );

    await firebaseFirestore
        .collection('users')
        .doc(userID)
        .set(_userModel!.toMap());

    notifyListeners();
  }

  Future fetchUserData(String uid) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(uid)
          .get()
          .then((DocumentSnapshot snapshot) {
        _userModel = UserModel(
          userID: snapshot['userID'],
          userName: snapshot['userName'],
          userEmail: snapshot['userEmail'],
          userNumber: snapshot['userNumber'],
          userProPic: snapshot['userProPic'],
          selectedCourse: snapshot['selectedCourse'],
          selectedInstructor: snapshot['selectedInstructor'],
        );
      });
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////////////////////////

  Future<String> storeImagetoStorge(String ref, File file) async {
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    UploadTask uploadTask =
        firebaseStorage.ref().child(ref).putFile(file, metadata);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    log(downloadURL);
    notifyListeners();
    return downloadURL;
  }

  File? proPic;
  String? proPicPath;

  Future<File> pickproPic(context) async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        proPic = File(pickedImage.path);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
    return proPic!;
  }

  Future<void> selectproPic(context) async {
    proPic = await pickproPic(context);
    proPicPath = proPic!.path;
    notifyListeners();
  }

  Future uploadProPic(File proPic, String path, String userID) async {
    try {
      await storeImagetoStorge('$path/$userID', proPic).then((value) async {
        userModel.userProPic = value;

        DocumentReference docRef =
            firebaseFirestore.collection('users').doc(_uid);
        docRef.update({'userProPic': value});
      });
      _userModel = userModel;
      print('Pic uploaded successfully');
      // clearCarsField();
      notifyListeners();
    } catch (e) {
      print('image upload failed :$e');
    }
  }

  InvoiceModel? _invoiceModel;
  InvoiceModel get invoiceModel => _invoiceModel!;

  Future<void> saveInvoice(
    String invoiceUserName,
    String invoiceCourseName,
    String invoiceDate,
    double invoicePrice,
  ) async {
    final date = DateTime.parse(invoiceDate);
    DateTime dueDate = date.add(const Duration(days: 30));
    String formttedDueDate = DateFormat("dd-MMM-yyy").format(dueDate);
    final docs = firebaseFirestore
        .collection('users')
        .doc(firebaseAuth.currentUser!.uid)
        .collection('invoices')
        .doc();
    _invoiceModel = InvoiceModel(
        invoiceID: docs.id,
        invoiceUserName: invoiceUserName,
        invoiceCourseName: invoiceCourseName,
        invoiceDate: invoiceDate,
        invoicePrice: invoicePrice,
        dueDate: formttedDueDate);

    await docs.set(_invoiceModel!.toMap());
    await firebaseFirestore
        .collection('invoices')
        .doc(docs.id)
        .set(_invoiceModel!.toMap());
  }

  List<InvoiceModel> invoiceList = [];
  InvoiceModel? invoices;

  Future fetchInvoices() async {
    try {
      invoiceList.clear();
      CollectionReference invoiceCollection = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection('invoices');
      QuerySnapshot invoiceSnapshot = await invoiceCollection.get();

      for (var doc in invoiceSnapshot.docs) {
        String invoiceID = doc['invoiceID'];
        String invoiceUserName = doc['invoiceUserName'];
        String invoiceCourseName = doc['invoiceCourseName'];
        String invoiceDate = doc['invoiceDate'];
        double invoicePrice = doc['invoicePrice'];
        String dueDate = doc['dueDate'];

        invoices = InvoiceModel(
            invoiceID: invoiceID,
            invoiceUserName: invoiceUserName,
            invoiceCourseName: invoiceCourseName,
            invoiceDate: invoiceDate,
            invoicePrice: invoicePrice,
            dueDate: dueDate);

        invoiceList.add(invoices!);
      }
    } catch (e) {
      print(e);
    }
  }

  Future updateCourse(String courseName) async {
    try {
      userModel.selectedCourse = courseName;

      DocumentReference docRef = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid);
      await docRef.update({'selectedCourse': courseName});
      _userModel = userModel;
      notifyListeners();
      print('/////////Course Updated/////////////');
    } catch (e) {
      print(e);
    }
  }

  Future updateInstructor(String instructorName) async {
    try {
      userModel.selectedInstructor = instructorName;

      DocumentReference docRef = firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid);
      await docRef.update({'selectedInstructor': instructorName});
      _userModel = userModel;
      notifyListeners();
      print('/////////Instructor Updated/////////////');
    } catch (e) {
      print(e);
    }
  }
}
