import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/global.dart';

const String uri = 'https://sp1-backend.ddns.net';

class User {}

class OTT {
  late String name;

  Future<Service> doAccountLogin(Service service) async {
    late Service result;
    switch (service.name) {
      case 'netflix':
        result =
            await Netflix().accountLogin(service.accountId, service.accountPw);
        break;
      case 'wavve':
        result =
            await Wavve().accountLogin(service.accountId, service.accountPw);
        break;
      default:
        result = service;
        break;
    }

    return result;
  }
}

class Netflix extends OTT {
  Netflix() {
    name = 'netflix';
  }

  Future<Service> accountLogin(String id, String pw) async {
    Service service = Service.account(name, id, pw);
    service.changeStatus(0);
    final response = await http.post(
      Uri.parse('https://sp1-backend.ddns.net/$name/account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': id,
        'ott_pw': pw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> user = jsonDecode(response.body);
      Map<String, dynamic> payment = user['payment'];
      Map<String, dynamic> membership = user['membership'];
      service = Service(
          name,
          user['id'],
          user['pw'],
          payment['type'],
          payment['detail'],
          payment['next'],
          membership['type'],
          membership['cost']);
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: https://sp1-backend.ddns.net/$name/account');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }

  Future<Service> accountRefresh(Service service) async {
    service.changeStatus(0);

    final response = await http.put(
      Uri.parse('https://sp1-backend.ddns.net/$name/account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': service.accountId,
        'ott_pw': service.accountPw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> user = jsonDecode(response.body);
      Map<String, dynamic> payment = user['payment'];
      Map<String, dynamic> membership = user['membership'];
      service = Service(
          name,
          user['id'],
          user['pw'],
          payment['type'],
          payment['detail'],
          payment['next'],
          membership['type'],
          membership['cost']);
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: https://sp1-backend.ddns.net/$name/account');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }
}

class Wavve extends OTT {
  Wavve() {
    name = 'wavve';
  }

  Future<Service> accountLogin(String id, String pw) async {
    Service service = Service.account(name, id, pw);
    service.changeStatus(0);
    final response = await http.post(
      Uri.parse('https://sp1-backend.ddns.net/$name'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': id,
        'ott_pw': pw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      Map<String, dynamic> user = jsonDecode(response.body);
      Map<String, dynamic> payment = user['payment'];
      Map<String, dynamic> membership = user['membership'];
      service = Service(
          name,
          user['id'],
          user['pw'],
          payment['type'],
          payment['detail'],
          payment['next'],
          membership['type'],
          membership['cost']);
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: https://sp1-backend.ddns.net/$name');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }
}
