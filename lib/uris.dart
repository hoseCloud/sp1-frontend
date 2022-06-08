import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutterapp/global.dart';

const String uri = 'https://sp1-backend.ddns.net';

class Users {
  Future<User> userLogin(String id, String pw) async {
    User user = User.init();

    final response = await http.post(
      Uri.parse('$uri/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': id,
        'app_pw': pw,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> table = jsonDecode(response.body);
      if(table['groups'] == null) {
        user = User(
          table['app_id'],
          table['app_pw'],
          '',
          [],
        );
      }
      else {
        List<Group> group = [];
        List<dynamic> groups = table['groups'];

        for(int i = 0; i < groups.length; i++) {
          Map<String, dynamic> table = groups[i];
          Map<String, dynamic> account = table['account'];
          Map<String, dynamic> payment = account['payment'];
          Map<String, dynamic> membership = account['membership'];

          List<Member> member = [];
          if(table['members'] != null) {
            List<dynamic> members = table['members'];

            for(int j = 0; j < members.length; j++) {
              Map<String, dynamic> table = members[j];
              member.add(Member(table['app_id'], table['is_admin']));
            }
          }

          group.add(
            Group(
              table['group_id'],
              Service(
                table['ott'],
                Account(
                  account['id'],
                  account['pw'],
                ),
                Payment(
                  payment['type'],
                  payment['detail'] ?? '',
                  payment['next'],
                ),
                Membership(
                  membership['type'],
                  membership['cost'],
                )
              ),
              table['update_time'],
              member,
            ));
        }
        user = User(
          table['app_id'],
          table['app_pw'],
          '',
          group,
        );
      }
    }

    debugPrint('URI: POST $uri/login');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return user;
  }

  Future<User> userAdd(User data) async {
    User user = User.init();

    final response = await http.post(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': data.id,
        'app_pw': data.pw,
        'app_email': data.email,
      }),
    );

    debugPrint('URL: POST $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return user;
  }

  Future<void> userDelete(String id, String pw) async {
    final response = await http.delete(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': id,
        'app_pw': pw,
      }),
    );

    debugPrint('URL: DELETE $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }

  Future<void> userEdit(User user) async {
    final response = await http.put(
      Uri.parse('$uri/user'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': user.id,
        'app_pw': user.pw,
        'app_email': user.email,
      }),
    );

    debugPrint('URL: PUT $uri/user');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }
}

class Groups {
  Future<Group> groupSearch(String groupId) async {
    Group group = Group.init();
    List<Member> member = [];

    final response = await http.get(
      Uri.parse('$uri/group/$groupId'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> table = jsonDecode(response.body);

      if(table['members'] != null) {
        List<dynamic> members = table['members'];

        for(int i = 0; i < members.length; i++) {
          Map<String, dynamic> table = members[i];
          member.add(Member(table['app_id'], table['is_admin']));
        }

        Map<String, dynamic> account = table['account'];
        Map<String, dynamic> payment = account['payment'];
        Map<String, dynamic> membership = account['membership'];

        group = Group(
            table['group_id'],
            Service(
              table['ott'],
              Account(
                account['id'],
                account['pw'],
              ),
              Payment(
                payment['type'],
                payment['detail'] ?? '',
                payment['next'],
              ),
              Membership(
                membership['type'],
                membership['cost'],
              )
            ),
            table['update_time'],
            member,
          );
      }
    }

    debugPrint('URL: GET $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

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
      Map<String, dynamic> table = jsonDecode(response.body);
      groupId = table['group_id'];
    }

    debugPrint('URL: POST $uri/group');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return groupId;
  }

  Future<void> groupDelete(String groupId, String appId) async {
    final response = await http.delete(
      Uri.parse('$uri/group/$groupId'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        'app_id': appId,
      }),
    );

    debugPrint('URL: DELETE $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
  }

  Future<void> groupUpdate(String groupId, Service service) async {
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

    debugPrint('URL: PUT $uri/group/$groupId');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
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

  Future<Service> doAccountRefresh(Service service) async {
    late Service result;
    switch (service.name) {
      case 'netflix':
        result = await Netflix().accountRefresh(service);
        break;
      case 'wavve':
        result = await Wavve().accountRefresh(service);
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
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type'], payment['detail'], payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    }
    service.changeStatus(response.statusCode);

    debugPrint('URL: POST $uri/$name/account');
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
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type'], payment['detail'], payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    }
    service.changeStatus(response.statusCode);

    debugPrint('URL: PUT $uri/$name/account');
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
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type']??'', payment['detail']??'', payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    }
    service.changeStatus(response.statusCode);

    debugPrint('URL: POST $uri/$name/account');
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
      Map<String, dynamic> account = jsonDecode(response.body);
      Map<String, dynamic> payment = account['payment'];
      Map<String, dynamic> membership = account['membership'];
      service = Service(
        name,
        Account(account['id'], account['pw']),
        Payment(payment['type']??'', payment['detail']??'', payment['next']),
        Membership(membership['type'], membership['cost']),
      );
    }
    service.changeStatus(response.statusCode);

    debugPrint('URL: PUT $uri/$name/account');
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');

    return service;
  }
}
