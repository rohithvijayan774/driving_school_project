import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/add_contact.dart';
import 'package:driving_school/views/admin/add_course.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class ManageContact extends StatelessWidget {
  const ManageContact({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adminCourseController = Provider.of<UserController>(context);
    return Scaffold(
      body: Stack(
        children: [
          ////////////////////////////////////////////////////////
          Positioned(
              top: 0, right: 0, child: Image.asset('assets/Ellipse 2.png')),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Image.asset('assets/Ellipse 36.png')]),
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
                        'Manage Contact',
                        style: GoogleFonts.epilogue(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: index % 2 == 0
                                ? Image.asset('assets/contact_blue.png')
                                : Image.asset('assets/contact_yellow.png'),
                            title: SizedBox(
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text(
                                          'Name: ',
                                          style: GoogleFonts.epilogue(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
                                        ),
                                        Expanded(
                                          child: Text(
                                            '9876543210',
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.fraunces(
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(Icons
                                              .mode_edit_outline_outlined)),
                                      IconButton(
                                        onPressed: () {},
                                        icon: const CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                      itemCount: 5),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddContact(),
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