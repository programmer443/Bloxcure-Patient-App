// ignore_for_file: non_constant_identifier_names

class ProfileData {
  String patientID,
      firstName,
      lastName,
      CNIC,
      nationality,
      birthDate,
      gender,
      phoneNumber,
      address,
      blood,
      allergies,
      diagnosis,
      treatment,
      followUp,
      mspID,
      symptoms;

  ProfileData({
    required this.patientID, required this.firstName,
    required this.lastName,
    required this.CNIC,
    required this.nationality,
    required this.birthDate,
    required this.gender,
    required this.phoneNumber,
    required this.address,
    required this.blood,
    required this.allergies,
    required this.diagnosis,
    required this.treatment,
    required this.followUp,
    required this.mspID,
    required this.symptoms,
  });
}
