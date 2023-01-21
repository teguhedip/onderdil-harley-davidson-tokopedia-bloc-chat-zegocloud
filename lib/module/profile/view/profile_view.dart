import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:example/core.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  Widget build(context, ProfileController controller) {
    controller.view = this;

    // final Stream<QuerySnapshot> studentRecords =
    //     FirebaseFirestore.instance.collection('users').snapshots();

    // print("AuthService.currentUser ${AuthService.currentUser!.uid}");

    return Scaffold(
      appBar: AppBar(
        title: const Text("GjProfile"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () => controller.doLogout(),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<DocumentSnapshot<Object?>>(
              stream: userCollection.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('No Data...');

                if (snapshot.hasError) {
                  return const Text("Error... something wrong");
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading....");
                }

                Map<String, dynamic> item =
                    (snapshot.data!.data() as Map<String, dynamic>);
                item["id"] = snapshot.data!.id;

                // final List firebaseData = [];
                // snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
                //   Map store = documentSnapshot.data() as Map<String, dynamic>;
                //   firebaseData.add(store);
                //   store['id'] = documentSnapshot.id;
                //   print("documentSnapshot ===== $documentSnapshot.id");
                // }).toList();
                // print("firebaseData ===== ${firebaseData.length}");
                // print("firebaseData ===== $firebaseData");
                // print("firebaseData ===== ${firebaseData[0]['name']}");
                // print("firebaseData ===== ${firebaseData[0]['email']}");
                // print(" Item Phpoto ====${item["photo"]}");

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: Get.width / 6,
                      backgroundImage: NetworkImage(
                        "${item["photo"]}" ??
                            "https://i.ibb.co/S32HNjD/no-image.jpg",
                        // FirebaseAuth.instance.currentUser!.photoURL ?? "https://i.ibb.co/S32HNjD/no-image.jpg",
                      ),
                    ),
                    Text(
                      // "${AuthService.currentUser!.displayName}",
                      "${item["name"]}",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${AuthService.currentUser!.email}",
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.edit_note),
                      label: const Text("Edit Profile"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        Get.to(EditProfile(
                          imageUrl: item["photo"] ?? "",
                          profileName: item["name"] ?? "",
                          id: AuthService.currentUser!.uid,
                        ));
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  @override
  State<ProfileView> createState() => ProfileController();
}
