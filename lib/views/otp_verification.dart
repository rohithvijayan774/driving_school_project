import 'package:driving_school/const.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/user/add_user_details.dart';
import 'package:driving_school/views/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPVerification extends StatelessWidget {
  const OTPVerification({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final otpController = Provider.of<UserController>(context, listen: false);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: width,
            child: Center(
              child: Text(
                'USER Login',
                style: GoogleFonts.epilogue(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 100),
                    child: Hero(
                      tag: 'tag_1',
                      child: Image.asset('assets/user_selection.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Form(
                      // key: otpController.numberKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              otpController.setPhonenumber(value, context);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*this field is required';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color(0xFF786868)),
                            keyboardType: TextInputType.phone,
                            controller: otpController.numberController,
                            decoration: InputDecoration(
                              suffixIcon:
                                  otpController.numberController.text.length ==
                                          10
                                      ? const Icon(
                                          HeroIcons.check_circle,
                                          color: Colors.green,
                                        )
                                      : null,
                              filled: true,
                              fillColor:
                                  const Color.fromARGB(59, 255, 255, 255),
                              hintStyle: GoogleFonts.epilogue(),
                              hintText: 'Enter your phone number',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black26),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.black26),
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    otpController.showCountries(context);
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${otpController.selectedCountry.flagEmoji} + ${otpController.selectedCountry.phoneCode}",
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF786868),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Verify OTP',
                            style: GoogleFonts.epilogue(),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.black26)),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Pinput(
                                length: 6,
                                onChanged: (value) {
                                  otpController.otpCode = value;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5)),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set your desired border radius here
                                  ),
                                ),
                                backgroundColor:
                                    const MaterialStatePropertyAll(defaultBlue),
                              ),
                              onPressed:
                                  //  otpCode == null ||
                                  //         otpCode!.length != 6
                                  //     ? null
                                  //     :
                                  () {
                                otpController.verifyOTP(
                                  context: context,
                                  verificationId:
                                      otpController.verificationCode,
                                  userOTP: otpController.otpCode!,
                                  onSuccess: () {
                                    otpController.checkExistingUser().then(
                                      (value) async {
                                        if (value == true) {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => UserHome(
                                                  uid: otpController
                                                      .firebaseAuth
                                                      .currentUser!
                                                      .uid),
                                            ),
                                          );
                                        } else {
                                          Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddUserDetails(),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              child: Text(
                                'Verify',
                                style: GoogleFonts.epilogue(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
