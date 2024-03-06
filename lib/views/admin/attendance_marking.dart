import 'package:driving_school/controller/admin_controller.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceMarking extends StatelessWidget {
  final String userID;
  final String userName;
  final int userNumber;
  const AttendanceMarking({
    required this.userID,
    required this.userName,
    required this.userNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final attendanceController = Provider.of<UserController>(context);
    return Scaffold(
      body: Stack(
        children: [
          ////////////////////////////////////////////////////////
          Positioned(
              top: 0, right: 0, child: Image.asset('assets/Ellipse 2.png')),
          // Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [Image.asset('assets/Ellipse 36.png')]),
          ///////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  width: width,
                  height: height / 6,
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(EvaIcons.arrow_ios_back_outline),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Attendance Marking',
                        style: GoogleFonts.epilogue(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  width: width,
                  height: 50,
                  child: Text(
                    'Select a Slot',
                    style: GoogleFonts.epilogue(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                Consumer<AdminController>(
                    builder: (context, attendanceController, _) {
                  return FutureBuilder(
                      future: attendanceController.fetchAttendance(userID),
                      builder: (context, snapshot) {
                        return TableCalendar(
                          eventLoader: (day) {
                            return attendanceController.userAttendance.entries
                                .map((entry) => entry.value[day] ?? [])
                                .expand((event) => event)
                                .toList();
                          },
                          firstDay: DateTime(2000),
                          lastDay: DateTime(2100),
                          focusedDay: attendanceController.today,
                          onDaySelected: (selectedDay, focusedDay) {
                            attendanceController.onDaySelected(
                                selectedDay, focusedDay, userID);

                            // print(object)
                          },
                          availableGestures: AvailableGestures.horizontalSwipe,
                          selectedDayPredicate: (day) =>
                              isSameDay(day, attendanceController.today),
                        );
                      });
                }),
                Expanded(child: Consumer<AdminController>(
                    builder: (context, attendanceListController, _) {
                  return attendanceListController.userAttendance.isEmpty
                      ? const Center(
                          child: Text('No Attendance'),
                        )
                      : ListView.separated(
                          itemBuilder: (context, index) {
                            String userAttID = attendanceListController
                                .userAttendance.keys
                                .elementAt(index);
                            List<DateTime> userAttDates =
                                attendanceListController
                                    .userAttendance[userID]!.keys
                                    .toList();
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                child: ListTile(
                                  leading: Text('User : $userName'),
                                  title: Text('Date : $userAttDates'),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount:
                              attendanceListController.userAttendance.length);
                }))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
