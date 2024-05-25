import 'package:flutter/material.dart';
import 'package:responsi/pages/weapon_list.dart';
import 'package:responsi/service/api_service.dart';

class CharacterList extends StatefulWidget {
  const CharacterList({super.key});
  @override
  State<CharacterList> createState() => _CharacterListState();
}

class _CharacterListState extends State<CharacterList> {
  List<String> genshinChar = [
    "albedo",
    "alhaitham",
    "aloy",
    "amber",
    "arataki-itto",
    "arlecchino",
    "ayaka",
    "ayato",
    "baizhu",
    "barbara",
    "beidou",
    "bennett",
    "candace",
    "charlotte",
    "chevreuse",
    "chiori",
    "chongyun",
    "collei",
    "cyno",
    "dehya",
    "diluc",
    "diona",
    "dori",
    "eula",
    "faruzan",
    "fischl",
    "freminet",
    "furina",
    "gaming",
    "ganyu",
    "gorou",
    "hu-tao",
    "jean",
    "kaeya",
    "kaveh",
    "kazuha",
    "keqing",
    "kirara",
    "klee",
    "kokomi",
    "kuki-shinobu",
    "layla",
    "lisa",
    "lynette",
    "lyney",
    "mika",
    "mona",
    "nahida",
    "navia",
    "neuvillette",
    "nilou",
    "ningguang",
    "noelle",
    "qiqi",
    "raiden",
    "razor",
    "rosaria",
    "sara",
    "sayu",
    "shenhe",
    "shikanoin-heizou",
    "sucrose",
    "tartaglia",
    "thoma",
    "tighnari",
    "traveler-anemo",
    "traveler-dendro",
    "traveler-electro",
    "traveler-geo",
    "traveler-hydro",
    "venti",
    "wanderer",
    "wriothesley",
    "xiangling",
    "xianyun",
    "xiao",
    "xingqiu",
    "xinyan",
    "yae-miko",
    "yanfei",
    "yaoyao",
    "yelan",
    "yoimiya",
    "yun-jin",
    "zhongli"
  ];
  List<String> iconChar = [];
  final api = ApiService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Genshin Impact"),
      ),
      body: Center(
          child: ListView.builder(
        itemCount: genshinChar.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const WeaponList()),
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
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  "https://genshin.jmp.blue/characters/${genshinChar[index]}/icon",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              genshinChar[index],
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
      )),
    ));
  }
}
