import 'package:bloxcure/module/ProfileData.dart';
import 'package:bloxcure/module/constant.dart';
import 'package:bloxcure/pages/SideBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bloxcure/temp/temp.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GrantDoctor extends StatefulWidget {
  const GrantDoctor({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  State<GrantDoctor> createState() => _GrantDoctorState();
}

class _GrantDoctorState extends State<GrantDoctor> {
  final storage = const FlutterSecureStorage();
  // final String ip = Constants.ip;
  late Response response;
  bool isLoading = false;
  Dio dio = Dio();
  var responseBody;

  Future<void> accessDoctors() async {
    setState(() {
      isLoading = true;
    });
    String url = "$ip/patient/doctors-access-granted";
    try {
      String? value = await storage.read(key: "token");
      var response = await dio.get(
        url,
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      print('RECV Response: $response');
      responseBody = response.data;
      setState(() {
        isLoading = false;
      });
    } on DioError catch (e) {
      print('Error Response: $e');
    }
  }

  Future<void> revokeDoctor(doctorID) async {
    setState(() {
      isLoading = true;
    });
    String url = "$ip/patient/revoke-access-from-doctor";
    try {
      String? value = await storage.read(key: "token");
      var response = await dio.post(
        url,
        data: {"doctorID": doctorID},
        options: Options(
          headers: {
            "cookie": value,
          },
        ),
      );
      print('RECV Response: $response');
      setState(() {
        isLoading = false;
        initState();
      });
    } on DioError catch (e) {
      print('Error Response: $e');
    }
  }

  @override
  initState() {
    accessDoctors();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(profile: widget.profile),
      appBar: AppBar(
        title: const Center(child: Text('Granted Doctors')),
        backgroundColor: const Color.fromARGB(255, 147, 204, 78),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  responseBody.isEmpty
                      ? const Center(child: Text("No Doctor to show"))
                      : Expanded(
                          child: ListView.builder(
                            itemCount: responseBody.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(
                                  responseBody[index]["doctorID"].toString()),
                              color: const Color.fromARGB(255, 147, 204, 78),
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  const Expanded(
                                    flex: 2,
                                    child: CircleAvatar(
                                      radius: 35.0,
                                      backgroundImage: AssetImage(
                                          'assets/images/docpic.png'),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${responseBody[index]['firstName']} '
                                            ' ${responseBody[index]['lastName']}',
                                            style: const TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            responseBody[index]['doctorID'],
                                            style: const TextStyle(
                                                color: Colors.blue),
                                          ),
                                          Text(
                                            responseBody[index]['speciality'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          Text(
                                            responseBody[index]["phoneNumber"]
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      trailing: ElevatedButton(
                                          onPressed: () {
                                            revokeDoctor(responseBody[index]
                                                ['doctorID']);
                                            
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white),
                                          child: const Text(
                                            "Revoke",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
