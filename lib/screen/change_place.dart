import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../world_time_logic.dart';

class Location extends StatefulWidget {
  const Location({Key? key}) : super(key: key);

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  List<WorldTime> locations = [
    WorldTime('Europe/London', 'uk.png'),
    WorldTime('Europe/Athens', 'greece.png'),
    WorldTime('Africa/Cairo', 'egypt.png'),
    WorldTime('Africa/Nairobi', 'kenya.png'),
    WorldTime('America/Chicago', 'usa.png'),
    WorldTime('America/New_York', 'usa.png'),
    WorldTime('Asia/Seoul', 'south_korea.png'),
    WorldTime('Asia/Jakarta', 'indonesia.png'),
    WorldTime('Asia/Kolkata', 'indonesia.png'),
  ];
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String link="";
  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    final SharedPreferences prefs = await _prefs;
    String ans = (prefs.getString('counter') ?? "Asia/Kolkata");
    setState(() {
      link=ans;
    });
    print(link);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black26,
        elevation: 0,
      ),
      body: link==null?Text('hu'):ListView.builder(
        itemBuilder: (context, i) {
          return Card(
            color: locations[i].location==link? Colors.red:Colors.black12,
            margin: const EdgeInsets.all(5),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    "/",
                    (r) => false,
                    arguments: {
                      'location': locations[i].location,
                      'flag': locations[i].flag
                    },
                  );
                },
                child: Text(locations[i].location,),
              ),
            ),
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}
