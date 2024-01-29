import 'package:driving_school/const.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';

class AddInstructor extends StatelessWidget {
  const AddInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Stack(
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
                  'Setup Instructor',
                  style: GoogleFonts.epilogue(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ////////////////////////////////////////////////////////
          Positioned(
              top: 0, right: 0, child: Image.asset('assets/Ellipse 2.png')),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Image.asset('assets/Ellipse 36.png')]),

          //////////////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Add Contact Information',
                  style: GoogleFonts.epilogue(fontSize: 18),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: GoogleFonts.epilogue(),
                    hintText: 'Enter Fullname',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintStyle: GoogleFonts.epilogue(),
                    hintText: 'Enter Phonenumber',
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: width,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          const MaterialStatePropertyAll(defaultBlue),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Upload',
                      style: GoogleFonts.epilogue(
                          fontSize: 15, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
