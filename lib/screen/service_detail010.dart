import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/stats.dart';
import 'package:flutterapp/global.dart';
import 'package:flutterapp/uris.dart';

// #010 ScreenServiceDetail
class ScreenServiceDetail extends StatelessWidget {
  const ScreenServiceDetail({Key? key, required this.data}) : super(key: key);
  final Group data;

  String sharing(List<Member> member) {
    String result = '';

    for(int i = 0; i < member.length; i++) {
      result += member[i].isAdmin == 1 ? 'O' : 'X';
      result += ' ';
      result += member[i].appId;
      result += '\n';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Text(
            'GID: ${data.groupId}\n'
            '서비스: ${data.ott.name}\n'
            '계정 ID: ${data.ott.account.id}\n'
            '계정 PW: ${data.ott.account.pw}\n'
            '결제수단: ${data.ott.payment.type}\n'
            '결제정보: ${data.ott.payment.detail}\n'
            '결제예정: ${DateTime.fromMillisecondsSinceEpoch(data.ott.payment.next * 1000)}\n'
            '맴버쉽 종류: ${data.ott.membership.type}\n'
            '맴버쉽 가격: ${data.ott.membership.cost}\n'
            '마지막 동기화: ${DateTime.fromMillisecondsSinceEpoch(data.updateTime * 1000)}\n'
            '계정 상태: ${data.ott.status}\n',
            textScaleFactor: 1.5,
            textAlign: TextAlign.left,
          ),
          Text(
            '공유중인 유저\n'
            '${sharing(data.members)}\n',
            textScaleFactor: 1.5,
            textAlign: TextAlign.left,
          ),
          ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);
                debugPrint('Refresh tapped!');
                GroupModel pro = Provider.of<GroupModel>(context, listen: false);
                data.ott.changeStatus(0);
                pro.update(data);
                Service service = await Netflix().accountRefresh(data.ott);
                data.ott = service;
                await Groups().groupUpdate(data.groupId, data.ott);
                pro.update(data);
              },
              child: const Center(
                child: Text(
                  'Refresh',
                  textScaleFactor: 2.0,
                ),
              )),
          ElevatedButton(
              onPressed: () {
                GroupModel pro =
                    Provider.of<GroupModel>(context, listen: false);
                pro.remove(data);
                // pro.db.dbDelete(data);
                Navigator.pop(context);
                debugPrint('Delete tapped!');
              },
              child: const Center(
                child: Text(
                  'Delete',
                  textScaleFactor: 2.0,
                ),
              )),
        ],
      ),
    );
  }
}
