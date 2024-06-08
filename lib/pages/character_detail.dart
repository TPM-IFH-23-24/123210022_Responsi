import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsi/service/api_service.dart';

class CharacterDetail extends StatefulWidget{
  final String id;

  const CharacterDetail({super.key, required this.id});

  @override
  State<CharacterDetail> createState() => _CharacterDetailState();
}

class _CharacterDetailState extends State<CharacterDetail>{
  final api = ApiService();
  late Future<Map<String, dynamic>> genshinChar;

  @override
  void initState() {
    super.initState();
    _fetchCharacter();
  }

  void _fetchCharacter(){
    genshinChar = api.getCharacterByName(widget.id);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: genshinChar,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.hasData) {
              return Text(snapshot.data!['name']);
            } else {
              return Text('Character not found');
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: genshinChar,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characterData = snapshot.data!;
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      "https://genshin.jmp.blue/characters/${widget.id}/gacha-splash",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(
                          width: double.infinity,
                          child: Center(
                            child: Icon(
                              Icons.error_outline_outlined,
                            ),
                          ),
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return const SizedBox(
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    characterData['title'],
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text('Vision: ${characterData['vision']}'),
                  Text('Weapon: ${characterData['weapon']}'),
                  Text('Gender: ${characterData['gender']}'),
                  Text('Nation: ${characterData['nation']}'),
                  Text('Affiliation: ${characterData['affiliation']}'),
                  Text('Rarity: ${characterData['rarity']}'),
                  Text('Release Date: ${characterData['release']}'),
                  Text('Constellation: ${characterData['constellation']}'),
                  Text('Birthday: ${characterData['birthday']}'),
                  const SizedBox(height: 10),
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(characterData['description']),
                  const SizedBox(height: 10),
                  const Text(
                    'Skill Talents',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...characterData['skillTalents'].map<Widget>((skill) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            skill['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Unlock: ${skill['unlock']}'),
                          Text(skill['description']),
                          ...skill['upgrades'].map<Widget>((upgrade) {
                            return Text('${upgrade['name']}: ${upgrade['value']}');
                          }).toList(),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  const Text(
                    'Passive Talents',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...characterData['passiveTalents'].map<Widget>((talent) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            talent['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Unlock: ${talent['unlock']}'),
                          Text(talent['description']),
                        ],
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  const Text(
                    'Constellations',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  ...characterData['constellations'].map<Widget>((constellation) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            constellation['name'],
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Unlock: ${constellation['unlock']}'),
                          Text(constellation['description']),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Character not found'));
          }
        },
      ),
    );
  }
}