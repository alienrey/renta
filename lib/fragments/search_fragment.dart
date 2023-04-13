import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:home_hub/components/renta/add_rental_form.dart';
import 'package:home_hub/components/search_component.dart';
import 'package:home_hub/custom_widget/space.dart';
import 'package:home_hub/main.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/services/authentication.dart';
import 'package:home_hub/utils/constant.dart';
import 'package:home_hub/utils/widgets.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../models/services_model.dart';
import '../utils/colors.dart';

class SearchFragment extends StatefulWidget {
  const SearchFragment({Key? key}) : super(key: key);

  @override
  State<SearchFragment> createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        backgroundColor: transparent,
        title: Text(
          "Create Listing",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddProductForm()
            ],
          ),
        ),
      ),
    );
  }
}
