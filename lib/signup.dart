import 'package:flutter/material.dart';

class NewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF333333),
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              ControlTextField(
                hintText: 'John Doe',
                icon: Icon(
                  Icons.face,
                  color: Color(0xFFF0F456),
                  size: 30.0,
                ),
              ),
              ControlTextField(
                hintText: 'example@domain.com',
                icon: Icon(
                  Icons.email,
                  color: Color(0xFFF0F456),
                  size: 30.0,
                ),
              ),
              ControlTextField(
                hintText: '*******',
                icon: Icon(
                  Icons.lock,
                  color: Color(0xFFF0F456),
                  size: 30.0,
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
                      fontSize: 20.0,
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
                  fontSize: 21.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RoundSocialButton(
                    icon: Icon(
                      Icons.fastfood,
                      size: 25.0,
                      color: Color(0xFFF0F456),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  RoundSocialButton(
                    icon: Icon(
                      Icons.fastfood,
                      size: 25.0,
                      color: Color(0xFFF0F456),
                    ),
                  ),
                  SizedBox(
                    width: 20.0,
                  ),
                  RoundSocialButton(
                    icon: Icon(
                      Icons.fastfood,
                      size: 25.0,
                      color: Color(0xFFF0F456),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40.0,
              ),
              ButtonTheme(
                minWidth: double.infinity,
                height: 80.0,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  color: Color(0xFFF0F456),
                  onPressed: () {},
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20.0,
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
    );
  }
}

class RoundSocialButton extends StatelessWidget {
  final Icon icon;

  RoundSocialButton({this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80.0,
      height: 100.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
        shape: BoxShape.circle,
      ),
      child: icon,
    );
  }
}

class ControlTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  const ControlTextField({this.hintText, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: Material(
        color: Color(0xFF333333),
        child: TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
                width: 2,
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF999999),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Color(0xFF333333),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 21.0,
              color: Color(0xFF999999),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 11.0),
              child: icon,
            ),
          ),
          validator: (value) {
            return value;
          },
        ),
      ),
    );
  }
}
