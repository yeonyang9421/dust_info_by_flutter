import 'package:dust_info_by_flutter/models/AirResult.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rxdart/rxdart.dart';


class AirBloc{
  final _airSubject=BehaviorSubject<AirResult>();

  AirBloc(){
    fetch();
  }

  Future<AirResult> fetchData() async {
    var response = await http
        .get('https://api.airvisual.com/v2/nearest_city?key=4Mn5Fqqsh4bfJoaBg');

    AirResult result = AirResult.fromJson(json.decode(response.body));
    return result;
  }


   void fetch() async{
     var airResult = await fetchData();
     _airSubject.add(airResult);
   }
   Stream<AirResult> get airResult=> _airSubject.stream;


}