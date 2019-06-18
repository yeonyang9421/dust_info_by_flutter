// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:dust_info_by_flutter/models/AirResult.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dust_info_by_flutter/main.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

void main() {
  test('http 통신 테스트', () async{
    var response = await http.get('https://api.airvisual.com/v2/nearest_city?key=4Mn5Fqqsh4bfJoaBg');

    expect(response.statusCode,200);

    AirResult result= AirResult.fromJson(json.decode(response.body));
    expect(result.status, 'success');

  });
}
