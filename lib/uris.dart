import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/global.dart';

const String uri = 'https://sp1-backend.ddns.net';

class Users {
  Future<User> userLogin(String id, String pw) async {
    User user = User('', '', '');

    final response = await http.post(
      Uri.parse('$uri/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': id,
        'app_pw': pw,
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> table = jsonDecode(response.body);
      user = User(
        table['app_id'],
        table['app_pw'],
        '',
      );
    } else {
      debugPrint("fail... else");
    }

    debugPrint('Url: $uri/login');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return user;
  }

  Future<User> userAdd(User data) async {
    User user = User('', '', '');

    final response = await http.post(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': data.id,
        'app_pw': data.pw,
        'app_email': data.email,
      }),
    );

    if (response.statusCode == 201) {
      debugPrint("success 201");
      debugPrint(response.bodyBytes.toString());
      debugPrint(response.body);
    } else {
      debugPrint("fail... else");
    }

    debugPrint('Url: $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return user;
  }

  void userDelete(String id, String pw) async {
    final response = await http.delete(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': id,
        'app_pw': pw,
      }),
    );
    debugPrint('Url: $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }

  void userEdit(User user) async {
    final response = await http.put(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': user.id,
        'app_pw': user.pw,
        'app_email': user.email,
      }),
    );
    debugPrint('Url: $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }
}

class Groups {
  Future<Group> groupSearch(String groupId) async {
    Group group = Group.init();
    final response = await http.get(
      Uri.parse('$uri/group/$groupId'),
      //headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.bodyBytes}');
      debugPrint(response.bodyBytes.toString());
      debugPrint(jsonDecode(utf8.decode(response.bodyBytes)));
      //Map<String, dynamic> table = jsonDecode(response.body);
      /*
      group = Group(
        table['group_id'],
        table['ott'],
        table['account'],
        table['members'],
      );
      */
    } else {
      debugPrint("fail... else");
    }
    debugPrint('Url: $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');

    return group;
  }

  Future<String> groupMake(
      String appId, String ott, String ottId, String ottPw) async {
    String groupId = '';
    final response = await http.post(
      Uri.parse('$uri/group'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': appId,
        'ott': ott,
        'ott_id': ottId,
        'ott_pw': ottPw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> table = jsonDecode(response.body);
      groupId = table['group_id'];
    } else {
      debugPrint("fail... else");
    }
    debugPrint('Url: $uri/group');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return groupId;
  }

  Future<Group> groupDelete(String groupId, String appId) async {
    Group group = Group.init();
    final response = await http.delete(
      Uri.parse('$uri/group/$groupId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': appId,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> table = jsonDecode(response.body);
      group = Group(
        table['group_id'],
        table['ott'],
        table['account'],
        table['members'],
      );
    } else {
      debugPrint("fail... else");
    }

    debugPrint('Url: $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return group;
  }

  Future<Group> groupUpdate(String groupId, Service service) async {
    Group group = Group.init();
    final response = await http.put(
      Uri.parse('$uri/group/$groupId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, dynamic>{
        'ott_pw': service.account.pw,
        'payment': {
          'type': service.payment.type,
          'detail': service.payment.detail,
          'next': service.payment.next,
        },
        'membership': {
          'type': service.membership.type,
          'cost': service.membership.cost,
        }
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> table = jsonDecode(response.body);
      group = Group(
        table['group_id'],
        table['ott'],
        table['account'],
        table['members'],
      );
    } else {
      debugPrint("fail... else");
    }

    debugPrint('Url: $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return group;
  }
}

class OTT {
  late String name;

  Future<Service> doAccountLogin(Service service) async {
    late Service result;
    switch (service.name) {
      case 'netflix':
        result = await Netflix()
            .accountLogin(service.account.id, service.account.pw);
        break;
      case 'wavve':
        result =
            await Wavve().accountLogin(service.account.id, service.account.pw);
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
    Service service = Service.account(name, Account(id, pw));
    service.changeStatus(0);
    final response = await http.post(
      Uri.parse('$uri/$name/account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': id,
        'ott_pw': pw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type'], payment['detail'], payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: $uri/$name/account');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }

  Future<Service> accountRefresh(Service service) async {
    service.changeStatus(0);

    final response = await http.put(
      Uri.parse('$uri/$name/account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': service.account.id,
        'ott_pw': service.account.pw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type'], payment['detail'], payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: $uri/$name/account');
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
    Service service = Service.account(name, Account(id, pw));
    service.changeStatus(0);
    final response = await http.post(
      Uri.parse('$uri/$name/account'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'ott_id': id,
        'ott_pw': pw,
      }),
    );
    if (response.statusCode == 200) {
      debugPrint("success 200");
      debugPrint('Response body: ${response.body}');
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type'], payment['detail'], payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    } else {
      debugPrint("fail... else");
    }
    service.changeStatus(response.statusCode);
    debugPrint('Url: $uri/$name');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }
}
