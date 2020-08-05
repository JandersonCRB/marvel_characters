import 'package:flutter/material.dart';
import 'package:marvel_characters/components/custom_icons.dart';
import 'package:marvel_characters/models/character.dart';

class CharacterDetails extends StatelessWidget {
  final Character character;

  const CharacterDetails({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double imageBgHeight = MediaQuery.of(context).size.height * 1.25;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: "character-" + character.name,
                  child: Container(
                    height: imageBgHeight,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets" + character.imagePath),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: imageBgHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [
                        0.05,
                        0.95,
                      ],
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.60),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character.alterEgo,
                              style: TextStyle(
                                color: Color(0xBFFFFFFF),
                                fontFamily: "Gilroy",
                                fontSize: 16,
                              ),
                            ),
                            Container(
                              width: 200,
                              child: Text(
                                character.name,
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 40,
                                  fontFamily: "Gilroy",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CaracteristicsRow(
                        birthYear: int.parse(character.caracteristics.birth),
                        weight: character.caracteristics.weight.toString(),
                        height: character.caracteristics.height.toString(),
                        universe: character.caracteristics.universe,
                      ),
                      Padding(
                        padding: EdgeInsets.all(24),
                        child: Text(
                          character.biography,
                          style:
                              TextStyle(color: Color(0xBFFFFFFF), fontSize: 14),
                        ),
                      ),
                      AbilitiesSection(
                        abilities: character.abilities,
                      ),
                      MoviesSection(
                        movieImages: character.movies,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CaracteristicsRow extends StatelessWidget {
  final int birthYear;
  final String weight;
  final String height;
  final String universe;
  final String age;

  CaracteristicsRow({
    Key key,
    @required this.birthYear,
    @required this.weight,
    @required this.height,
    @required this.universe,
  })  : age = "${DateTime.now().year - birthYear} anos",
        super(key: key);

  Widget buildIcon(IconData icon, String text) {
    return Container(
      width: 60,
      height: 48,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Color(0x99FFFFFF),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Gilroy",
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIcon(CustomIcons.age, age),
          buildIcon(CustomIcons.weight, weight),
          buildIcon(CustomIcons.height, height),
          buildIcon(CustomIcons.universe, universe),
        ],
      ),
    );
  }
}

class AbilitiesSection extends StatelessWidget {
  final Abilities abilities;
  static const _MAX_ABILITY_POWER = 44;

  const AbilitiesSection({
    Key key,
    @required this.abilities,
  }) : super(key: key);

  List<Widget> buildPoints(int value) {
    List<Widget> points = [];
    for (int i = 0; i < _MAX_ABILITY_POWER; i++) {
      points.add(
        Container(
          color: i <= value ? Color(0xFFFFFFFF) : Color(0x40FFFFFF),
          width: 2,
          height: i != value ? 10 : 14,
        ),
      );
    }
    return points;
  }

  Widget buildAbilityRow(BuildContext context, String name, int value) {
    print("name = $name, value = $value");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Text(
              name,
              style: TextStyle(
                color: Color(0xBFFFFFFF),
                fontFamily: "Gilroy",
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: buildPoints((44 * value / 100).round()),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Text(
              "Habilidades",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Gilroy",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          buildAbilityRow(context, "Força", abilities.force),
          buildAbilityRow(context, "Inteligência", abilities.intelligence),
          buildAbilityRow(context, "Agilidade", abilities.agility),
          buildAbilityRow(context, "Resistência", abilities.endurance),
          buildAbilityRow(context, "Velocidade", abilities.velocity),
        ],
      ),
    );
  }
}

class MoviesSection extends StatelessWidget {
  final List<String> movieImages;

  const MoviesSection({
    Key key,
    @required this.movieImages,
  })  : assert(movieImages != null),
        assert(movieImages.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    print(movieImages);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
          child: Text(
            "Filmes",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Gilroy",
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Container(
          height: 230,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 17),
            scrollDirection: Axis.horizontal,
            children: movieImages
                .map(
                  (mi) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("assets" + mi),
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      width: 150,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
