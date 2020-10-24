class User {
  final String uid;

  User({this.uid});
}

class UserDocumentData {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final int age;
  String bio;

  UserDocumentData({this.uid, this.firstName, this.lastName, this.email, this.age});

}
