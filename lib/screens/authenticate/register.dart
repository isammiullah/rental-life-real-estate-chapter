/*
import 'package:flutter/material.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/shared/constants.dart';
import 'package:realestate/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0,
              title: Text('Sign Up to Rental Life Real Estate Chapter'),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Sign in'))
              ],
            ),
            body: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecorationForEmail,
                        validator: ((val) =>
                            val.isEmpty ? 'Enter an email' : null),
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: textInputDecorationForPassword,
                        obscureText: true,
                        validator: ((val) => val.length < 6
                            ? 'Enter a password atleast 6 characters long'
                            : null),
                        onChanged: (val) {
                          //setState(() {
                          password = val;
                          //});
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          print(email);
                          print(password);
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result = await _authService
                                .registerWithEmail(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                return error = 'Please supply a valid email';
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ],
                  ),
                )

                */
/*RaisedButton(
          child: Text('Sign in anonymously'),
          onPressed: () async{
            dynamic result = await _authService.signinAnon();
            if(result == null){
              print('Error Signing in anonymously');
            }else{
              print('Successfully signed In anonymously');
              print(result.uid);
            }
          },
        ),*//*


                ),
          );
  }
}
*/
