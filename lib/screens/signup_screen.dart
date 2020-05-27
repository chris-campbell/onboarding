import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/round_social_button.dart';
import 'login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:onboardingtest/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'setup_screen.dart';

class SignupScreen extends StatefulWidget {
  static String id = 'signup_screen';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirmController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _loggingIn = false;

  _signUp() async {

    setState(() {
      _loggingIn = true;
    });

    _scaffoldKey.currentState.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Logging in...'),
    ));

    try {
      FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim()))
          .user;

      UserUpdateInfo userInfo = UserUpdateInfo();
      userInfo.displayName = _nameController.text.trim();
      await user.updateProfile(userInfo);

      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Your account has been successfully created.'),
      ));
      Navigator.pushNamed(context, SetupScreen.id);

    } catch (e) {
      _scaffoldKey.currentState.removeCurrentSnackBar();
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text((e as PlatformException).message),
      ));
    } finally {
      setState(() {
        _loggingIn = false;
      });
    }
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                Container(
                  child: Material(
                    color: Color(0xFF333333),
                    child: TextField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(
                        color: Color(0xFFEBEBEB),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: kFocusBorderStyle,
                        enabledBorder: kEnabledBorderStyle,
                        filled: true,
                        fillColor: Color(0xFF333333),
                        hintText: 'John Doe',
                        hintStyle: TextStyle(
                          fontSize: 21.0,
                          color: Color(0xFF999999),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 11.0),
                          child: Icon(
                            Icons.face,
                            color: Color(0xFFF0F456),
                            size: 30.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Material(
                    color: Color(0xFF333333),
                    child: TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        color: Color(0xFFEBEBEB),
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedBorder: kFocusBorderStyle,
                        enabledBorder: kEnabledBorderStyle,
                        filled: true,
                        fillColor: Color(0xFF333333),
                        hintText: 'example@domain.com',
                        hintStyle: TextStyle(
                          fontSize: 21.0,
                          color: Color(0xFF999999),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(right: 11.0),
                          child: Icon(
                            Icons.email,
                            color: Color(0xFFF0F456),
                            size: 30.0,
                          ),
                        ),
                      ),
                      onChanged: (value) {

                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Material(
                    color: Color(0xFF333333),
                    child: TextField(
                      controller: _passwordController,
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
                      onChanged: (value) {

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
                    disabledColor: Color(0xFF048D9B).withOpacity(0.5),
                    onPressed: _loggingIn == true ? null : () async {
                      _signUp();
                    },
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
                      Navigator.pushNamed(context, LoginScreen.id);
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
