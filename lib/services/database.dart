import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/model/userInfo.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  //Collection reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  //create a new document with uid
  Future updateUserData(String firstName, String lastName, String email, int age) async {
    return await userCollection
        .document(uid)
        .setData({'first name': firstName,'last name': lastName, 'email': email, 'age': age});
  }

  //UserInfo list from snapshot
  List<UserData> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
          firstName: doc.data['first name'] ?? '',
          lastName: doc.data['last name'] ?? '',
          email: doc.data['email'] ?? '',
          age: doc.data['age'] ?? 0);
    }).toList();
  }

  //Get user stream
  Stream<List<UserData>> get userDocumentsStream {
    return userCollection.snapshots().map(_userInfoListFromSnapshot);
  }

  //Convert document snapshot into UserDocumentData object
  UserDocumentData _userDocumentDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDocumentData(
      uid: uid,
      firstName: snapshot.data['first name'],
      lastName: snapshot.data['last name'],
      email: snapshot.data['email'],
      age: snapshot.data['age'],
    );
  }

  //Get user document Stream
  Stream<UserDocumentData> get userDataDocument {
    return userCollection
        .document(uid)
        .snapshots()
        .map(_userDocumentDataFromSnapshot);
  }
}
