// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile {
  // final String id;
  // final String name;
  // final String imgUrl;

  // UserProfile(
  //   this.id,
  //   this.name,
  //   this.imgUrl,
  // );

  static Update(id, name, photo) async {
    await FirebaseFirestore.instance.collection("users").doc(id).update({
      "name": name,
      "photo": photo,
    });
  }

  //Update User
  // CollectionReference updateUser = FirebaseFirestore.instance.collection('users');
  // Future<void> updateUser(id, name, photo) {
  //   return updateUser
  //       .doc(id)
  //       .update({
  //         'name': name,
  //         'photo': photo,
  //       })
  //       .then((value) => print("User Updated"))
  //       .catchError((error) => print("Failed to update user: $error"));
  // }
}
