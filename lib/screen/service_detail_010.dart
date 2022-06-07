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

  ListTile member(int i) {
    if(data.members[i].isAdmin == 1) {
      return ListTile(
        title: Text(
          data.members[i].appId,
          textScaleFactor: 2.0,
        ),
        leading: const Icon(Icons.star, color: Colors.blue,),
      );
    }
    else {
      return ListTile(
        title: Text(
          data.members[i].appId,
          textScaleFactor: 2.0,
        ),
        leading: const Icon(Icons.person),
      );
    }
  }

  void refresh(BuildContext context) async {
    Navigator.pop(context);
    debugPrint('Refresh tapped!');
    GroupModel pro = Provider.of<GroupModel>(context, listen: false);
    data.ott.changeStatus(0);
    pro.update(data);
    Service service = await Netflix().accountRefresh(data.ott);
    data.ott = service;
    await Groups().groupUpdate(data.groupId, data.ott);
    pro.update(data);
  }

  void delete(BuildContext context) async {
    GroupModel pro =
        Provider.of<GroupModel>(context, listen: false);
    pro.remove(data);
    Navigator.pop(context);
    debugPrint('Delete tapped!');
  }

  @override
  Widget build(BuildContext context) {
    // var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            const Text(
              '공유중인 계정',
              textAlign: TextAlign.center,
              textScaleFactor: 3.0,
            ),
            for(int i = 0; i < data.members.length; i++)
              member(i),
          ],
        ),
      ),
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: ListView(
        children: [
          Image.asset('assets/images/${data.ott.name}_banner.png'),
          Text(
            '\n'
            'ID: ${data.ott.account.id}\n'
            'PW: ${data.ott.account.pw}\n',
            textScaleFactor: 2.0,
          ),
          Text(
            '결제수단: ${data.ott.payment.type}\n'
            '결제정보: ${data.ott.payment.detail}\n'
            '결제예정: ${DateTime.fromMillisecondsSinceEpoch(data.ott.payment.next * 1000)}\n\n'
            '맴버쉽 종류: ${data.ott.membership.type}\n'
            '맴버쉽 가격: ${data.ott.membership.cost}\n'
            '마지막 동기화: ${DateTime.fromMillisecondsSinceEpoch(data.updateTime * 1000)}\n',
            textScaleFactor: 1.5,
          ),
          Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                Container(
                  width: screenWidth * 0.05,
                ),
                SizedBox(
                  width: screenWidth * 0.4,
                  child: ElevatedButton(
                    child: const Text(
                      'Refresh',
                      textScaleFactor: 2.0,
                    ),
                    onPressed: () async {
                      refresh(context);
                    },
                  ),
                ),
                Container(
                  width: screenWidth * 0.1,
                ),
                SizedBox(
                  width: screenWidth * 0.4,
                  child: ElevatedButton(
                    child: const Text(
                      'Delete',
                      textScaleFactor: 2.0,
                    ),
                    onPressed: () async {
                      delete(context);
                    },
                  ),
                ),
                Container(
                  width: screenWidth * 0.05,
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}
