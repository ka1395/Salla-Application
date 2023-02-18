import 'package:flutter/material.dart';
import 'package:salla/shared/network/local/cashmemory.dart';
import 'package:salla/shared/styles/colors.dart';
import 'package:salla/shared/styles/styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../login/login_screen.dart';

class OnBordingScreen extends StatefulWidget {
  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
  List listOnBoardPage = [
    bordingitem(
        body: "Lorem ipsum dolor sit amet Aeneam commodo ligula eget dolor",
        image: "assets/images/1.jpg",
        title: "Online Order"),
    bordingitem(
        body: "Lorem ipsum dolor sit amet Aeneam commodo ligula eget dolor",
        image: "assets/images/2.jpg",
        title: "Easy payment"),
    bordingitem(
        body: "Lorem ipsum dolor sit amet Aeneam commodo ligula eget dolor",
        image: "assets/images/3.jpg",
        title: "Fast Delivery")
  ];
  PageController bordingcontroller = PageController();
  bool isfinaish = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              CashHelper.saveData(key: "onBorading", value: true).then((value) {
                if (value) {
                  navigateAndFinish(context, LoginScreen());
                }
              });
            },
            child: Text("SKIP", style: TextStyle(fontSize: 16)),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(the_size_height(context, appbar: true) * .04),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (value) {
                  if (value == listOnBoardPage.length - 1) {
                    setState(() {
                      isfinaish = true;
                    });
                  } else {
                    isfinaish = false;
                  }
                },
                controller: bordingcontroller,
                itemBuilder: (context, index) =>
                    OnBoardComponent(context, listOnBoardPage[index]),
                itemCount: listOnBoardPage.length,
              ),
            ),
            SizedBox(
              height: the_size_height(context, appbar: true) * 0.07,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: bordingcontroller,
                    effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        activeDotColor: defaultColor,
                        dotWidth: 15,
                        spacing: 5),
                    count: listOnBoardPage.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isfinaish) {
                      CashHelper.saveData(key: "onBorading", value: true)
                          .then((value) {
                        if (value) {
                          navigateAndFinish(context, LoginScreen());
                        }
                      });
                    } else {
                      bordingcontroller.nextPage(
                          duration: Duration(seconds: 1), curve: Curves.easeIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
