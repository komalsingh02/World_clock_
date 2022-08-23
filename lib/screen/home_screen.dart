import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late var mp;
  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context) != null) {
      mp = ModalRoute.of(context)?.settings.arguments;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(
            Icons.edit_location,
            size: 20,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/location');
          },
        ),
        // leading: IconButton(
        //   icon: const Icon(Icons.sunny),
        //   onPressed: () {
        //     Provider.of<ThemeProvider>(context, listen: false).changeTheme();
        //   },
        // ),
      ),
      body: //analog(provider),// This trailing comma makes auto-formatting nicer for build methods.
          mp == null
              ? const SpinKitRing(
                  color: Colors.white,
                  size: 50.0,
                )
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(mp['isDay'] == true
                            ? 'assets/day.jpg'
                            : 'assets/night.jpg'),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            mp['location'],
                            style: const TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 10),
                      // Text(mp['flag']),
                      const SizedBox(height: 10),
                      Text(
                        mp['time'],
                        style: const TextStyle(fontSize: 60),
                      ),
                      const SizedBox(height: 40),
                      analog(mp['analog_time'] ?? DateTime.now())
                    ],
                  ),
                ),
    );
  }

  analog(var time) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Center(
        child: AnalogClock(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.height * 0.7, // 150
          datetime: time,
          decoration: BoxDecoration(
              border: Border.all(width: 4.0, color: Colors.yellowAccent),
              color: Colors.transparent,
              shape: BoxShape.circle),
          isLive: true,
          hourHandColor: Colors.red,
          minuteHandColor: Colors.red,
          secondHandColor: Colors.white,
          showSecondHand: true,
          numberColor: Colors.white,
          showNumbers: true,
          textScaleFactor: 1.4,
          showTicks: true,
          showAllNumbers: true,
          showDigitalClock: false,
          //datetime: DateTime.now() //DateTime(2019, 1, 1, 9, 12, 15),
        ),
      ),
    );
  }
}
