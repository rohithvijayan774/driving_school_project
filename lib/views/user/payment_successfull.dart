import 'package:driving_school/const.dart';
import 'package:driving_school/views/user/user_home.dart';
import 'package:driving_school/widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentSuccessful extends StatelessWidget {
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: width,
                height: height / 2,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(100, 50),
                    bottomRight: Radius.elliptical(100, 50),
                  ),
                  color: defaultBlue,
                ),
              ),
              SizedBox(
                width: width,
                height: height / 2,
              ),
            ],
          ),
          /////////////////////////////////////////////////////////////////
          Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/Ellipse 16.png')),
          Align(
              alignment: Alignment.topRight,
              child: Image.asset('assets/Ellipse 17.png')),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: width,
                height: 280,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Expanded(
                      child: Column(
                        children: [
                          Image.asset('assets/c-tick logo.png'),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'YOUR PAYMENT\nCOMPLETED',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.epilogue(
                                fontSize: 20, fontWeight: FontWeight.w500),
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
                              onPressed: () {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (context) => const UserHome(),
                                    ),
                                    (route) => false);
                              },
                              child: Text(
                                'CLOSE',
                                style: GoogleFonts.epilogue(
                                    fontSize: 15, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Positioned(
          //   top: height * 0.13,
          //   right: 0,
          //   left: 0,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     children: [
          //       Stack(
          //         children: [
          //           const CircleAvatar(
          //             radius: 40,
          //             backgroundImage: AssetImage('assets/image 13.png'),
          //           ),
          //           Positioned(
          //             bottom: 0,
          //             right: 0,
          //             child: IconButton.filled(
          //               style: const ButtonStyle(
          //                   backgroundColor:
          //                       MaterialStatePropertyAll(Colors.white)),
          //               visualDensity: VisualDensity.compact,
          //               iconSize: 20,
          //               onPressed: () {},
          //               icon: const Icon(
          //                 Icons.edit_outlined,
          //                 color: Colors.amber,
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         'Angela',
          //         style: GoogleFonts.epilogue(
          //           color: Colors.white,
          //           fontSize: 15,
          //         ),
          //       ),
          //       Text(
          //         'UserID : 211351',
          //         style: GoogleFonts.epilogue(
          //           color: Colors.white,
          //           fontSize: 15,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // SizedBox(
          //   width: width,
          //   height: height / 6,
          //   child: Row(
          //     // crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       IconButton(
          //         onPressed: () {
          //           Navigator.of(context).pop();
          //         },
          //         icon: const Icon(
          //           EvaIcons.arrow_ios_back_outline,
          //           color: Colors.white,
          //         ),
          //       ),
          //       const SizedBox(
          //         width: 20,
          //       ),
          //       Text(
          //         'Settings',
          //         style: GoogleFonts.epilogue(
          //           color: Colors.white,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       const Spacer(),
          //       IconButton(
          //         onPressed: () {
          //           Navigator.of(context).pushAndRemoveUntil(
          //               MaterialPageRoute(
          //                 builder: (context) => const ChooseUser(),
          //               ),
          //               (route) => false);
          //         },
          //         icon: const Icon(
          //           EvaIcons.log_out,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
