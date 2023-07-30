import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../Controllers/database_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  String? _selectedImagePath;

  Future<void> _getImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
      Fluttertoast.showToast(
        msg: "Please click Save info to Store",
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    // Fetch profile data from the database
    Map<String, dynamic> profileData = await DatabaseHelper().getProfile();

    setState(() {
      // Set the text controllers and _selectedImagePath with fetched data
      nameController.text = profileData['name'] ?? '';
      phoneController.text = profileData['phone'] ?? '';
      _selectedImagePath = profileData['profileImage'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customAppbar(),
                profileBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column profileBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: _getImageFromGallery,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: const Color.fromARGB(255, 116, 143, 249),
                radius: 93,
                child: CircleAvatar(
                  backgroundImage: _selectedImagePath != null
                      ? FileImage(File(_selectedImagePath!))
                      : AssetImage('assets/images/avatar.jpg') as ImageProvider,
                  radius: 90,
                ),
              ),
              const Positioned(
                right: 0,
                left: 110,
                bottom: 0,
                child: InkWell(
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 116, 143, 249),
                    radius: 22,
                    child: Icon(
                      Icons.photo,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.13),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'User Name',
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelStyle: TextStyle(
                color: const Color.fromARGB(255, 116, 143, 249),
              ),
              border: InputBorder.none,
            ),
            cursorColor: const Color.fromARGB(255, 116, 143, 249),
            onChanged: (value) {
              // userName = value;
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          height: 65,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.13),
              borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              labelText: 'User Phone',
              labelStyle: TextStyle(
                color: const Color.fromARGB(255, 116, 143, 249),
              ),
              border: InputBorder.none,
            ),
            cursorColor: const Color.fromARGB(255, 116, 143, 249),
            onChanged: (value) {
              // userPhone = value;
            },
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                // validation  :-)
                if (nameController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty) {
                  // Save profile data and image path to the local database
                  final profile = {
                    'name': nameController.text,
                    'phone': phoneController.text,
                    'profileImage': _selectedImagePath,
                  };
                  await DatabaseHelper().insertProfile(profile);
                } else {
                  // Show a Toast with the message
                  Fluttertoast.showToast(
                    msg: "Please add details",
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 116, 143, 249),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Save Info',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                try {
// Show a Toast with the message
                  _deleteImage();
                } catch (error) {
                  // Show a Toast with the message
                  Fluttertoast.showToast(
                    msg: "Error while deleting data",
                    gravity: ToastGravity.BOTTOM,
                    toastLength: Toast.LENGTH_SHORT,
                  );
                }
                ;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 116, 143, 249),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                'Delete Info',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget customAppbar() {
    return Container(
      child: Row(
        children: [
          Text(
            "Profile",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteImage() async {
    bool confirmed = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Confirm Deletion"),
          content: Text("Do you want to delete the profile image?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
                Fluttertoast.showToast(
                  msg: "Data Deleted Successfully",
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_SHORT,
                );
              },
              child: Text("Yes"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No"),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      // Delete image path from the local database
      await DatabaseHelper().deleteProfile();

      setState(() {
        _selectedImagePath = null;
      });
    }
  }
}
