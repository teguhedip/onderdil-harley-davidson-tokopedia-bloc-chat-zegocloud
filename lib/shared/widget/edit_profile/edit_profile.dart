// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../core.dart';

class EditProfile extends StatefulWidget {
  String imageUrl;
  String profileName;
  String id;

  EditProfile({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.profileName,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              QImagePicker(
                label: "Photo",
                hint: "Your photo",
                validator: Validator.required,
                value: widget.imageUrl,
                onChanged: (value) {
                  // print("php value $value");
                  widget.imageUrl = value;
                },
              ),
              QTextField(
                label: "profile name",
                value: widget.profileName,
                onChanged: (value) {
                  widget.profileName = value;
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text("Save"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  UserProfile.Update(
                    widget.id,
                    widget.profileName,
                    widget.imageUrl,
                  );
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
