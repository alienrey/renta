import 'package:country_calling_code_picker/picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/screens/otp_verification_screen.dart';
import 'package:home_hub/screens/sign_up_screen.dart';
import 'package:home_hub/services/authentication.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../custom_widget/space.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  bool _securePassword = true;

  //formdata
  String password = '';
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              appData.isDark ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(60),
                  Text("RenTa!",
                      style: TextStyle(
                          fontSize: mainTitleTextSize,
                          fontWeight: FontWeight.bold)),
                  Space(8),
                  Text("Sharing is Caring.",
                      style: TextStyle(fontSize: 14, color: subTitle)),
                  Space(16),
                  Image.asset(splash_logo,
                      width: 100, height: 100, fit: BoxFit.cover),
                ],
              ),
              Space(70),
              Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(fontSize: 16),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: commonInputDecoration(
                          hintText: "Email",
                        ),
                        onChanged: (value) => {
                          setState(() {
                            email = value;
                          })
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter an email";
                          } else if (!EmailValidator.validate(value)) {
                            return "Please enter a valid email";
                          }
                          return null;
                        },
                      ),
                      Space(16),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _securePassword,
                        style: TextStyle(fontSize: 20),
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100)
                        ],
                        onChanged: (value) => {
                          setState(() {
                            password = value;
                          })
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          return null;
                        },
                        decoration: commonInputDecoration(
                          hintText: "Password",
                          suffixIcon: Padding(
                            padding: EdgeInsets.only(right: 5.0),
                            child: IconButton(
                              icon: Icon(
                                  _securePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 18),
                              onPressed: () {
                                _securePassword = !_securePassword;
                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Space(16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(fontSize: 16),
                    shape: StadiumBorder(),
                    backgroundColor: appData.isDark
                        ? Colors.grey.withOpacity(0.2)
                        : Colors.black,
                  ),
                  onPressed: () async {
                    if (_loginFormKey.currentState!.validate()) {
                      context.loaderOverlay.show();
                      print(email);
                      print(password);

                      await FirebaseAuthService.signIn(
                        email: email,
                        password: password,
                      ).then((value) => {
                            context.loaderOverlay.hide(),
                            
                            if (value == null)
                              {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message:
                                        'Unable to log in!',
                                  ),
                                ),
                              }
                            else
                              {
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                    message:
                                        'Successfully logged in!',
                                  ),
                                ),
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DashBoardScreen()),
                                  (route) => false,
                                )
                              }
                          });
                    }
                  },
                  child: Text("Log In",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white)),
                ),
              ),
              Space(32),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                            thickness: 1.2,
                            color: Colors.grey.withOpacity(0.2))),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                      child: Text("Or Login With",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                    ),
                    Expanded(
                        child: Divider(
                            thickness: 1.2,
                            color: Colors.grey.withOpacity(0.2))),
                  ],
                ),
              ),
              Space(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(icGoogle,
                      scale: 24,
                      color: appData.isDark ? blackColor : blackColor),
                  Space(40),
                  Image.asset(icInstagram,
                      scale: 24,
                      color: appData.isDark ? blackColor : blackColor),
                ],
              ),
              Space(32),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    Space(4),
                    Text('Sign Up',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
