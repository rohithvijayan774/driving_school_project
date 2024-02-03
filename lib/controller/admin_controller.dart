import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driving_school/models/course_model.dart';
import 'package:driving_school/models/instructor_model.dart';
import 'package:driving_school/models/invoice_model.dart';
import 'package:driving_school/models/user_model.dart';
import 'package:driving_school/views/admin/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  String adminID = 'admin@driving';
  String adminPassword = '123456';
  GlobalKey<FormState> adminLoginKey = GlobalKey<FormState>();
  TextEditingController adminIDController = TextEditingController();
  TextEditingController adminPasswordController = TextEditingController();

  ///////////////////DATABASE OPERATIONS////////////////////////////////////////
  String? _adminid;
  String get adminid => _adminid!;
  Future<void> adminLogin(String username, String password, context) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: username, password: password);
      _adminid = firebaseAuth.currentUser!.uid;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const AdminHome(),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  List<UserModel> usersDataList = [];
  UserModel? users;

  Future fetchUsers() async {
    try {
      usersDataList.clear();

      CollectionReference usersCollection =
          firebaseFirestore.collection('users');
      QuerySnapshot usersSnapshot = await usersCollection.get();

      for (var doc in usersSnapshot.docs) {
        String userID = doc['userID'];
        String userName = doc['userName'];
        String userEmail = doc['userEmail'];
        int userNumber = doc['userNumber'];
        String userProPic = doc['userProPic'];
        String selectedCourse = doc['selectedCourse'] ?? 'No Course Selected';
        String selectedInstructor =
            doc['selectedInstructor'] ?? 'No Instructor Selected';

        users = UserModel(
            userID: userID,
            userName: userName,
            userEmail: userEmail,
            userNumber: userNumber,
            userProPic: userProPic,
            selectedCourse: selectedCourse,
            selectedInstructor: selectedInstructor);

        usersDataList.add(users!);
      }
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<FormState> courseAddKey = GlobalKey<FormState>();
  TextEditingController courseNameController = TextEditingController();
  TextEditingController courseHoursController = TextEditingController();
  TextEditingController coursePriceController = TextEditingController();
  CourseModel? _courseModel;
  CourseModel get courseModel => _courseModel!;

  Future<void> saveCourse(
    String courseName,
    int courseHours,
    int coursePrice,
  ) async {
    final courseDoc = firebaseFirestore.collection('courses').doc();
    _courseModel = CourseModel(
        courseID: courseDoc.id,
        courseName: courseName,
        courseHours: courseHours,
        coursePrice: coursePrice);
    await courseDoc.set(_courseModel!.toMap());
    notifyListeners();
  }

  List<CourseModel> coursesList = [];
  CourseModel? courses;

  Future fetchCourses() async {
    try {
      coursesList.clear();

      CollectionReference coursesCollection =
          firebaseFirestore.collection('courses');
      QuerySnapshot coursesSnapshot = await coursesCollection.get();

      for (var doc in coursesSnapshot.docs) {
        String courseID = doc['courseID'];
        String courseName = doc['courseName'];
        int courseHours = doc['courseHours'];
        int coursePrice = doc['coursePrice'];

        courses = CourseModel(
            courseID: courseID,
            courseName: courseName,
            courseHours: courseHours,
            coursePrice: coursePrice);

        coursesList.add(courses!);
      }
    } catch (e) {
      print(e);
    }
  }

  GlobalKey<FormState> instrcutorAddKey = GlobalKey<FormState>();
  TextEditingController instrcutorNameController = TextEditingController();
  TextEditingController instrcutorNumberController = TextEditingController();

  InstructorModel? _instructorModel;
  InstructorModel get instructorModel => _instructorModel!;

  String? _instructorid;
  String get instructorid => _instructorid!;

  Future<void> saveInstructor(
    String instructorName,
    int instructorNumber,
    String instructorProPic,
  ) async {
    final instructorDoc = firebaseFirestore.collection('instructors').doc();
    _instructorModel = InstructorModel(
        instructorID: instructorDoc.id,
        instructorName: instructorName,
        instructorNumber: instructorNumber,
        instructorProPic: instructorProPic);

    await instructorDoc.set(_instructorModel!.toMap());

    _instructorid = instructorDoc.id;
    print('//////INSTRUCTOR ID : $_instructorid //////////////');
    notifyListeners();
  }

  List<InstructorModel> instructorsList = [];
  InstructorModel? instructors;

  Future fetchInstructors() async {
    try {
      instructorsList.clear();

      CollectionReference instructorsCollection =
          firebaseFirestore.collection('instructors');
      QuerySnapshot instructorSnapshot = await instructorsCollection.get();

      for (var doc in instructorSnapshot.docs) {
        String instructorID = doc['instructorID'];
        String instructorName = doc['instructorName'];
        int instructorNumber = doc['instructorNumber'];
        String instructorProPic = doc['instructorProPic'];

        instructors = InstructorModel(
            instructorID: instructorID,
            instructorName: instructorName,
            instructorNumber: instructorNumber,
            instructorProPic: instructorProPic);

        instructorsList.add(instructors!);
      }
    } catch (e) {
      print(e);
    }
  }

  ////////////////////////////////////////////////////////////////////////

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

  Future uploadInstructorProPic(File proPic, String path, String userID) async {
    try {
      await storeImagetoStorge('$path/$userID', proPic).then((value) async {
        instructorModel.instructorProPic = value;

        DocumentReference docRef =
            firebaseFirestore.collection('instructors').doc(_instructorid);
        await docRef.update({'instructorProPic': value});
      });
      _instructorModel = instructorModel;
      print('Pic uploaded successfully');
      // clearCarsField();
      notifyListeners();
    } catch (e) {
      print('image upload failed :$e');
    }
  }

  List<InvoiceModel> invoiceList = [];
  InvoiceModel? invoices;

  Future fetchAllInvoices() async {
    try {
      invoiceList.clear();
      CollectionReference invoiceCollection =
          firebaseFirestore.collection('invoices');
      QuerySnapshot invoiceSnapshot = await invoiceCollection.get();

      for (var doc in invoiceSnapshot.docs) {
        String invoiceID = doc['invoiceID'];
        String invoiceUserName = doc['invoiceUserName'];
        String invoiceCourseName = doc['invoiceCourseName'];
        String invoiceDate = doc['invoiceDate'];
        double invoicePrice = doc['invoicePrice'];

        invoices = InvoiceModel(
            invoiceID: invoiceID,
            invoiceUserName: invoiceUserName,
            invoiceCourseName: invoiceCourseName,
            invoiceDate: invoiceDate,
            invoicePrice: invoicePrice);

        invoiceList.add(invoices!);
      }
    } catch (e) {
      print(e);
    }
  }
}
