import 'package:abdullaa/moduls/shopApp/login/Shop_Lgin_Screen.dart';
import 'package:abdullaa/shared/compounant/compounts.dart';
import 'package:abdullaa/shared/network/network.local.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class onBoardingScreen extends StatefulWidget {
  @override
  State<onBoardingScreen> createState() => _onBoardingScreenState();
}

class _onBoardingScreenState extends State<onBoardingScreen> {
  var boardControllar = PageController();
  bool isLast = false;
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/onboarding.jpg',
      title: 'On Board 1',
      body: 'On Body 1',
    ),
    BoardingModel(
      image: 'assets/onboarding2.jpg',
      title: 'On Board 2',
      body: 'On Body2 ',
    ),
    BoardingModel(
      image: 'assets/onboarding3.jpg',
      title: 'On Board 3',
      body: 'On Body3 ',
    ),
  ];

  void submit(){
    CashHelper.saveData(
        key: 'onBoarding',
        value: true,
    ).then((value) {
      if(value==true){
        navigatAndfinshed(context, Shop_Login());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: InkWell(
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                  fontSize: 15,
                ),
              ),
              onTap: () {
               submit();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('the last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    print(index);
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardControllar,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardControllar,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    expansionFactor: 4,
                    spacing: 5,
                    activeDotColor: Colors.deepPurple,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.deepPurple,
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      boardControllar.nextPage(
                        duration: Duration(milliseconds: 50),
                        curve: Curves.bounceInOut,
                      );
                    }
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            model.title,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            model.body,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
}
