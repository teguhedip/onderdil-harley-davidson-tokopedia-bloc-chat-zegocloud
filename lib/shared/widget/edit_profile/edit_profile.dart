// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../../../core.dart';

class EditProfile extends StatefulWidget {
  final String imageUrl;
  final String profileName;
  const EditProfile({
    Key? key,
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
                label: "avatar image",
                value: widget.imageUrl,
                onChanged: (p0) {},
              ),
              QTextField(
                label: "profile name",
                value: widget.profileName,
                onChanged: (p0) {},
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
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
