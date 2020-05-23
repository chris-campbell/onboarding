import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup_screen.dart';
import 'package:onboardingtest/constants.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }

    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 100.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0XFF048D9B),
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0XFFfeff00),
                  Color(0XFFf2df2d),
                ]),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen())),
                    },
                    child: _currentPage != _numPages - 1
                        ? Text(
                            'Skip',
                            style: TextStyle(
                              color: Color(0XFF048D9B),
                              fontSize: 20.0,
                            ),
                          )
                        : Text(''),
                  ),
                ),
                Container(
                  height: 600.0,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 100.0),
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/thumbprint.png",
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Center(
                              child: Text(
                                'dontTouch',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0XFF333333),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 70.0,
                            ),
                            Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus accumsan congue volutpat. Interdum et malesuada fames ac ante ipsum primis in faucibus",
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/Group 64.png",
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus accumsan congue volutpat. Interdum et malesuada fames ac ante ipsum primis in faucibus",
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 70.0),
                                child: Image(
                                  image: AssetImage(
                                    "assets/images/Asset 1.png",
                                  ),
                                  width: 200.0,
                                  height: 200.0,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Expanded(
                              child: Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus accumsan congue volutpat. Interdum et malesuada fames ac ante ipsum primis in faucibus",
                                style: kSubtitleStyle,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
//
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 100.0,
              width: double.infinity,
              color: Color(0xFF333333),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignupScreen()));
                },
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Color(0XFF048D9B),
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }
}
