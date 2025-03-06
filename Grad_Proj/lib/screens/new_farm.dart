// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:grd_proj/screens/basic_info.dart';
import 'package:grd_proj/screens/home_screen.dart';
import 'package:grd_proj/screens/review.dart';
import 'package:grd_proj/screens/team.dart';
import '../Components/color.dart';

class NewFarm extends StatefulWidget {
  final Function(List) onInputChanged;
  const NewFarm({super.key,required this.onInputChanged});

  @override
  State<NewFarm> createState() => _NewFarmState();
}

class _NewFarmState extends State<NewFarm> {
  int currentIndex = 0;
  List farm = [];
  void _onInputChanged(List value, int index) {
    setState(() {
      farm.add(value);
      currentIndex = index;
      // ignore: avoid_print
      print(farm);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Top Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  pageTop(),
                  const SizedBox(height: 40),
                  buildDots(),
                ],
              ),
            ),
            
            // Scrollable Form Section
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (currentIndex == 0)
                      BasicInfo(onInputChanged: _onInputChanged, currentIndex: currentIndex)
                    else if (currentIndex == 1)
                      Team(onInputChanged: _onInputChanged, currentIndex: currentIndex)
                    else
                      Review(farm: farm),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pageTop() {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (currentIndex > 0) currentIndex--;
            });
          },
          icon: const Icon(Icons.arrow_back_rounded, color:  Color(0xff757575), size: 24),
        ),
        const Spacer(),
        const Text(
          'Add New Farm',
          style: TextStyle(
            fontFamily: 'Manrope',
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(initialIndex: 1)),
        );
          },
          icon: const Icon(Icons.close_rounded, color: Color(0xff757575), size: 24),
        ),
      ],
    );
  }

  Widget buildIndicatorItem(int index) {
    return CircleAvatar(
      radius: 15,
      backgroundColor: currentIndex == index
          ? primaryColor
          : const Color.fromRGBO(30, 105, 48, 0.25),
      child: Text(
        (index + 1).toString(),
        style: const TextStyle(
          fontFamily: 'Manrope',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildDots() {
    return SizedBox(
      width: 350,
      height: 60,
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  buildIndicatorItem(index),
                  const SizedBox(height: 7),
                  Text(
                    index == 0 ? 'Basic Info' : index == 1 ? 'Team' : 'Review',
                    style: const TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              if (index < 2)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  width: 50,
                  height: 1,
                  color: const Color(0xFF333333),
                ),
            ],
          );
        },
      ),
    );
  }
}

//   Widget button() {
//     return Align(
//       alignment: Alignment.bottomRight,
//       child: Container(
//           height: 60,
//           padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: primaryColor,
//           ),
//           child: TextButton(
//               onPressed: () {
//                 setState(() {
//                   if (currentIndex != 2) {
//                     currentIndex = currentIndex + 1;
//                   } else {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(builder: (context) => const Test()),
//                     );
//                   }
//                 });
//               },
//               child: currentIndex < 2
//                   ? const SizedBox(
//                       width: 70,
//                       child: Row(
//                         children: [
//                           Text(
//                             'Next',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                           SizedBox(width: 3),
//                           Icon(Icons.arrow_forward_ios,
//                               color: Colors.white, size: 20),
//                         ],
//                       ),
//                     )
//                   : const Text(
//                       'Create Farm',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ))),
//     );
//   }
// }
