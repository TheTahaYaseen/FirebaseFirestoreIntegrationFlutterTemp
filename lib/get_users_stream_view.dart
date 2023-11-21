import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nov20/services.dart';
import 'package:nov20/user_model.dart';

class GetUsersStreamView extends StatelessWidget {
  const GetUsersStreamView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var data = snapshot.data!.docs[index].data();
                data["docId"] = snapshot.data!.docs[index].id;
                final user = UserModel.fromJson(data);
                return ListTile(
                  onTap: () {
                    // navigate to get users activity
                  },
                  title: Text(user.name),
                  subtitle: Text(user.phone),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // navigate to add user activity view
                    },
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
