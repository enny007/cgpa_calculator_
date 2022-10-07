import 'package:cgpa_calculator_/constants.dart';
import 'package:cgpa_calculator_/routes/routes.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int activeIndex = 0;
  late PageController pageController;
  List<String> images = [
    'assets/guardian.jpg',
    'assets/glasses_edu.jpg',
    'assets/equation_edu.jpg',
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 1, initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 795,
                  width: MediaQuery.of(context).size.width,
                  child: PageView.builder(
                      itemCount: images.length,
                      pageSnapping: true,
                      controller: pageController,
                      onPageChanged: (page) {
                        setState(() {
                          activeIndex = page;
                        });
                      },
                      itemBuilder: (context, pagePosition) {
                        return Container(
                          // margin: const EdgeInsets.all(10),
                          child: Image.asset(
                            images[pagePosition],
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                ),
                Positioned(
                  left: 35,
                  bottom: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: indicators(images.length, activeIndex),
                  ),
                ),
                Positioned(
                  left: 10,
                  right: 0,
                  bottom: 20,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 40,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RouteManager.loginPage,
                        );
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Text(
                          'Log In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Utils.primaryColor,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(5),
      width: 7,
      height: 7,
      decoration: BoxDecoration(
          color: currentIndex == index ? Utils.primaryColor : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
