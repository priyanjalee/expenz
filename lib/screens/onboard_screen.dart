import 'package:expenz/constants/colors.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screen.dart';



class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //page controller
  final PageController _controller=PageController();
  bool showDetailPage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                //Onboarding Screens
                PageView(
                  controller: _controller,
                  onPageChanged: (index) {
                    setState(() {
                      showDetailPage = index == 3;
                      
                    });
                    
                  },
                  children: [
                   const FrontPage(),
                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[0].title, 
                      imagePath: OnboardingData.onboardingDataList[0].imagePath, 
                      description: OnboardingData.onboardingDataList[0].description),

                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[1].title, 
                      imagePath: OnboardingData.onboardingDataList[1].imagePath, 
                      description: OnboardingData.onboardingDataList[1].description),

                    SharedOnboardingScreen(
                      title: OnboardingData.onboardingDataList[2].title, 
                      imagePath: OnboardingData.onboardingDataList[2].imagePath, 
                      description: OnboardingData.onboardingDataList[2].description),
                      
                  ],
                ),
                //page dot indicator
                Container(
                  alignment: const Alignment(0, 0.75),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: const WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightgrey,
                    ),
                  ),
                ),
                //navigation button
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child:!showDetailPage? GestureDetector(
                      onTap: (){
                        _controller.animateToPage(
                          _controller.page!.toInt()+1,
                           duration: const Duration(milliseconds:400),
                          curve: Curves.easeInOut,);
                      },
                      child:  CustomButton(
                      buttonName: showDetailPage ? "Get Started" : "Next",
                      buttonColor: kMainColor,
                      
                                      ),
                    )
                    :GestureDetector(
                      onTap: (){
                        //navigate the user data screen
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const UserDataScreen(),));
                      },
                      child:  CustomButton(
                      buttonName: showDetailPage ? "Get Started" : "Next",
                      buttonColor: kMainColor,
                      
                                      ),
                  ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}