import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'helpers/colors_sys.dart';
import 'helpers/strings.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

  class HomePage extends StatefulWidget {
    const HomePage({super.key});
  
    @override
    State<HomePage> createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int currentIndex = 0;
    @override
    void initState(){
      _pageController = PageController();
      super.initState();
    }

  @override
  void dispose(){
      _pageController.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          actions: [
            Padding(padding: const EdgeInsets.only(right: 20, top: 20),
              child: Text('Skip', style: TextStyle(
                color: ColorSys.primary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              ),
            )
          ],

        ),
        body: Stack(
          children: [
            PageView(
              onPageChanged: (int page){
                setState(() {
                  currentIndex = page;
                });
              },
              controller: _pageController,
              children: [
                makePage(
                  image: 'assets/images/step-one.png',
                  title: Strings.stepOneTitle,
                  content: Strings.stepOneContent
                ),

                makePage(
                  reverse: true,
                    image: 'assets/images/step-two.png',
                    title: Strings.stepTwoTitle,
                    content: Strings.stepTwoContent
                ),

                makePage(
                    image: 'assets/images/step-three.png',
                    title: Strings.stepThreeTitle,
                    content: Strings.stepThreeTitle
                ),
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 60),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildIndicator(),
              ),
            )
          ],
        ),
      );
    }

  Widget makePage({image, title, content, reverse = false}) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          !reverse ?
          Column(
            children: <Widget>[
              FadeInUp(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(image),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ) : const SizedBox(),
          FadeInUp(
              duration: const Duration(milliseconds: 900),
              child: Text(title, style: TextStyle(
                  color: ColorSys.primary,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),)),
          const SizedBox(height: 20,),
          FadeInUp(
              duration: const Duration(milliseconds: 1200),
              child: Text(content, textAlign: TextAlign.center, style: TextStyle(
                  color: ColorSys.gray,
                  fontSize: 20,
                  fontWeight: FontWeight.w400
              ),)),
          reverse ?
          Column(
            children: <Widget>[
              const SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Image.asset(image),
              ),
            ],
          ) : const SizedBox(),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 6,
      width: isActive ? 30 : 6,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          color: ColorSys.secondary,
          borderRadius: BorderRadius.circular(5)
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];
    for (int i = 0; i<3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }

  }



