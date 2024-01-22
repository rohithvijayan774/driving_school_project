import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_course.dart';
import 'package:driving_school/views/admin/attendance_marking.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class UsersList extends StatelessWidget {
  const UsersList({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adminUserController = Provider.of<UserController>(context);
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
                    'View All Users',
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
                'Our All Users',
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
                itemCount: adminUserController.usersList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendanceMarking(
                              userName: adminUserController.usersList[index]
                                  ['name'],
                              userNumber: adminUserController.usersList[index]
                                  ['phone']),
                        ),
                      );
                    },
                    radius: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: height * .19,
                      child: Card(
                          // color: Colors.amber,
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                adminUserController.usersList[index]['image']),
                          ),
                          Text(
                            adminUserController.usersList[index]['name'],
                            style: GoogleFonts.epilogue(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          IconButton.outlined(
                              onPressed: () {}, icon: Icon(Icons.call))
                        ],
                      )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
