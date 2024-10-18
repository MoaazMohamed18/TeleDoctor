import 'package:flutter/material.dart';
import 'package:teledoctor_project/Screens/LoginScreen.dart';

class DRW extends StatelessWidget {
  const DRW({super.key});

  @override
  Widget build(BuildContext context) {
    const drawerHeader = UserAccountsDrawerHeader(
      accountName: Text('Moaaz Mohamed'),
      accountEmail: Text('moaaz@gmail.com'),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: <Widget>[
        drawerHeader,
        ListTile(
          leading: Icon(Icons.logout_sharp),
          title: const Text('Log out'),
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (c){
                return LoginScreen();
              })
          ),
        ),
        // ListTile(
        //   title: const Text('other drawer item'),
        //   onTap: () {},
        // ),
      ],
    );
    return Drawer(child: drawerItems);
  }
}
