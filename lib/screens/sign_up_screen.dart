import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/screens/otp_verification_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/services/authentication.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:email_validator/email_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../custom_widget/space.dart';
import '../utils/colors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signUpFormKey = GlobalKey<FormState>();

  bool agreeWithTeams = false;
  bool _securePassword = true;
  bool _secureConfirmPassword = true;

  double screenHeight = 0.0;
  double screenWidth = 0.0;

  bool? checkBoxValue = false;

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String password = '';

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: SingleChildScrollView(
            child: ListBody(children: [
              Text(
                  'Please complete the form and agree to the terms and conditions.')
            ]),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Space(42),
              Center(
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                      fontSize: mainTitleTextSize, fontWeight: FontWeight.bold),
                ),
              ),
              Space(60),
              Form(
                key: _signUpFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 20),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      decoration: commonInputDecoration(hintText: "First Name"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter first name";
                        }
                        return null;
                      },
                      onChanged: (value) => {
                        setState(() {
                          firstName = value;
                        })
                      },
                    ),
                    Space(16),
                    TextFormField(
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 20),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      decoration: commonInputDecoration(hintText: "Last Name"),
                      onChanged: (value) => {
                        setState(() {
                          lastName = value;
                        })
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter last name";
                        }
                        return null;
                      },
                    ),
                    Space(16),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      style: TextStyle(fontSize: 20),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      decoration: commonInputDecoration(hintText: "Email"),
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
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      inputFormatters: [LengthLimitingTextInputFormatter(11)],
                      style: TextStyle(fontSize: 20),
                      decoration: commonInputDecoration(
                          hintText: "Mobile Number (Eg. 09123456789)"),
                      onChanged: (value) => {
                        setState(() {
                          phoneNumber = value;
                        })
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter phone number";
                        }
                        if (value.length < 11) {
                          return "Please enter a valid phone number";
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
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
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
                    Space(16),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: _secureConfirmPassword,
                      style: TextStyle(fontSize: 20),
                      inputFormatters: [LengthLimitingTextInputFormatter(100)],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please re-enter password";
                        }
                        return null;
                      },
                      decoration: commonInputDecoration(
                        hintText: "Re-enter Password",
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 5.0),
                          child: IconButton(
                            icon: Icon(
                                _secureConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 18),
                            onPressed: () {
                              setState(() {
                                _secureConfirmPassword =
                                    !_secureConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // Space(16),
                    // Theme(
                    //   data: ThemeData(unselectedWidgetColor: appData.isDark ? Colors.white : blackColor),
                    //   child: CheckboxListTile(
                    //     contentPadding: EdgeInsets.all(0),
                    //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    //     activeColor: Colors.black,
                    //     title: Text("I agree to the Terms and Conditions", style: TextStyle(fontWeight: FontWeight.normal)),
                    //     value: checkBoxValue,
                    //     dense: true,
                    //     onChanged: (newValue) {
                    //       setState(() {
                    //         checkBoxValue = newValue;
                    //       });
                    //     },
                    //     controlAffinity: ListTileControlAffinity.leading,
                    //   ),
                    // ),
                    Space(16),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(16),
                          textStyle: TextStyle(fontSize: 25),
                          shape: StadiumBorder(),
                          backgroundColor: appData.isDark
                              ? Colors.grey.withOpacity(0.2)
                              : Colors.black,
                        ),
                        onPressed: () async {
                          if (_signUpFormKey.currentState!.validate()) {
                            context.loaderOverlay.show();
                            await FirebaseAuthService.signUp(
                                    email: email,
                                    password: password,
                                    firstName: firstName,
                                    lastName: lastName,
                                    phoneNumber: phoneNumber)
                                .then((value) => {
                                      context.loaderOverlay.hide(),
                                      if (value == null)
                                        {
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            const CustomSnackBar.error(
                                              message:
                                                  'Unable to create account!',
                                            ),
                                          )
                                        }
                                      else
                                        {
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            const CustomSnackBar.success(
                                              message:
                                                  'Account created successfully!',
                                            ),
                                          ),
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SignInScreen()))
                                        }
                                    });

                            // if (agreeWithTeams == true) {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                            //   );
                            // } else {
                            //   _showAlertDialog();
                            // }
                          }
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white)),
                      ),
                    ),
                    Space(20),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?",
                              style: TextStyle(fontSize: 16)),
                          Space(4),
                          Text('Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
