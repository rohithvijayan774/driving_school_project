import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:driving_school/models/course_model.dart';
import 'package:driving_school/models/instructor_model.dart';
import 'package:driving_school/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AdminController extends ChangeNotifier {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ///////////////////DATABASE OPERATIONS////////////////////////////////////////
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

  InstructorModel? _instructorModel;
  InstructorModel get instructorModel => _instructorModel!;

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
}
