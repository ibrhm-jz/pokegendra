class TeamModel {
  int? id;
  String? name;
  TeamModel({this.id, this.name});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
