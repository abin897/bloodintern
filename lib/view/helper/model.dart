class User {
  String? id;
  late String name, ph, blood, gender, age, weight, donated,place;
  User(
      {this.id,
        required this.name,
        required this.place,
        required this.ph,
        required this.age,
        required this.blood,
        required this.gender,
        required this.donated,
        required this.weight});

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      "name": name,
      "ph": ph,
      "blood": blood,
      "age": age,
      "gender": gender,
      "donated": donated,
      "weight": weight,
      'place':place,
    };
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }
}