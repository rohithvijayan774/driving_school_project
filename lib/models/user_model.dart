class UserModel {
  String userID;
  String userName;
  String userEmail;
  int userNumber;
  String? userProPic;
  String? selectedCourse;
  String? selectedInstructor;
  List? userAttendance;

  UserModel({
    required this.userID,
    required this.userName,
    required this.userEmail,
    required this.userNumber,
    this.userProPic,
    this.selectedCourse,
    this.selectedInstructor,
    this.userAttendance,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'],
      userName: map['userName'],
      userEmail: map['userEmail'],
      userNumber: map['userNumber'],
      userProPic: map['userProPic'],
      selectedCourse: map['selectedCourse'],
      selectedInstructor: map['selectedInstructor'],
      userAttendance: map['userAttendance'] ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'userName': userName,
      'userEmail': userEmail,
      'userNumber': userNumber,
      'userProPic': userProPic,
      'selectedCourse': selectedCourse,
      'selectedInstructor': selectedInstructor,
      'userAttendance': userAttendance,
    };
  }
}
