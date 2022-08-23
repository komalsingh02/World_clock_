import 'package:flutter/material.dart';
import 'package:world_clock/world_time_logic.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String link;

  Future<void> setLocation(String url) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setString('counter', url);
      link = url;
    });
  }

  Future<String> readUrl() async {
    final SharedPreferences prefs = await _prefs;
    String ans = (prefs.getString('counter') ?? "Asia/Kolkata");
    setState(() {
      link = ans;
    });
    return ans;
  }

  late var mp;
  getTime() async {
    var timeObj = WorldTime(link, "ad");
    await timeObj.getTime();
    //ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': timeObj.location,
      'time': timeObj.time,
      'flag': timeObj.flag,
      'analog_time': timeObj.analogTime,
      'isDay': timeObj.isDay
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (ModalRoute.of(context)?.settings.arguments != null) {
      mp = ModalRoute.of(context)?.settings.arguments;
      await setLocation(mp['location']);
    }
    await readUrl();
    await getTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SpinKitRing(
      color: Colors.white,
      size: 50.0,
    ));
  }
}
