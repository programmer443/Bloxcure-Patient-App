// ignore_for_file: file_names, avoid_print

import 'package:bloxcure/module/ProfileData.dart';
import 'package:bloxcure/pages/GrantDoctor.dart';
import 'package:bloxcure/pages/DoctorList.dart';
import 'package:bloxcure/pages/Profile.dart';
import 'package:bloxcure/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SideBar extends StatelessWidget {
  const SideBar({Key? key, required this.profile}) : super(key: key);
    final ProfileData profile;


  @override
  Widget build(BuildContext context) {
    final storage = new FlutterSecureStorage();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 147, 204, 78),
                ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children:   [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/images/pprofile.png'),
                  backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(height: 5,),
                Text(
                  '${profile.firstName} ${profile.lastName}',
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
                const SizedBox(height: 10,),
                Text(
                  profile.phoneNumber,
                  style: const TextStyle(color: Color.fromARGB(255, 32, 76, 95), fontSize: 16),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () => {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  Profile(profile: profile,)
              )
              )},
          ),
          ListTile(
            leading: const Icon(Icons.volunteer_activism),
            title: const Text('Access List'),
            onTap: () => {Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => GrantDoctor(profile: profile,)
              )
              )},
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('All Doctors'),
            onTap: () => {Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => DoctorList(profile: profile,)
              )
              )},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => {
              Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
                storage.deleteAll();
                return const Login();
              }
              )
              )},
          ),
        ],
      ),
    );
  }
}