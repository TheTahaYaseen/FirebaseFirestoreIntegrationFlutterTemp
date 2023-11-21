import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nov20/user_model.dart';

saveUser({
  required String name,
  required String phone,
}) async {
  final doc = await FirebaseFirestore.instance
      .collection('users')
      .add({"name": name, "phone": phone});
  print(doc.id);
}

Future<List<UserModel>> getUsers() async {
  final querySnp = await FirebaseFirestore.instance.collection('users').get();
  List<UserModel> users = [];
  for (var doc in querySnp.docs) {
    users.add(UserModel.fromJson(doc.data()));
  }
  return users;
}

Future<UserModel?> getSingleUsers({required String docId}) async {
  final docSnp =
      await FirebaseFirestore.instance.collection('users').doc(docId).get();
  if (docSnp.exists) {
    var data = docSnp.data();
    data!["docId"] = docSnp.id;
    var user = UserModel.fromJson(data!);
    return user;
  }
  return null;
}

Future<List<UserModel>> getFilteredUser() async {
  final querySnp = await FirebaseFirestore.instance
      .collection('users')
      .where("name", isEqualTo: "Asad")
      .get();
  List<UserModel> users = [];
  for (var doc in querySnp.docs) {
    var data = doc.data();
    data["docId"] = doc.id;
    users.add(UserModel.fromJson(data));
  }
  return users;
}

deleteUser({required String docId}) async {
  await FirebaseFirestore.instance.collection('users').doc(docId).delete();
}

addActivity({required String userId, required String activityName}) async {
  final docRef = await FirebaseFirestore.instance
      .collection("users")
      .doc(userId)
      .collection("activity")
      .add({"name": activityName});
  print(docRef.id);
}
