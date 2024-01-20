import 'package:driving_school/controller/user_controller.dart';
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
    final adminUserController = Provider.of<UserController>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(EvaIcons.arrow_ios_back_outline),
        ),
        centerTitle: true,
        title: Text(
          'All Users',
          style: GoogleFonts.epilogue(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              width: width,
              height: 50,
              child: Text(
                'Our All Users',
                style: GoogleFonts.epilogue(
                    fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1),
                itemCount: adminUserController.usersList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => adminUserController
                      //         .adminServiceList[index]['onTap'],
                      //   ),
                      // );
                    },
                    radius: 20,
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox(
                      height: height * .19,
                      child: Card(
                          // color: Colors.amber,
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(
                                adminUserController.usersList[index]['image']),
                          ),
                          Text(
                            adminUserController.usersList[index]['name'],
                            style: GoogleFonts.epilogue(
                                fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                          IconButton.outlined(
                              onPressed: () {}, icon: Icon(Icons.call))
                        ],
                      )),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
