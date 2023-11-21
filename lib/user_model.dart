class UserModel {
  String docId;
  String name;
  String phone;

  UserModel({
    required this.docId,
    required this.name,
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json)
      : docId = json["docId"],
        name = json["name"],
        phone = json["phone"];
}
