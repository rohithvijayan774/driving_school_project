import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ManageCourse extends StatelessWidget {
  const ManageCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adminCourseController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(EvaIcons.arrow_ios_back_outline),
        ),
        centerTitle: true,
        title: Text(
          'Manage Courses',
          style: GoogleFonts.epilogue(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: width,
              height: 50,
              child: Text(
                'All Courses',
                style: GoogleFonts.epilogue(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1),
                itemCount: adminCourseController.courseList.length,
                itemBuilder: (context, index) {
                  // adminCourseController.usersList.ex
                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => adminCourseController
                      //         .adminServiceList[index]['onTap'],
                      //   ),
                      // );
                    },
                    radius: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: height * .19,
                      child: Card(
                          color: index % 2 == 0
                              ? const Color(0xFF1B53FF)
                              : const Color(0xFFF4E558),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '${index + 1}',
                                  style: GoogleFonts.fraunces(
                                      fontSize: 20, color: Colors.white),
                                ),
                                Text(
                                  adminCourseController.courseList[index]
                                      ['name'],
                                  style: GoogleFonts.epilogue(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12),
                                ),
                                Text(
                                  '${adminCourseController.courseList[index]['price']}',
                                  style: GoogleFonts.fraunces(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          )),
                    ),
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
              builder: (context) => const AddCourse(),
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