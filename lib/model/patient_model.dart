import 'package:healther_mobile_app/model/symptoms_model.dart';
import 'package:healther_mobile_app/model/vital_model.dart';

class PatientModel {
  String name;
  String mob;
  int age;
  String date;
  String dob;
  String gender;
  Vital? vitals;
  List<Symptoms> symptomsList = [];

  PatientModel({
    required this.name,
    required this.age,
    required this.date,
    required this.dob,
    required this.mob,
    required this.gender,
    this.vitals,
  });

  void addSymptom(Symptoms symptoms) {
    symptomsList.add(symptoms);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mob': mob,
      'age': age,
      'date': date,
      'dob': dob,
      'gender': gender,
      'vitals': vitals?.toJson(),
      'symptomsList': symptomsList.map((symptom) => symptom.toJson()).toList(),
    };
  }

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      name: json['name'],
      mob: json['mob'],
      age: json['age'],
      date: json['date'],
      dob: json['dob'],
      gender: json['gender'],
      vitals: json['vitals'] != null ? Vital.fromJson(json['vitals']) : null,
    )..symptomsList = (json['symptomsList'] as List)
        .map((symptom) => Symptoms.fromJson(symptom))
        .toList();
  }
}
