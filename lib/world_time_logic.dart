import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class WorldTime {
  String location;
  String flag;
  late String time;
  DateTime analogTime=DateTime.now();
  late bool isDay;
  WorldTime(this.location,this.flag);

  getTime() async {
    try {
      var response = await get(
          Uri.parse('http://worldtimeapi.org/api/timezone/$location'));
      var data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'];
      DateTime now = DateTime.parse(datetime);
      print(datetime);
      print(offset);
      print(now);
      if (offset[0] == '+') {
        now = now.add(
          Duration(
            hours: int.parse(offset.substring(1, 3)),
            minutes: int.parse(offset.substring(4)),
          ),
        );
      } else {
        now = now.subtract(
          Duration(
            hours: int.parse(offset.substring(1, 3)),
            minutes: int.parse(offset.substring(4)),
          ),
        );
      }
      initializeDateFormatting();
      time = DateFormat.jm().format(now);
      analogTime=now;
      isDay=now.hour>=6 && now.hour<=18 ? true:false;
    } catch (e) {
      print(e);
      time=e.toString();
    }
  }
}
