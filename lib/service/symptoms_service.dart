import 'dart:convert';
import 'package:healther_mobile_app/utils/constants.dart';
import 'package:healther_mobile_app/utils/save_token.dart';
import 'package:http/http.dart' as http;

class CreateSymptomsService {
 // String tokens = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2MmNhMGFiMWEyNDMxZTE2YzQxZWJhZSIsImlhdCI6MTcyMDY5ODk3MiwiZXhwIjoxNzIwODcxNzcyfQ.WWavr8bNgTeslw9CUYr9oDNWJMQZ2RkgfON9-6hqa3Y";
  String tokens = "";
  Future<String?> fetchToken() async {
    return tokens = (await SharedPrefService.getAccessToken())!;
  }

  Future<Map<String, List<String>>> createSymptoms(String searchText) async {
    await fetchToken();
    print("Token: $tokens");

    String url = ApiEndPoint.createSymptoms;
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokens',
      },
      body: jsonEncode({
        "search_text": searchText,
        "input_symptoms": ["string"],
        "input_diagnoses": ["fev"],
        "n_diseases": 3,
        "n_symptoms": 3,
        "min_symptoms": 3
      }),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // if (data.containsKey('symptoms') && data.containsKey('diagnoses')) {
      //   final symptomsList = data['symptoms'] as List<dynamic>;
      //   final diagnosesList = data['diagnoses'] as List<dynamic>;
      //   return {
      //     'symptoms': symptomsList.cast<String>(),
      //     'diagnoses': diagnosesList.cast<String>(),
      //   };
      if (data.containsKey('search_output')) {
        final searchOutput = data['search_output'];
        final symptomsList = searchOutput['Symptoms'] as List<dynamic>?;
        final diagnosesList = searchOutput['Diagnoses'] as List<dynamic>?;
        return {
          'symptoms': symptomsList?.cast<String>() ?? [],
          'diagnoses': diagnosesList?.cast<String>() ?? [],
        };
      } else {
        throw Exception('Missing "search_output" key in response');
      }
    } else {
      throw Exception(
          'Failed to create symptoms (Status code: ${response.statusCode})');
    }
  }
}
