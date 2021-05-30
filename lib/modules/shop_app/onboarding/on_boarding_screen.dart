import 'package:flutter/material.dart';
import 'package:new_one_flutter_app/modules/shop_app/shop_login_screen/shop_login_screen.dart';
import 'package:new_one_flutter_app/shared/components/components.dart';
import 'package:new_one_flutter_app/shared/network/local/cache_helper.dart';
import 'package:new_one_flutter_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  void onSubmit() {
    CacheHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) => navigateAndFinish(context, ShopLoginScreen()));
  }

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Board 1 title ',
      body: 'On Board 1 body ',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Board 2 title ',
      body: 'On Board 2 body ',
    ),
    BoardingModel(
      image: 'assets/images/onboard.jpg',
      title: 'On Board 3 title ',
      body: 'On Board 3 body ',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: onSubmit,
            title: 'Skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItems(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: WormEffect(
                      spacing: 5.0,
                      radius: 4.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItems(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(height: 30),
          Text(
            '${model.title}',
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(height: 14),
          Text(
            '${model.body}',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 30),
        ],
      );
}
