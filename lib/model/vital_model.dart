class Vital {
  String spLevel;
  String pulseRate;
  String rbs;

  Vital({required this.spLevel, required this.pulseRate, required this.rbs});

  Map<String, dynamic> toJson() {
    return {
      'spLevel': spLevel,
      'pulseRate': pulseRate,
      'rbs': rbs,
    };
  }

  factory Vital.fromJson(Map<String, dynamic> json) {
    return Vital(
      spLevel: json['spLevel'],
      pulseRate: json['pulseRate'],
      rbs: json['rbs'],
    );
  }
}