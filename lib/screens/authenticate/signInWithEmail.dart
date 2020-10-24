import 'package:flutter/material.dart';
import 'package:realestate/screens/authenticate/register.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/shared/constants.dart';
import 'package:realestate/shared/loading.dart';

class SignInWithEmail extends StatefulWidget {
  final Function toggleView;
  SignInWithEmail({this.toggleView});
  @override
  _SignInWithEmailState createState() => _SignInWithEmailState();
}

class _SignInWithEmailState extends State<SignInWithEmail> {

  bool loading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[900],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 500,
        title: Text (
          'Sign In',
          style: TextStyle(
              color: Colors.brown
          ),
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical:20, horizontal: 50 ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 100,),
                TextFormField(
                  decoration: textInputDecorationForEmail,
                  validator: ((val)=> val.isEmpty ?
                  'Enter an email':
                  null),
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });

                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecorationForPassword,
                  validator: ((val)=> val.length < 6 ?
                  'Enter a password atleast 6 characters long'
                      : null),
                  obscureText: true,
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async{
                    if(_formKey.currentState.validate()){
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _authService.signInWithEmail(email, password);
                      if(result == null){
                        setState(() {
                          loading = false;
                          return error = 'Invalid credentials. Could not sign it.';
                        });
                      }
                    }

                  },
                ),
                SizedBox(height: 12,),
                Text(
                  error,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 14),
                ),
              ],
            ),

          )


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
        ),*/

      ),
    );
  }
}
