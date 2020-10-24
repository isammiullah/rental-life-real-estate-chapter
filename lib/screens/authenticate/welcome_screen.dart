import 'package:flutter/material.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/shared/loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthenticationPage extends StatefulWidget {
  static final String path = "lib/screens/authenticate/welcome_screen.dart";

  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final AuthService _authService = AuthService();

  final String backImg = "image_assets/welcome_screen_bg.jpg";
  bool formVisible;
  int _formsIndex;
  bool loading = false;
  String error = '';

  @override
  void initState() {
    super.initState();
    formVisible = false;
    _formsIndex = 1;
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backImg),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  color: Colors.black54,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: kToolbarHeight + 40),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Welcome",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 30.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              "Welcome to Rental Life\nReal Estate Chapter.",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Column(
                        children: <Widget>[
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.red,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Login"),
                              onPressed: () {
                                setState(() {
                                  formVisible = true;
                                  _formsIndex = 1;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Signup"),
                              onPressed: () {
                                setState(() {
                                  formVisible = true;
                                  _formsIndex = 2;
                                });
                              },
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: RaisedButton(
                              color: Colors.grey.shade700,
                              textColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Text("Check"),
                              onPressed: () {
                                setState(() {
                                  formVisible = true;
                                  _formsIndex = 2;
                                });
                              },
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 40.0),
                      OutlineButton.icon(
                        borderSide: BorderSide(color: Colors.red),
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        icon:
                            Icon(FontAwesomeIcons.google, color: Colors.amber),
                        label: Text("Continue with Google"),
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
                      ),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: (!formVisible)
                      ? null
                      : Container(
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RaisedButton(
                                    textColor: _formsIndex == 1
                                        ? Colors.white
                                        : Colors.black,
                                    color: _formsIndex == 1
                                        ? Colors.red
                                        : Colors.white,
                                    child: Text("Login"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      setState(() {
                                        _formsIndex = 1;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10.0),
                                  RaisedButton(
                                    textColor: _formsIndex == 2
                                        ? Colors.white
                                        : Colors.black,
                                    color: _formsIndex == 2
                                        ? Colors.red
                                        : Colors.white,
                                    child: Text("Signup"),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    onPressed: () {
                                      setState(() {
                                        _formsIndex = 2;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 10.0),
                                  IconButton(
                                    color: Colors.white,
                                    icon: Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        formVisible = false;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Container(
                                child: AnimatedSwitcher(
                                  duration: Duration(milliseconds: 300),
                                  child: _formsIndex == 1
                                      ? SignInWithEmail()
                                      : Register(),
                                ),
                              )
                            ],
                          ),
                        ),
                )
              ],
            ),
          ));
  }
}

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
    return Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.email,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Enter email",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) => val.isEmpty ? 'Enter an email' : null),
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
                obscureText: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.lock,
                    color: Colors.blueGrey,
                  ),
                  hintText: "Enter password",
                  border: OutlineInputBorder(),
                ),
                validator: ((val) => val.length < 6
                    ? 'Enter a password atleast 6 characters long'
                    : null),
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text("Login"),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result =
                        await _authService.signInWithEmail(email, password);
                    if (result == null) {
                      setState(() {
                        loading = false;
                        return error =
                            'Invalid credentials. Could not sign it.';
                      });
                    }
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              Center(
                child: Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14),
                ),
              )
            ],
          ),
        ));
  }
}

/*class LoginForm extends StatelessWidget {
  const LoginForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Login"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}*/

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
  String firstName = '';
  String lastName = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                children: <Widget>[
                  /*Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[*/
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "First Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                        val.isEmpty ? 'First Name is mandatory' : null),
                    onChanged: (val) {
                      setState(() {
                        firstName = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Last Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) =>
                        val.isEmpty ? 'Last Name is mandatory' : null),
                    onChanged: (val) {
                      setState(() {
                        lastName = val;
                      });
                    },
                  ),
                  /*],
                  ),*/
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.email,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Enter email",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) => val.isEmpty ? 'Enter an email' : null),
                    onChanged: (val) {
                      setState(() {
                        email = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.lock,
                        color: Colors.blueGrey,
                      ),
                      hintText: "Enter password",
                      border: OutlineInputBorder(),
                    ),
                    validator: ((val) => val.length < 6
                        ? 'Enter a password atleast 6 characters long'
                        : null),
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  RaisedButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text("Signup"),
                    onPressed: () async {
                      print(email);
                      print(password);
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService.registerWithEmail(
                            email, password, firstName, lastName);
                        if (result == null) {
                          setState(() {
                            loading = false;
                            return error = 'Please supply a valid email id';
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Center(
                    child: Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ));
  }
}
/*

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          TextField(
            decoration: InputDecoration(

              hintText: "Enter email",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Enter password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Confirm password",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10.0),
          RaisedButton(
            color: Colors.red,
            textColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text("Signup"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
*/
