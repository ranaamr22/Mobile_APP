// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:projects_folder/shared/components/components.dart';
import 'package:projects_folder/shared/network/local/cashe_helper.dart';
import '../../models/onboarding_screen_model/onboarding_screen_model.dart';
import '../login_screen/login_screen.dart';

class OnBoardingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    void toLoginScreen()
    {
      CasheHelper.setData(
        key: 'onBoarding',
        value: false,

      ).then((value){
        if(value)
        {
          navigateToAndRemove(context, LoginScreen());
        }
      });
    }

    List<OnBoardingScreenModel> onboarding = [
      OnBoardingScreenModel(
          image: 'assets/images/onboarding1.jpeg',
          title: 'Welcome',
          body: 'Enjoy our app'
      ),
      OnBoardingScreenModel(
          image: 'assets/images/onboarding_2.png',
          title: 'Term of use',
          body:  'Enjoy our app'
      ),
      OnBoardingScreenModel(
          image: 'assets/images/onboarding3.png',
          title: 'Get started',
          body: 'Enjoy our app'
      ),
    ];
    var pageController = PageController();
    int pageIndex= 0;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: ()
            {
              toLoginScreen() ;
            },
            child: Text(
              'SKIP',
            )
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) =>pageViewBuildItem(onboarding[index]),
                itemCount: onboarding.length,
                physics: BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (index)
                {
                  pageIndex= index ;
                },
              ),
            ),
            SizedBox(height: 70,),
            Row(
              children: [
                pageIndicator(pageController, onboarding.length) ,
                Spacer(),
                FloatingActionButton(
                  onPressed: ()
                  {
                    if(pageIndex == onboarding.length -1)
                    {
                      toLoginScreen();
                    }
                    pageController.animateToPage(
                        pageIndex+1,
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn
                      );
                  },
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget pageViewBuildItem(OnBoardingScreenModel screen) =>Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
          image: AssetImage(screen.image),
        ),
      ),

      Text(
        screen.title,
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w700
        ),
      ),

      SizedBox(height: 5,),

      Text(
        screen.body,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: Colors.grey
        ),
      ),
    ],
  );
}

