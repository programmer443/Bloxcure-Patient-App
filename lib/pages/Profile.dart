// ignore_for_file: file_names, use_build_context_synchronously

import 'package:bloxcure/module/ProfileData.dart';
import 'package:bloxcure/module/constant.dart';
import 'package:bloxcure/temp/temp.dart';
import 'package:bloxcure/pages/SideBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final storage = const FlutterSecureStorage();
  // final String ip = Constants.ip;
  late Response response;
  Dio dio = Dio();

  Future<void> getProfile() async {
    // setState(() {
    //   isLoading = true;
    // });
    String url = "$ip/patient/login";
    try {
      String? value = await storage.read(key: "token");
      var response = await dio.post(
        url,
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
    var responseBody = response.data;
      // print('RECV Response: $responseBody');
      final profile = ProfileData(
      patientID: '${responseBody['patientID']}',
      firstName: '${responseBody['firstName']}',
      lastName: '${responseBody['lastName']}',
      CNIC: '${responseBody['CNIC']}',
      birthDate: '${responseBody['birthDate']}',
      gender: '${responseBody['gender']}',
      phoneNumber: '${responseBody['phoneNumber']}',
      nationality: '${responseBody['nationality']}',
      address: '${responseBody['address']}',
      blood: '${responseBody['blood']}',
      allergies: '${responseBody['allergies']}',
      symptoms: '${responseBody['symptoms']}',
      diagnosis: '${responseBody['diagnosis']}',
      treatment: '${responseBody['treatment']}',
      followUp: '${responseBody['followUp']}',
      mspID: '${responseBody['mspID']}',
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Profile(profile: profile)),
        (route) => false);
    } on DioError catch (e) {
      print('Error Response: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
   return  Scaffold(
      drawer: SideBar(profile: widget.profile),
      appBar: AppBar(
        title:  const Center(
          child:
           Text('Patient Profile')
        ),
        backgroundColor: const Color.fromARGB(255, 147, 204, 78),
      ),
        body: RefreshIndicator(
          onRefresh: ()=> getProfile(),
          child: Container(
              color: Colors.white,
              child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
               Container(
                  height: 200.0,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Stack(fit: StackFit.loose, children: <Widget>[
                         Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             Container(
                                  width: 140.0,
                                  height: 140.0,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: ExactAssetImage(
                                          'assets/images/pic.png'),
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            ],
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
               Container(
                  color: const Color(0xffFFFFFF),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Parsonal Information',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Patient ID',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: widget.profile.patientID,
                                          hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'First Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Last Name',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintText: widget.profile.firstName,
                                          hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: widget.profile.lastName,
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'CNIC',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Birthday',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                          hintText: widget.profile.CNIC),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.birthDate),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                            Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Blood Group',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Treatment',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.grey,
                                        ),
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:  <Widget>[
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                          hintText: widget.profile.blood),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.treatment),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Mobile',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.phoneNumber),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Allergies',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.allergies),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Symptoms',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children:  <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.symptoms),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Diagnosis',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children:  <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.diagnosis),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Follow Up',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.followUp),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: const <Widget>[
                                   Text(
                                      'Address',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                               Flexible(
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                                        hintText: widget.profile.address),
                                    enabled: false,
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
              ),
            ),
        )); 
  }
}
