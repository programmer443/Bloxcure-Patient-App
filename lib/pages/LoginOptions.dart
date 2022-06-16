// ignore_for_file: file_names

import 'package:bloxcure/pages/enroll.dart';
import 'package:bloxcure/pages/login.dart';
import 'package:bloxcure/temp/temp.dart';
import 'package:flutter/material.dart';

class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Temp(),
                  ));
            },
            icon: Icon(Icons.abc)),
        backgroundColor: Colors.transparent,
      ),
        // backgroundColor: const Color.fromARGB(17, 18, 41, 255),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Image.asset(
                  'assets/images/hospital.png',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Column(
                children: [
                  const Text('Welcome',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.orange,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text('Login or Enroll for better services',
                      style: TextStyle(fontSize: 14, color: Colors.orange)),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ),
                              )
                            }),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15.0),
                            minimumSize: const Size.fromHeight(40),
                            // primary: Color.fromARGB(255, 0, 64, 255),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.white)),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        child: const Text('Login')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                        onPressed: (() => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const Enroll()),
                              )
                            }),
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15.0),
                            minimumSize: const Size.fromHeight(40),
                            primary: const Color.fromARGB(255, 59, 208, 84),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(color: Colors.white)),
                            textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        child: const Text('Enroll')),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
