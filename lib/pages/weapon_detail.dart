import 'package:flutter/material.dart';
import 'package:responsi/service/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeaponDetail extends StatefulWidget {
  final String id;

  const WeaponDetail({super.key, required this.id});

  @override
  State<WeaponDetail> createState() => _WeaponDetailState();
}

class _WeaponDetailState extends State<WeaponDetail> {
  final api = ApiService();
  late Future<Map<String, dynamic>> weapon;

  @override
  void initState() {
    super.initState();
    _fetchWeapon();
  }

  void _fetchWeapon() {
    weapon = api.getWeaponByName(widget.id);
  }

  Future<void> _saveLastSeen(String name, String imageUri, String type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_seen_name', name.toLowerCase());
    await prefs.setString('last_seen_image', imageUri);
    await prefs.setString('last_seen_type', type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: weapon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading...');
            } else if (snapshot.hasError) {
              return Text('Error');
            } else if (snapshot.hasData) {
              return Text(snapshot.data!['name']);
            } else {
              return Text('Weapon not found');
            }
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: weapon,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final weaponData = snapshot.data!;
            _saveLastSeen(widget.id, "https://genshin.jmp.blue/weapons/${widget.id}/icon", 'weapons');
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Image.network(
                          "https://genshin.jmp.blue/weapons/${widget.id}/icon",
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error_outline, size: 100);
                          },
                        ),
                        SizedBox(height: 10),
                        Text(
                          weaponData['name'],
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(weaponData['rarity'], (index) {
                            return Icon(
                              Icons.star,
                              size: 20,
                              color: Colors.amber,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Type: ${weaponData['type']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Base Attack: ${weaponData['baseAttack']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Sub Stat: ${weaponData['subStat']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Passive Name: ${weaponData['passiveName']}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Passive Description: ${weaponData['passiveDesc']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Location: ${weaponData['location']}',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Ascension Material: ${weaponData['ascensionMaterial']}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Weapon not found'));
          }
        },
      ),
    );
  }
}
