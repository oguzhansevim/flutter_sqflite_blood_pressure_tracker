class BloodPressure {
  int id;
  int systolicBloodPressure;
  int diastolicBloodPressure;
  int heartRhythm;
  String date;
  

  BloodPressure(this.systolicBloodPressure, this.diastolicBloodPressure,
      this.heartRhythm, this.date);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['systolic_blood_pressure'] = systolicBloodPressure;
    map['diastolic_blood_pressure'] = diastolicBloodPressure;
    map['heart_rhythm'] = heartRhythm;
    map['date'] = date;

    return map;
  }

  BloodPressure.fromMap(Map<String, dynamic> map) {
    systolicBloodPressure = map['systolic_blood_pressure'];
    diastolicBloodPressure = map['diastolic_blood_pressure'];
    heartRhythm = map['heart_rhythm'];
    date = map['date'];
    id = map['id'];
  }
}
