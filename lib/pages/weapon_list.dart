import 'package:flutter/material.dart';
import 'package:responsi/pages/weapon_detail.dart';
import 'package:responsi/service/api_service.dart';

class WeaponList extends StatefulWidget {
  const WeaponList({super.key});

  @override
  State<WeaponList> createState()=>_WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  late Future<List<dynamic>> weaponList;
  final api = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchWeapons();
  }

  void _fetchWeapons() {
    weaponList = api.getWeapons();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Genshin Impact"),
        ),
        body: Center(
          child: FutureBuilder<List<dynamic>>(
              future: weaponList,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No characters found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var weapon = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeaponDetail(id: weapon)),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          width: double.infinity,
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 64,
                                          height: 64,
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(8.0),
                                            child: Image.network(
                                              "https://genshin.jmp.blue/weapons/${weapon}/icon",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          weapon,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue[900],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
        ),
      ),
    );
  }
}
