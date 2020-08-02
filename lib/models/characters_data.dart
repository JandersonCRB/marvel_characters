import 'package:marvel_characters/models/character.dart';

class CharacterData {
  List<Character> heroes;
  List<Character> villains;
  List<Character> antiHeroes;
  List<Character> aliens;
  List<Character> humans;

  CharacterData.fromJson(Map<String, dynamic> json) {
    if (json['heroes'] != null) {
      heroes = List<Character>();
      json['heroes'].forEach((v) {
        heroes.add(Character.fromJson(v));
      });
    }
    if (json['villains'] != null) {
      villains = List<Character>();
      json['villains'].forEach((v) {
        villains.add(Character.fromJson(v));
      });
    }
    if (json['antiHeroes'] != null) {
      antiHeroes = List<Character>();
      json['antiHeroes'].forEach((v) {
        antiHeroes.add(Character.fromJson(v));
      });
    }
    if (json['aliens'] != null) {
      aliens = List<Character>();
      json['aliens'].forEach((v) {
        aliens.add(Character.fromJson(v));
      });
    }
    if (json['humans'] != null) {
      humans = List<Character>();
      json['humans'].forEach((v) {
        humans.add(Character.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if(this.heroes != null) {
      data['heroes'] = this.heroes.map((h) => h.toJson());
    }
    if(this.villains != null) {
      data['heroes'] = this.heroes.map((h) => h.toJson());
    }
    if(this.aliens != null) {
      data['heroes'] = this.heroes.map((h) => h.toJson());
    }
    if(this.humans != null) {
      data['heroes'] = this.heroes.map((h) => h.toJson());
    }
    return data;
  }
}