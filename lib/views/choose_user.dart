import 'package:driving_school/const.dart';
import 'package:driving_school/views/admin/admin_login.dart';
import 'package:driving_school/views/otp_verification.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class ChooseUser extends StatelessWidget {
  const ChooseUser({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select Your Option',
                  style: GoogleFonts.epilogue(
                    color: defaultBlue,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    FadeTransition(
                              opacity: animation,
                              child: const OTPVerification(),
                            ),
                            transitionDuration:
                                const Duration(milliseconds: 1500),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 1000),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: width / 2.5,
                        height: height * 0.19,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: height * 0.05,
                                child: const Icon(
                                  Iconsax.user,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'USER',
                                  style: GoogleFonts.epilogue(
                                    color: defaultBlue,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      FadeTransition(
                                        opacity: animation,
                                        child: const AdminLogin(),
                                      ),
                              transitionDuration:
                                  const Duration(milliseconds: 1500),
                              reverseTransitionDuration:
                                  const Duration(milliseconds: 1000)),
                        );
                      },
                      child: SizedBox(
                        width: width / 2.5,
                        height: height * 0.19,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: height * 0.05,
                                child: const Icon(
                                  Iconsax.security_user,
                                  color: Colors.black,
                                  size: 60,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  'ADMIN',
                                  style: GoogleFonts.epilogue(
                                    color: defaultBlue,
                                    fontSize: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Hero(
            transitionOnUserGestures: true,
            tag: 'tag_1',
            child: Image.asset('assets/user_selection.png'),
          ),
        ],
      ),
    );
  }
}
