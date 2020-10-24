import 'package:provider/provider.dart';
import 'package:realestate/model/user.dart';
import 'package:flutter/material.dart';
import 'package:realestate/screens/home/settings_form.dart';
import 'package:realestate/services/auth.dart';
import 'package:realestate/services/database.dart';
import 'package:realestate/shared/loading.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService _authService = AuthService();

  void _showSettingsPanel() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SettingsForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserDocumentData>(
        stream: DatabaseService(uid: user.uid).userDataDocument,
        builder: (context, snapshot) {
          //Snapshot here is not from firebase, it is data coming down the stream.
          if (snapshot.hasData) {
            UserDocumentData userDocumentData = snapshot.data;
            return Scaffold(
                backgroundColor: Colors.grey.shade100,
                extendBodyBehindAppBar: true,
                extendBody: true,
                appBar: AppBar(

                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  /*actions: <Widget>[
                    FlatButton.icon(
                        onPressed: () async {
                          await _authService.signOut();
                        },
                        icon: Icon(Icons.person),
                        label: Text('Sign Out')),
                    FlatButton.icon(
                        onPressed: () => _showSettingsPanel(),
                        icon: Icon(Icons.settings),
                        label: Text('settings')),
                  ],*/
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ProfileHeader(
                        avatar: NetworkImage(
                            "https://www.deviantart.com/emicraftz/art/Anonymous-Profile-Picture-by-EmiCraftZ-630955348"),
                        coverImage: NetworkImage(
                            "https://www.awazieikechi.com/wp-content/uploads/2016/11/Take-the-first-step-in-faith.-You-dont-have-to-see-the-whole-staircase-just-take-the-first-step.jpg"),
                        title:
                            "${userDocumentData.firstName} ${userDocumentData.lastName}" ??
                                "Set Your Name",
                        subtitle: "User",
                        actions: <Widget>[
                          MaterialButton(
                            color: Colors.white,
                            shape: CircleBorder(),
                            elevation: 0,
                            child: Icon(Icons.edit),
                            onPressed: () {},
                          )
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      UserInfo(
                        userDocumentData: userDocumentData,
                      ),
                    ],
                  ),
                ));
          } else {
            return Loading();
          }
        });
  }
}

class UserInfo extends StatelessWidget {
  UserDocumentData userDocumentData;

  UserInfo({this.userDocumentData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            leading: Icon(Icons.my_location),
                            title: Text("Location"),
                            subtitle: Text("Islamabad"),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text(userDocumentData.email),
                          ),
                          ListTile(
                            leading: Icon(Icons.perm_identity),
                            title: Text("User ID"),
                            subtitle: Text(userDocumentData.uid),
                          ),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: Text("About Me"),
                            subtitle: Text("${userDocumentData.age} years old"),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final ImageProvider<dynamic> coverImage;
  final ImageProvider<dynamic> avatar;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  const ProfileHeader(
      {Key key,
      @required this.coverImage,
      @required this.avatar,
      @required this.title,
      this.subtitle,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Ink(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: coverImage, fit: BoxFit.cover),
          ),
        ),
        Ink(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black38,
          ),
        ),
        if (actions != null)
          Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 160),
          child: Column(
            children: <Widget>[
              Avatar(
                image: avatar,
                radius: 40,
                backgroundColor: Colors.white,
                borderColor: Colors.grey.shade300,
                borderWidth: 4.0,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key key,
      @required this.image,
      this.borderColor = Colors.grey,
      this.backgroundColor,
      this.radius = 30,
      this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor != null
            ? backgroundColor
            : Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image,
        ),
      ),
    );
  }
}
