import 'package:driving_school/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ManageRC extends StatelessWidget {
  const ManageRC({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/comingsoon.json'),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: width,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10), // Set your desired border radius here
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(defaultBlue),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Close',
                    style:
                        GoogleFonts.epilogue(fontSize: 15, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
