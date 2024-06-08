import 'package:flutter/material.dart';
import 'package:responsi/service/api_service.dart';

class WeaponList extends StatefulWidget {
  const WeaponList({super.key});

  @override
  State<WeaponList> createState()=>_WeaponListState();
}

class _WeaponListState extends State<WeaponList> {
  //final List<String> weaponList = ["a-thousand-floating-dreams","akuoumaru","alley-hunter","amber-catalyst","amenoma-kageuchi","amos-bow","apprentice-s-notes","aqua-simulacra","aquila-favonia","ballad-of-the-boundless-blue","ballad-of-the-fjords","beacon-of-the-reed-sea","beginner-s-protector","black-tassel","blackcliff-agate","blackcliff-amulet","blackcliff-longsword","blackcliff-pole","blackcliff-slasher","blackcliff-warbow","bloodtainted-greatsword","calamity-queller","cashflow-supervision","cinnabar-spindle","compound-bow","cool-steel","crane-s-echoing-call","crescent-pike","crimson-moon-s-semblance","dark-iron-sword","deathmatch","debate-club","dialogues-of-the-desert-sages","dodoco-tales","dragon-s-bane","dragonspine-spear","dull-blade","ebony-bow","elegy-for-the-end","emerald-orb","end-of-the-line","engulfing-lightning","everlasting-moonglow","eye-of-perception","fading-twilight","favonius-codex","favonius-greatsword","favonius-lance","favonius-sword","favonius-warbow","ferrous-shadow","festering-desire","fillet-blade","finale-of-the-deep","fleuve-cendre-ferryman","flowing-purity","forest-regalia","freedom-sworn","frostbearer","fruit-of-fulfillment","hakushin-ring","halberd","hamayumi","haran-geppaku-futsu","harbinger-of-dawn","hunter-s-bow","hunter-s-path","ibis-piercer","iron-point","iron-sting","jadefall-s-splendor","kagotsurube-isshin","kagura-s-verity","katsuragikiri-nagamasa","key-of-khaj-nisut","king-s-squire","kitain-cross-spear","light-of-foliar-incision","lion-s-roar","lithic-blade","lithic-spear","lost-prayer-to-the-sacred-winds","luxurious-sea-lord","magic-guide","mailed-flower","makhaira-aquamarine","mappa-mare","memory-of-dust","messenger","missive-windspear","mistsplitter-reforged","mitternachts-waltz","moonpiercer","mouun-s-moon","oathsworn-eye","old-merc-s-pal","otherworldly-story","pocket-grimoire","polar-star","portable-power-saw","predator","primordial-jade-cutter","primordial-jade-winged-spear","prospectors-drill","prototype-amber","prototype-archaic","prototype-crescent","prototype-grudge","prototype-malice","prototype-rancour","prototype-starglitter","quartz","rainslasher","range-gauge","raven-bow","recurve-bow","redhorn-stonethresher","rightful-reward","royal-bow","royal-greatsword","royal-grimoire","royal-longsword","royal-spear","rust","sacrificial-bow","sacrificial-fragments","sacrificial-greatsword","sacrificial-jade","sacrificial-sword","sapwood-blade","scion-of-the-blazing-sun","seasoned-hunter-s-bow","serpent-spine","sharpshooter-s-oath","silver-sword","skyrider-greatsword","skyrider-sword","skyward-atlas","skyward-blade","skyward-harp","skyward-pride","skyward-spine","slingshot","snow-tombed-starsilver","solar-pearl","song-of-broken-pines","song-of-stillness","splendor-of-tranquil-waters","staff-of-homa","staff-of-the-scarlet-sands","summit-shaper","sword-of-descension","sword-of-narzissenkreuz","talking-stick","the-alley-flash","the-bell","the-black-sword","the-catch","the-dockhands-assistant","the-first-great-magic","the-flute","the-stringless","the-unforged","the-viridescent-hunt","the-widsith","thrilling-tales-of-dragon-slayers","thundering-pulse","tidal-shadow","tome-of-the-eternal","toukabou-shigure","traveler-s-handy-sword","tulaytullah-s-remembrance","twin-nephrite","ultimate-overlord-s-mega-magic-sword","uraku-misugiri","verdict","vortex-vanquisher","wandering-evenstar","waster-greatsword","wavebreaker-s-fin","white-iron-greatsword","white-tassel","whiteblind","windblume-ode","wine-and-song","wolf-fang","wolf-s-gravestone","xiphos-moonlight"];
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
                                builder: (context) => const WeaponList()),
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
