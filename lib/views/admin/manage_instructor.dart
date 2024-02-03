import 'package:driving_school/controller/admin_controller.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_instructor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ManageInstructor extends StatelessWidget {
  const ManageInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    // final adminInstrctrController = Provider.of<UserController>(context);
    return Scaffold(
      body: Padding(
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
                    'Manage Instructor',
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
                'Our Instructors',
                style: GoogleFonts.epilogue(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Consumer<AdminController>(
                builder: (context, adminInstrctrController, _) {
                  return FutureBuilder(
                    future: adminInstrctrController.fetchInstructors(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : adminInstrctrController.instructorsList.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Instructors Found',
                                    style: GoogleFonts.epilogue(),
                                  ),
                                )
                              : GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                          childAspectRatio: 1),
                                  itemCount: adminInstrctrController
                                      .instructorsList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => adminInstrctrController
                                        //         .adminServiceList[index]['onTap'],
                                        //   ),
                                        // );
                                      },
                                      radius: 20,
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                        height: height * .19,
                                        child: Card(
                                          // color: Colors.amber,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              CircleAvatar(
                                                radius: 30,
                                                backgroundImage: adminInstrctrController
                                                            .instructorsList[
                                                                index]
                                                            .instructorProPic !=
                                                        null
                                                    ? NetworkImage(
                                                        adminInstrctrController
                                                            .instructorsList[
                                                                index]
                                                            .instructorProPic!)
                                                    : const AssetImage(
                                                            'assets/instructor.jpg')
                                                        as ImageProvider,
                                              ),
                                              Text(
                                                adminInstrctrController
                                                    .instructorsList[index]
                                                    .instructorName,
                                                style: GoogleFonts.epilogue(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                              IconButton.outlined(
                                                onPressed: () {},
                                                icon: const Icon(Icons.call),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddInstructor(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
