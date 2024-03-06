import 'package:driving_school/controller/admin_controller.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class UserAttendance extends StatelessWidget {
  final String userID;
  final String userName;
  final int userNumber;
  final String trainerName;
  const UserAttendance({
    required this.userID,
    required this.userName,
    required this.userNumber,
    required this.trainerName,
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
                Expanded(
                  child: Consumer<AdminController>(
                      builder: (context, attListController, _) {
                    return FutureBuilder(
                        future: attListController.fetchAtt(userID),
                        builder: (context, snapshot) {
                          return snapshot.connectionState ==
                                  ConnectionState.waiting
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : attListController.attList.isEmpty
                                  ? const Center(
                                      child: Text('No attendance marked'),
                                    )
                                  : ListView.builder(
                                      itemCount:
                                          attListController.attList.length,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: ListTile(
                                            title: Text(
                                                'Date : ${attListController.attList[index].attDate}'),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Time : ${attListController.attList[index].attTime}'),
                                                Text(
                                                    'Trainer : ${attListController.attList[index].trainerName}'),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                        });
                  }),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          Consumer<AdminController>(builder: (context, attController, _) {
        return FloatingActionButton.extended(
          backgroundColor: Colors.black,
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Mark Attendance'),
                  content: Form(
                    key: attController.attKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text('Mark $userName attendance'),
                        TextFormField(
                          readOnly: true,
                          controller: attController.attDateController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*please select a date";
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(hintText: 'Choose Date'),
                          onTap: () {
                            attController.selectDate(context);
                          },
                        ),
                        TextFormField(
                          readOnly: true,
                          controller: attController.attTimeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "*please select time";
                            } else {
                              return null;
                            }
                          },
                          decoration:
                              const InputDecoration(hintText: 'Choose Time'),
                          onTap: () {
                            attController.selectTime(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        attController.markAttendance(
                            attController.attDateController.text,
                            attController.attTimeController.text,
                            userID,
                            trainerName,
                            context);
                      },
                      child: const Text('Add'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
            // AlertDialog();
          },
          label: const Text(
            'Mark Attendance',
            style: TextStyle(color: Colors.white),
          ),
        );
      }),
    );
  }
}
