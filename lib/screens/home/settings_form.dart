import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:realestate/services/database.dart';
import 'package:realestate/shared/constants.dart';
import 'package:realestate/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

List<int> createAgeArray() {
  List<int> age = new List();
  for (int i = 0; i <= 100; i++) {
    age.add(i);
  }
  return age;
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<int> age = createAgeArray();

  String firstName;
  String lastName;
  String _currentPhoneNumber;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserDocumentData>(
        stream: DatabaseService(uid: user.uid).userDataDocument,
        builder: (context, snapshot) {
          //Snapshot here is not from firebase, it is data coming down the stream.
          if (snapshot.hasData) {
            UserDocumentData userDocumentData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your Info',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    initialValue: userDocumentData.firstName ?? userDocumentData.firstName,
                    decoration: InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                    val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => firstName = val),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextFormField(

                    initialValue: userDocumentData.lastName ?? userDocumentData.lastName,
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (val) =>
                    val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => lastName = val),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  //dropdown
                  DropdownButtonFormField(
                    decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                    value: _currentAge ?? userDocumentData.age,
                    items: age.map((a) {
                      return DropdownMenuItem(
                        value: a,
                        child: Text('Age: $a'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentAge = val),
                  ),
                  //slider
                  Slider(
                    value: (_currentAge ?? userDocumentData.age).toDouble(),
                    activeColor: Colors.blue[_currentAge ?? (((userDocumentData.age+1)%10)*100)],
                    inactiveColor: Colors.blue[_currentAge ?? (((userDocumentData.age+1)%10)*100)],
                    min: 0,
                    max: 100,
                    divisions: 85,
                    onChanged: (val) =>
                        setState(() => _currentAge = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                          firstName ?? userDocumentData.firstName,
                            lastName ?? userDocumentData.lastName,
                            userDocumentData.email,
                            _currentAge ?? userDocumentData.age);
                      }
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
