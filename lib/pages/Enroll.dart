// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:bloxcure/module/constant.dart';
import 'package:bloxcure/temp/temp.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:bloxcure/pages/Login.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Enroll extends StatefulWidget {
  const Enroll({Key? key}) : super(key: key);

  @override
  State<Enroll> createState() => _EnrollState();
}

class _EnrollState extends State<Enroll> {
  final _formKey = GlobalKey<FormState>();
  // final String ip = Constants.ip;
  late Response response;
  var isLoading = false;
  Dio dio = Dio();
  var apidata;
  var _pidController = TextEditingController(),
      _hidController = TextEditingController(),
      _keyController = TextEditingController();

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  _submit() async {
    Directory? downloadsDirectory;

    String url = "$ip/patient/enroll";

    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();
    setState(() {
      isLoading = true;
    });
    try {
      Response response = await dio.post(url, data: {
        "userID": _pidController.text,
        "secret": _keyController.text,
        "hospitalID": _hidController.text
      });
      print('Response: $response');
      if (response.statusCode == 201) {
        if (Platform.isAndroid) {
          if (await _requestPermission(Permission.storage)) {
            downloadsDirectory = await getExternalStorageDirectory();
            String newPath = "";
            List<String> paths = downloadsDirectory!.path.split("/");
            for (int x = 1; x < paths.length; x++) {
              String folder = paths[x];
              if (folder != "Android") {
                newPath += "/$folder";
              } else {
                break;
              }
            }

            newPath = "$newPath/Download/bloxcure";
            downloadsDirectory = Directory(newPath);
            File saveFile =
                File("${downloadsDirectory.path}/${_pidController.text}.id");
            await downloadsDirectory.create(recursive: true);
            saveFile.writeAsString('$response');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
                (route) => false);
          } else {
            print("NO BOY");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    } on DioError catch (e) {
      setState(() {
        isLoading = false;
      });
      _pidController.clear();
      _hidController.clear();
      _keyController.clear();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Error',style:
                        TextStyle(color: Colors.red, fontWeight: FontWeight.bold),),
                content: const Text("Unable to enroll. Please try again."),
                actions: <Widget>[
                  ElevatedButton(
                    child: const Text('Ok'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color.fromARGB(17, 18, 41, 255),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: <Widget>[
            Image.asset(
              'assets/images/bloxcure.png',
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: Text(
                        'Patient Enroll',
                        style: TextStyle(
                            fontSize: 35,
                            color: Color.fromARGB(255, 19, 165, 249),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) => value!.isEmpty ? 'PID is required' : null,
                controller: _pidController,
                decoration: const InputDecoration(
                  labelText: 'PID',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 68, 252, 255)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 68, 252, 255)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                validator: (value) => value!.isEmpty ? 'HID is required' : null,
                controller: _hidController,
                decoration: const InputDecoration(
                  labelText: 'HID',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 68, 252, 255)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 68, 252, 255)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                validator: (value) =>
                    value!.isEmpty ? 'Secret Key is required' : null,
                controller: _keyController,
                decoration: const InputDecoration(
                  labelText: 'Secret Key',
                  labelStyle:
                      TextStyle(color: Color.fromARGB(255, 68, 252, 255)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 68, 252, 255)),
                  ),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 15),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55),
              child: isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: (() => {_submit()}),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15.0),
                          minimumSize: const Size.fromHeight(30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                      child: const Text(
                        'ENROLL NOW',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 55, right: 55),
              child: ElevatedButton(
                  onPressed: (() => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                        )
                      }),
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15.0),
                      minimumSize: const Size.fromHeight(30),
                      primary: const Color.fromARGB(255, 59, 208, 84),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(
                            color: Color.fromARGB(255, 18, 117, 163)),
                      )),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ]),
        ),
      ),
    ));
  }
}
