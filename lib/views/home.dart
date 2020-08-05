import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marvel_characters/components/character_background.dart';
import 'package:marvel_characters/components/custom_icons.dart';
import 'package:marvel_characters/models/character.dart';
import 'package:marvel_characters/models/characters_data.dart';
import 'package:marvel_characters/views/character_details.dart';

Color _backgroundColor = Color(0xFFF8F8F8);

class HomeScreen extends StatelessWidget {
  Future<CharacterData> fetchCharacters(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/application.json");
    final json = jsonDecode(data);
    return CharacterData.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyAppBar(),
        elevation: 0,
        backgroundColor: _backgroundColor,
      ),
      body: FutureBuilder(
        future: fetchCharacters(context),
        builder: (BuildContext context, AsyncSnapshot<CharacterData> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return HomeBody(
            data: snapshot.data,
          );
        },
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 71,
          height: 26,
          child: Image.asset("assets/images/app_bar_logo.png"),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search,
            color: Colors.black,
            size: 28,
          ),
        )
      ],
    );
  }
}

class HomeBody extends StatelessWidget {
  final CharacterData data;

  final scrollController = ScrollController();
  final heroKey = GlobalKey();
  final villainKey = GlobalKey();
  final antiHeroKey = GlobalKey();
  final alienKey = GlobalKey();
  final humanKey = GlobalKey();

  HomeBody({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Container(
        color: _backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Text(
                "Bem vindo ao Marvel Heroes",
                style: TextStyle(
                  fontFamily: "Gilroy",
                  fontSize: 14,
                  color: Color(0xFFB7B7C8),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
              child: Text(
                "Escolha o seu personagem",
                style: TextStyle(
                    fontFamily: "Gilroy heavy",
                    color: Color(0xFF313140),
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
            ),
            ShortcutsRow(
              scrollController: scrollController,
              humanKey: humanKey,
              villainKey: villainKey,
              antiHeroKey: antiHeroKey,
              heroKey: heroKey,
              alienKey: alienKey,
            ),
            Container(
              height: 48,
            ),
            CharactersDisplay(
              rootKey: heroKey,
              title: "Heróis",
              characters: data.heroes,
            ),
            Container(
              height: 48,
            ),
            CharactersDisplay(
              rootKey: villainKey,
              title: "Vilões",
              characters: data.villains,
            ),
            Container(
              height: 48,
            ),
            CharactersDisplay(
              rootKey: antiHeroKey,
              title: "Anti heróis",
              characters: data.antiHeroes,
            ),
            Container(
              height: 48,
            ),
            CharactersDisplay(
              rootKey: alienKey,
              title: "Alienígenas",
              characters: data.aliens,
            ),
            Container(
              height: 48,
            ),
            CharactersDisplay(
              rootKey: humanKey,
              title: "Humanos",
              characters: data.humans,
            ),
          ],
        ),
      ),
    );
  }
}

class ShortcutsRow extends StatelessWidget {
  final ScrollController scrollController;
  final Key heroKey;
  final Key villainKey;
  final Key antiHeroKey;
  final Key alienKey;
  final Key humanKey;

  const ShortcutsRow({
    Key key,
    @required this.scrollController,
    @required this.humanKey,
    @required this.heroKey,
    @required this.villainKey,
    @required this.antiHeroKey,
    @required this.alienKey,
  })  : assert(humanKey != null),
        assert(heroKey != null),
        assert(villainKey != null),
        assert(alienKey != null),
        assert(antiHeroKey != null),
        assert(scrollController != null),
        super(key: key);

  scrollTo(GlobalKey key) {
    scrollController.position.ensureVisible(
      key.currentContext.findRenderObject(),
      duration: Duration(milliseconds: 1300),
    );
  }

  Widget buildIcon(
    IconData icon,
    Color firstColor,
    Color secondColor,
    Function onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [firstColor, secondColor],
          ),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildIcon(
            CustomIcons.hero,
            Color(0xFF005BEA),
            Color(0xFF00C6FB),
            () => scrollTo(heroKey),
          ),
          buildIcon(
            CustomIcons.villain,
            Color(0xFFED1D24),
            Color(0xFFED1F69),
            () => scrollTo(villainKey),
          ),
          buildIcon(
            CustomIcons.antihero,
            Color(0xFFB224EF),
            Color(0xFF7579FF),
            () => scrollTo(antiHeroKey),
          ),
          buildIcon(
            CustomIcons.alien,
            Color(0xFF0BA360),
            Color(0xFF3CBA92),
            () => scrollTo(alienKey),
          ),
          buildIcon(
            CustomIcons.human,
            Color(0xFFFF7EB3),
            Color(0xFFFF758C),
            () => scrollTo(humanKey),
          ),
        ],
      ),
    );
  }
}

class CharactersDisplay extends StatelessWidget {
  final String title;
  final List<Character> characters;
  final Key rootKey;

  const CharactersDisplay({Key key, this.rootKey, this.title, this.characters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      key: rootKey,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Color(0xFFF2264B),
                  fontFamily: "Gilroy",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              FlatButton(
                onPressed: () {},
                child: Text(
                  "Ver tudo",
                  style: TextStyle(
                    color: Color(0xFFB7B7C8),
                    fontFamily: "Gilroy",
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 230,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 17),
            scrollDirection: Axis.horizontal,
            children: characters
                .map((c) => CharacterThumbnail(character: c))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class CharacterThumbnail extends StatelessWidget {
  final Character character;

  const CharacterThumbnail({Key key, this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CharacterDetails(
                character: this.character,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Hero(
              tag: "character-" + character.name,
              child: CharacterBackground(
                width: 140,
                height: 300,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                imagePath: character.imagePath,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.alterEgo,
                    style: TextStyle(
                      color: Color(0xBFFFFFFF),
                      fontFamily: "Gilroy",
                      fontSize: 10,
                    ),
                  ),
                  Container(
                    width: 100,
                    child: Text(
                      character.name,
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontFamily: "Gilroy",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
