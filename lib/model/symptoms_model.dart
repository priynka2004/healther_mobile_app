class Symptoms {
  String name;
  String time;
  String timeType;
  String? privateNote;

  Symptoms({
    required this.name,
    required this.time,
    required this.timeType,
    this.privateNote,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'time': time,
      'timeType': timeType,
      'privateNote': privateNote,
    };
  }

  factory Symptoms.fromJson(Map<String, dynamic> json) {
    return Symptoms(
      name: json['name'],
      time: json['time'],
      timeType: json['timeType'],
      privateNote: json['privateNote'],
    );
  }
}