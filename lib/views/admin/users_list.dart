import 'package:driving_school/controller/admin_controller.dart';
import 'package:driving_school/controller/user_controller.dart';
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
    final adminUserController =
        Provider.of<AdminController>(context, listen: false);
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
              child: Consumer<AdminController>(
                  builder: (context, userController, _) {
                return FutureBuilder(
                    future: userController.fetchUsers(),
                    builder: (context, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : userController.usersDataList.isEmpty
                              ? Center(
                                  child: Text(
                                    'No Users Found',
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
                                  itemCount:
                                      userController.usersDataList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AttendanceMarking(
                                                    userName:
                                                        userController
                                                            .usersDataList[
                                                                index]
                                                            .userName,
                                                    userNumber: userController
                                                        .usersDataList[index]
                                                        .userNumber),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CircleAvatar(
                                              radius: 30,
                                              backgroundImage: userController
                                                          .usersDataList[index]
                                                          .userProPic !=
                                                      null
                                                  ? NetworkImage(userController
                                                      .usersDataList[index]
                                                      .userProPic!)
                                                  : const AssetImage(
                                                          'assets/profile.jpg')
                                                      as ImageProvider,
                                            ),
                                            Text(
                                              userController
                                                  .usersDataList[index]
                                                  .userName,
                                              style: GoogleFonts.epilogue(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                            IconButton.outlined(
                                                onPressed: () {},
                                                icon: const Icon(Icons.call))
                                          ],
                                        )),
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
