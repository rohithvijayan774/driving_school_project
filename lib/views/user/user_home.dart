import 'package:driving_school/const.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/user/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class UserHome extends StatelessWidget {
  const UserHome({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userHomeController = Provider.of<UserController>(context);
    return Scaffold(
      body: FutureBuilder(
        future: userHomeController.fetchUserData(),
        builder: (context, snapshot) {
          return snapshot.connectionState == ConnectionState.waiting
              ? const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: defaultBlue,
                  ),
                )
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Welcome back,\n${userHomeController.userModel.userName},',
                                style: GoogleFonts.epilogue(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserSettings(),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    const Icon(
                                      MingCute.settings_1_line,
                                      color: defaultBlue,
                                    ),
                                    Text(
                                      'Settings',
                                      style: GoogleFonts.epilogue(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: width,
                          height: height / 6,
                          child: Card(
                            color: defaultBlue,
                            child: Center(
                              child: Text(
                                'No Class Selected',
                                style: GoogleFonts.epilogue(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Service Categories:',
                          style: GoogleFonts.epilogue(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 0,
                                    childAspectRatio: 0.8),
                            itemCount:
                                userHomeController.userServiceList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => userHomeController
                                          .userServiceList[index]['onTap'],
                                    ),
                                  );
                                },
                                radius: 20,
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 80,
                                      child: Card(
                                        // color: Colors.amber,
                                        child: Center(
                                          child: Image.asset(userHomeController
                                              .userServiceList[index]['image']),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      userHomeController.userServiceList[index]
                                          ['service name'],
                                      style: GoogleFonts.epilogue(),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                );
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //     elevation: 0,
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: Container(
      //             width: width,
      //             decoration:
      //                 BoxDecoration(borderRadius: BorderRadius.circular(5)),
      //             child: ElevatedButton(
      //               style: ButtonStyle(
      //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(
      //                         10), // Set your desired border radius here
      //                   ),
      //                 ),
      //                 backgroundColor:
      //                     const MaterialStatePropertyAll(defaultBlue),
      //               ),
      //               onPressed: () {},
      //               child: Text(
      //                 'Home',
      //                 style: GoogleFonts.epilogue(
      //                     fontSize: 15, color: Colors.white),
      //               ),
      //             ),
      //           ),
      //         ),
      //         CircleAvatar(
      //           radius: 50,
      //           backgroundColor: Colors.transparent,
      //           child: IconButton(
      //             onPressed: () {},
      //             icon: const CircleAvatar(
      //               backgroundColor: defaultBlue,
      //               radius: 20,
      //               child: Icon(
      //                 Icons.power_settings_new_rounded,
      //                 color: Colors.white,
      //               ),
      //             ),
      //           ),
      //         ),
      //         Expanded(
      //           child: Container(
      //             width: width,
      //             decoration:
      //                 BoxDecoration(borderRadius: BorderRadius.circular(5)),
      //             child: ElevatedButton(
      //               style: ButtonStyle(
      //                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      //                   RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(
      //                         10), // Set your desired border radius here
      //                   ),
      //                 ),
      //                 backgroundColor:
      //                     const MaterialStatePropertyAll(defaultBlue),
      //               ),
      //               onPressed: () {
      //                 Navigator.of(context).push(
      //                   MaterialPageRoute(
      //                     builder: (context) => const UserSettings(),
      //                   ),
      //                 );
      //               },
      //               child: Text(
      //                 'Settings',
      //                 style: GoogleFonts.epilogue(
      //                     fontSize: 15, color: Colors.white),
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     )),
    );
  }
}
