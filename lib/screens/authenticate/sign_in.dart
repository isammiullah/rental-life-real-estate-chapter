import 'package:flutter/material.dart';
import 'package:realestate/screens/authenticate/signInWithEmail.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  //final _formKey = GlobalKey<FormState>();

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
            backgroundColor: Colors.tealAccent[400],
            appBar: AppBar(
              backgroundColor: Colors.teal,
              elevation: 500,
              title: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                FlatButton.icon(
                    onPressed: () {
                      widget.toggleView();
                    },
                    icon: Icon(Icons.person),
                    label: Text('Register'))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.email),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                    color: Colors.teal,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInWithEmail()),
                      );
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                      height: 20,
                      indent: 20,
                      endIndent: 20,
                      thickness: 0,
                      color: Colors.teal),
                  SizedBox(height: 20),
                  Text(
                    'Login with other ways',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _authService.signInWithGoogle();
                      if (result == null) {
                        setState(() {
                          loading = false;
                          return error =
                              'Invalid credentials. Could not sign it.';
                        });
                      }
                    },
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Colors.teal,
                            Color(0xFFDD2C00),
                            //Color(0xFFFFC400),
                            //Color(0xFF689F38),
                            Color(0xFF0277BD),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                              image: AssetImage("image_assets/google_logo.png"),
                              height: 35.0),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              'Connect with Google',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  /*RaisedButton(
                        child: Text('Facebook Login'),
                        onPressed: ()async{
                          setState(() {
                            loading = true;
                          });
                          User result  =
                          await _authService.signInWithFacebook();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              return error =
                              'Invalid credentials. Could not sign it.';
                            });
                          }
                          else{
                            print('Facebook login success.:  $result.uid');
                          }
                        },
                      ),*/
                  /*OutlineButton(
                        hoverColor: Colors.orange,
                        splashColor: Colors.white,
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              return error =
                                  'Invalid credentials. Could not sign it.';
                            });
                          }
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        highlightElevation: 0,
                        borderSide: BorderSide(color: Colors.green),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                  image: AssetImage(
                                      "image_assets/google_logo.png"),
                                  height: 35.0),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Connect with Google',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red[900],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),*/
                  /*SizedBox(
                        height: 20,
                      ),
                      RaisedButton.icon(
                        icon: Icon(Icons.email),
                        color: Colors.orange,
                        label: Text(
                          'Sign in With Google',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _authService.signInWithGoogle();
                          if (result == null) {
                            setState(() {
                              loading = false;
                              return error =
                                  'Invalid credentials. Could not sign it.';
                            });
                          }
                        },
                      ),*/
                ],
              ),

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
