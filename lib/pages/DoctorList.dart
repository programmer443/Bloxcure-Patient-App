import 'package:bloxcure/module/ProfileData.dart';
import 'package:bloxcure/module/constant.dart';
import 'package:bloxcure/temp/temp.dart';
import 'package:bloxcure/pages/SideBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DoctorList extends StatefulWidget {
  const DoctorList({Key? key, required this.profile}) : super(key: key);
  final ProfileData profile;

  @override
  State<DoctorList> createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final storage = const FlutterSecureStorage();
  // final String ip = Constants.ip;
  late Response response;
  bool isLoading = false;
  var num;
  Dio dio = Dio();
  var responseBody;

  Future<void> showDoctors() async {
    setState(() {
      isLoading = true;
    });
    String url = "$ip/patient/query-all-doctors";
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

  Future<void> grantDoctor(doctorID) async {
    setState(() {
      isLoading = true;
    });
    String url =
        "$ip/patient/grant-access-to-doctor";
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
      });
    } on DioError catch (e) {
      print('Error Response: $e');
    }
  }

  @override
  initState() {
    showDoctors();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(profile: widget.profile),
      appBar: AppBar(
        title: const Center(child: Text('All Doctors')),
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
                                            "${responseBody[index]['doctorID']} , ${responseBody[index]['mspID']}",
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
                                            grantDoctor(responseBody[index]
                                                ['doctorID']);
                                            num =  responseBody[index];
                                                
                                          },
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.white),
                                          child: Text(
                                            responseBody[index]==num?"Granted":"Grant",
                                            style: const TextStyle(
                                                color: Colors.green,
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
