import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/choose_user.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final adminHomeController = Provider.of<UserController>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Welcome back,\nAdmin,',
                      style: GoogleFonts.epilogue(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => const ChooseUser(),
                            ),
                            (route) => false);
                      },
                      child: Column(
                        children: [
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Icon(
                              Iconsax.logout_1,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Logout',
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
                height: 20,
              ),
              Text(
                'Manage Service categories:',
                style: GoogleFonts.epilogue(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 0,
                      childAspectRatio: 0.8),
                  itemCount: adminHomeController.adminServiceList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => adminHomeController
                                .adminServiceList[index]['onTap'],
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
                                child: Image.asset(adminHomeController
                                    .adminServiceList[index]['image']),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            adminHomeController.adminServiceList[index]
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
      ),
    );
  }
}
