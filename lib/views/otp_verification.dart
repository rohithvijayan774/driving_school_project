import 'package:driving_school/const.dart';
import 'package:driving_school/controller/user_controller.dart';
import 'package:driving_school/views/admin/admin_home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPVerification extends StatelessWidget {
  final String userType;
  const OTPVerification({required this.userType, super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                userType,
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
                  Consumer<UserController>(
                    builder: (context, otpController, _) {
                      return Padding(
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
                                style:
                                    const TextStyle(color: Color(0xFF786868)),
                                keyboardType: TextInputType.phone,
                                controller: otpController.numberController,
                                decoration: InputDecoration(
                                  suffixIcon: otpController
                                              .numberController.text.length ==
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                child: const FittedBox(
                                  fit: BoxFit.cover,
                                  child: Pinput(
                                    length: 6,
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
                                        const MaterialStatePropertyAll(
                                            defaultBlue),
                                  ),
                                  onPressed: () {
                                    if (userType == 'ADMIN Login') {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => const AdminHome(),
                                      ));
                                    }
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
