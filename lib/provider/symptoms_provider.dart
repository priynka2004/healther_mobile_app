import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healther_mobile_app/model/create_symptoms_model.dart';
import 'package:healther_mobile_app/service/symptoms_service.dart';

class CreateSymptomsProvider extends ChangeNotifier {
  CreateSymptoms? createSymptoms;
  String? errorMessage;

  List<String> symptomsList = [];
  List<String> diagnosesList = [];



  Future<void> postCreateSymptoms(String searchText,
      List<String> selectedSymptoms,List<String> selectedDiagnoses) async {
    try {
      CreateSymptomsService createSymptomsService = Get.find();
      final result = await createSymptomsService.createSymptoms(
          searchText,selectedSymptoms,selectedDiagnoses);

      symptomsList = result['symptoms'] ?? [];
      diagnosesList = result['diagnoses'] ?? [];
      errorMessage = null;
    } catch (error) {
      errorMessage = error.toString();
    } finally {
      notifyListeners();
    }
   }

}
