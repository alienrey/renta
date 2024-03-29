import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:renta/custom_widget/space.dart';
import 'package:renta/main.dart';
import 'package:renta/models/renta/Rentals.dart';
import 'package:renta/services/authentication.dart';
import 'package:renta/utils/colors.dart';
import 'package:renta/utils/images.dart';
import 'package:renta/utils/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddProductForm extends StatefulWidget {
  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late double _pricePerDay;


File? _image;
Future<void> _pickImage() async {
  final ImagePicker _picker = ImagePicker();
  final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    setState(() {
      _image = File(pickedFile.path);
    });
  }
}

Future<String?> uploadImage(File image) async {
  try {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference storageReference =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = storageReference.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  } catch (error) {
    print(error);
    return null;
  }
}


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              height: 200,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.grey, // Define the color of the border
                  width: 1, // Define the width of the border
                  style: BorderStyle.solid, // Define the style of the border as dashed
                ),
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: _image != null ? FileImage(_image!) : Image.asset(add_photo).image,
                  fit: _image != null ? BoxFit.cover : BoxFit.contain,
                ),
              ),
            ),
          ),
          Space(15),
          Container(
            padding: EdgeInsets.only(left: 16), // Add left padding of 16 pixels
            child: Text(
              "Item Name",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
          Space(5),
          TextFormField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 20),
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: commonInputDecoration(
              hintText: "What item are you putting up for rent?"
            ),
            onChanged: (value) => {
              setState(() {
                _name = value;
              })
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          Space(15),
          Container(
            padding: EdgeInsets.only(left: 16), // Add left padding of 16 pixels
            child: Text(
              "Description",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
          Space(5),
          TextFormField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.next,
            maxLines: 3,
            style: TextStyle(fontSize: 15),
            inputFormatters: [LengthLimitingTextInputFormatter(1000)],
            decoration: InputDecoration(
              filled: true,
              hintText: "Describe your item, its condition, uses, issues, etc.",
              contentPadding: EdgeInsets.all(16),
              hintStyle: TextStyle(color: paymentCardBorderDark.withOpacity(0.7), fontSize: 16),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
            ),
              onChanged: (value) => {
              setState(() {
                _description = value;
              })
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
          ),
          Space(15),
          Container(
            padding: EdgeInsets.only(left: 16), // Add left padding of 16 pixels
            child: Text(
              "Price Per Day",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
          ),
          Space(5),
          TextFormField(
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 20),
            inputFormatters: [LengthLimitingTextInputFormatter(100)],
            decoration: commonInputDecoration(
              hintText: "How much will you charge the renter?"
            ),
            onChanged: (value) => {
              setState(() {
                _pricePerDay = double.parse(value);
              })
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the price per day';
              }
              // You can add additional validation logic here
              // For example, to check if the value is a valid number
              // or within a specific range.
              return null; // Return null if validation passes
            },
          ),
          Space(20),
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
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState?.save();

                  // String id;
                  // String name;
                  // String description;
                  // double pricePerDay;
                  // String ownerId;
                  // bool isRented;
                  // String photoLink;

                  context.loaderOverlay.show();

                  final downloadLink = await uploadImage(_image!);

                  FirebaseRentalService().createRental({
                    "name": _name,
                    "description": _description,
                    "pricePerDay": _pricePerDay,
                    "ownerId": FirebaseAuthService.getCurrentUserId(),
                    "isRented": false,
                    "photoLink": downloadLink
                  }).then((value) => {
                    context.loaderOverlay.hide(),
                    FirebaseRentalService().getAllRentals().then((value) => {print(value.toString())}),
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.success(
                        message:
                            'Listing successfully created!',
                      ),
                    ),
                  }).onError((error, stackTrace) => {
                    context.loaderOverlay.hide(),
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message:
                            'Failed to create listing!',
                      ),
                    ),
                  });
                  // Perform form submission here
                  // Upload image using _image file
                }
              },
              child: Text("Create Rental",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
