import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/core/updateProfile.dart';
import 'package:gym_app/model/userModel.dart';
import 'package:gym_app/services/Api.dart';
import 'package:image_picker/image_picker.dart';

class imageUploadScreen extends StatefulWidget {
  imageUploadScreen({super.key, this.theUser, this.userEmail});

  final String? userEmail;
  User? theUser;

  @override
  State<imageUploadScreen> createState() => _imageUploadScreenState();
}

class _imageUploadScreenState extends State<imageUploadScreen> {
  //dislpay the photo selected

  File? _selectedImage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              setState(() {
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => UpdateProfileScreen(
                //               imageUploaded: _selectedImage,
                //               userEmail: widget.userEmail,
                //               theUser: widget.theUser,
                //             )),
                //     (route) => false);
                Navigator.pop(context);
              });
            },
            icon: const Icon(Icons.arrow_back_sharp)),
        title: Text(
          "Image Picker",
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.7),
                ),
                onPressed: () {
                  _pickImageFromGallery();
                },
                child: Text(
                  "Pick Image from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.7),
                ),
                onPressed: () {
                  _pickImageFromCamera();
                },
                child: Text(
                  "Pick Image from Camera",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.7),
                ),
                onPressed: () async {
                  if (_selectedImage != null) {
                    //File _immmm = _selectedImage!;
                    // User u = widget.theUser!;
                    String im = await Api.addImage(_selectedImage!);
                    widget.theUser!.image = im;

                    // print(
                    //     "${await Api.addImage(_selectedImage!)} testtshhjsfhkf");
                    Map Data = {"image": im};
                    await Api.updateUser(widget.theUser!.id, Data);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen(
                                  imageUploaded: _selectedImage,
                                  userEmail: widget.userEmail,
                                  theUser: widget.theUser,
                                )),
                        (route) => false);
                  }
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              _selectedImage != null
                  ? Image.file(_selectedImage!)
                  : Text("Please select an image"),
            ],
          ),
        ),
      ),
    );
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    //mata3ml chay ki maya5yatch image return ; matemchil lil next line
    if (returnedImage == null) return;

    // when image selected to change the value and update the page
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    //mata3ml chay ki maya5yatch image return ; matemchil lil next line
    if (returnedImage == null) return;

    // when image selected to change the value and update the page
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
