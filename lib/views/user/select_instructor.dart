import 'package:driving_school/controller/admin_controller.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ChooseInstructor extends StatelessWidget {
  const ChooseInstructor({super.key});

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
                    'Select Instructor',
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
                'Our all Instructors',
                style: GoogleFonts.epilogue(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Consumer<AdminController>(
                  builder: (context, instructorController, _) {
                return FutureBuilder(
                    future: instructorController.fetchInstructors(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : instructorController.instructorsList.isEmpty
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
                                  itemCount: instructorController
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
                                                backgroundImage: instructorController
                                                            .instructorsList[
                                                                index]
                                                            .instructorProPic !=
                                                        null
                                                    ? NetworkImage(
                                                        instructorController
                                                            .instructorsList[
                                                                index]
                                                            .instructorProPic!)
                                                    : const AssetImage(
                                                            'assets/instructor.jpg')
                                                        as ImageProvider,
                                              ),
                                              Text(
                                                instructorController
                                                    .instructorsList[index]
                                                    .instructorName,
                                                style: GoogleFonts.epilogue(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 18),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: TextButton(
                                                      onPressed: () {},
                                                      child:
                                                          const Text('Select'),
                                                    ),
                                                  ),
                                                  IconButton.outlined(
                                                    onPressed: () {},
                                                    icon:
                                                        const Icon(Icons.call),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
    );
  }
}
