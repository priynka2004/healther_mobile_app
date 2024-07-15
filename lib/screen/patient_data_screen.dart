import 'package:flutter/material.dart';
import 'package:healther_mobile_app/utils/app_colors.dart';
import 'package:healther_mobile_app/utils/shared_pref_service.dart';
import 'package:intl/intl.dart';




class SavedDataScreen extends StatelessWidget {
  final SharedPrefService _prefsService = SharedPrefService();

  SavedDataScreen({super.key});

  String formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      DateTime parsedDate = DateTime.parse(date);
      return DateFormat('dd MMMM yyyy').format(parsedDate);
    } catch (e) {
      return 'Invalid Date';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text('Saved Patient Data'),
        backgroundColor: const Color(0xFFE1F9F2),
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _prefsService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data found'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  _buildInfoCard(
                    title: 'Mobile No. :',
                    value: data['mobileNumber'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'First Name :',
                    value: data['firstName'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'Age :',
                    value: data['age'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'Gender :',
                    value: data['gender'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'Date of Birth :',
                    value: formatDate(data['dob']),
                  ),
                  _buildInfoCard(
                    title: 'SpO2 levels :',
                    value: data['spo2'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'Pulse Rate :',
                    value: data['pulseRate'] ?? 'N/A',
                  ),
                  _buildInfoCard(
                    title: 'RBS :',
                    value: data['rbs'] ?? 'N/A',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildInfoCard({required String title, required String value}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
