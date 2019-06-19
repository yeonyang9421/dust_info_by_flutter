import 'package:dust_info_by_flutter/bloc/AirBloc.dart';
import 'package:dust_info_by_flutter/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<AirResult>(
            stream: airBloc.airResult,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildBody(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget buildBody(AirResult result) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 60,
          ),
          Text(
            '현재 위치 미세먼지',
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(
            width: 16,
          ),
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: _getColor(result),
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text('얼굴사진'),
                      result == null
                          ? Text('측정중')
                          : Text(
                              '${result.data.current.pollution.aqius}',
                              style: TextStyle(fontSize: 40),
                            ),
                      Text(
                        getString(result),
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Image.network(
                            'https://airvisual.com/images/${result.data.current.weather.ic}.png',
                            width: 32,
                            height: 32,
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            '${result.data.current.weather.tp}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Text('습도 ${result.data.current.weather.hu}%'),
                      Text('풍속 ${result.data.current.weather.ws}m/s'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: RaisedButton(
              padding:
                  const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50),
              color: Colors.orange,
              child: Icon(Icons.refresh, color: Colors.white),
              onPressed: () {
                airBloc.fetch();
              },
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: _getBackgroundImage(result),
        ),
      ),
    );
  }

  AssetImage _getBackgroundImage(AirResult result) {
    if (result.data.current.pollution.aqius <= 20) {
      return AssetImage('images/good.jpg');
    } else if (result.data.current.pollution.aqius <= 50) {
      return AssetImage('images/normal.jpg');
    } else if (result.data.current.pollution.aqius <= 100) {
      return AssetImage('images/bad.jpg');
    } else {
      return AssetImage('images/verybad.jpg');
    }
  }

  String getString(AirResult result) {
    if (result.data.current.pollution.aqius <= 20) {
      return '좋음';
    } else if (result.data.current.pollution.aqius <= 50) {
      return '보통';
    } else if (result.data.current.pollution.aqius <= 100) {
      return '나쁨';
    } else if (result.data.current.pollution.aqius <= 150) {
      return '매우 나쁨';
    } else {
      return '위험';
    }
  }

  _getColor(AirResult result) {
    if (result.data.current.pollution.aqius <= 20) {
      return Colors.blue;
    } else if (result.data.current.pollution.aqius <= 50) {
      return Colors.greenAccent;
    } else if (result.data.current.pollution.aqius <= 100) {
      return Colors.yellow;
    } else if (result.data.current.pollution.aqius <= 150) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
