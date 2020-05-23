import 'package:flutter/material.dart';
import '../widgets/control_text_field.dart';
import '../widgets/round_social_button.dart';
import 'login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboardingtest/constants.dart';

class SignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF333333),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image(
                      width: 150.0,
                      height: 100.0,
                      image: AssetImage(
                        "assets/images/Group 90.png",
                      ),
                    ),
                  ),
                ),
                ControlTextField(
                  hintText: 'John Doe',
                  icon: Icon(
                    Icons.face,
                    color: Color(0xFFF0F456),
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ControlTextField(
                  hintText: 'example@domain.com',
                  textType: TextInputType.emailAddress,
                  icon: Icon(
                    Icons.email,
                    color: Color(0xFFF0F456),
                    size: 30.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Material(
                    color: Color(0xFF333333),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(
                        color: Color(0xFFEBEBEB),
                        fontSize: 21.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: kFocusBorderStyle,
                        enabledBorder: kEnabledBorderStyle,
                        filled: true,
                        fillColor: Color(0xFF333333),
                        hintText: '*******',
                        hintStyle: TextStyle(
                          fontSize: 21.0,
                          color: Color(0xFF999999),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 11.0),
                          child: Icon(
                            FontAwesomeIcons.lock,
                            color: Color(0xFFF0F456),
                            size: 30.0,
                          ),
                        ),
                      ),
                      validator: (value) {
                        return value;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 80.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color(0xFF048D9B),
                    onPressed: () {},
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 60.0,
                ),
                Text(
                  'Sign up with',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 0.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RoundSocialButton(
                      icon: Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFFF0F456),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    RoundSocialButton(
                      icon: Icon(
                        FontAwesomeIcons.twitter,
                        color: Color(0xFFF0F456),
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    RoundSocialButton(
                      icon: Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFF0F456),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Already have an account? Login here',
                  style: TextStyle(
                    color: Color(0xFF999999),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                ButtonTheme(
                  minWidth: double.infinity,
                  height: 80.0,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Color(0xFFF0F456),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
