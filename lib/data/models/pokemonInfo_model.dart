// ignore_for_file: file_names

class PokemonInfoModel {
  int? height;
  String? name;
  int? experience;
  int? weight;

  // List<String?>? types;
  PokemonInfoModel();
  PokemonInfoModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    height = json['height'];
    experience = json['base_experience'];
    weight = json['weight'];
  }
  Map<String, dynamic> toJson() => {};
}
