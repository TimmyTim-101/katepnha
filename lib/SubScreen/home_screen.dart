import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/DTO/character_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

import '../Utils/date_util.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void initial() {
    // 尝试获取配置
    loadGlobalVarsFromFile();
    saveGlobalVarsToFile();
    loadGlobalVarsFromFile();
    // 初始化合并关系map
    for (final element in allGroup) {
      final List<ItemDTO> thisGroupList = element.groupList;
      for (int i = 0; i < thisGroupList.length - 1; i++) {
        final ItemDTO littleItem = thisGroupList[i];
        final ItemDTO bigItem = thisGroupList[i + 1];
        if (!mergeMap.containsKey(bigItem)) {
          mergeMap[bigItem] = littleItem;
          reverseMergeMap[littleItem] = bigItem;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initial();
    return const Scaffold(
      body: Row(
        children: [Navigation(), Contents()],
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<StatefulWidget> createState() => _NavigationState();
}

// todo:账号改变不能实时更新
class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return getNavigationSubScreen(1, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  String nameTextFieldTmp = '';

  void initial() {
    if (birthdayCharacterMap.length != allCharacter.length) {
      for (final c in allCharacter) {
        c as CharacterDTO;
        final int thisBirthday = c.birthday;
        if (!birthdayCharacterMap.containsKey(thisBirthday)) {
          birthdayCharacterMap[thisBirthday] = {};
        }
        birthdayCharacterMap[thisBirthday]!.add(c);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    initial();
    // 获取生日信息
    final List<Widget> recentBirthdayCharacterList = [];
    final DateTime now = getNowDateTime();
    final int nowMonth = now.month;
    final int nowDay = now.day;
    final int nowMonthDay = nowMonth * 100 + nowDay;
    for (int i = nowMonthDay;; i++) {
      if (i > 1231) {
        i = i - 1231;
      }
      if (recentBirthdayCharacterList.length > 8) {
        break;
      }
      if (birthdayCharacterMap.containsKey(i)) {
        for (final c in birthdayCharacterMap[i]!) {
          c as CharacterDTO;
          Color colorOfBoarding = Colors.white;
          if(nowMonthDay == c.birthday){
            colorOfBoarding = Colors.yellowAccent;
          }
          recentBirthdayCharacterList.add(
            Container(
              height: 159,
              width: 100,
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: colorOfBoarding,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Positioned(
                          child: Image(
                            image: AssetImage(backgroundMap[c.star]!),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Positioned(
                          child: Image(
                            image: AssetImage(c.imageAddress),
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Positioned(
                          child: Image(
                            image: AssetImage(elementPictureAddress[c.elementType]!),
                            height: 25,
                            width: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 15,
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage(starMap[c.star]!),
                    ),
                  ),
                  Container(
                    child: customText(c.name, Colors.white, 15),
                  ),
                  Container(
                    child: customText('${(c.birthday / 100).floor()}/${c.birthday % 100}', Colors.white, 15),
                  ),
                ],
              ),
            ),
          );
        }
      }
    }
    // 获取账号信息
    final List<Widget> allAccountsWidgetList = [];
    for (final String acc in allAccounts) {
      final Widget thisContainer = Material(
        color: frontColor(),
        borderRadius: BorderRadius.circular(5),
        child: Container(
          width: 646,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                width: 150,
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                alignment: Alignment.centerRight,
                child: customText(acc, Colors.white, 15),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: MaterialButton(
                  onPressed: () => _changeAccount(acc),
                  color: unLackColor(),
                  child: customText('切换', Colors.white, 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: MaterialButton(
                  onPressed: () => _deleteAccount(acc),
                  color: unLackColor(),
                  child: customText('删除', Colors.white, 15),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: MaterialButton(
                  onPressed: () => _renameAccount(acc),
                  color: unLackColor(),
                  child: customText('重命名', Colors.white, 15),
                ),
              ),
              SizedBox(
                width: 200,
                child: TextField(
                  textAlign: TextAlign.left,
                  onChanged: (value) => _update(value),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      allAccountsWidgetList.add(thisContainer);
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: Material(
        color: backColor(),
        child: ListView(
          children: <Widget>[
            customDivider(),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(height: 200, child: Image.asset('images/KatepиHa_logo.png')),
                  Container(
                    margin: const EdgeInsets.all(20),
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: frontColor(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(margin: const EdgeInsets.all(8), child: customText('向着星辰与深渊～我不是凯瑟琳，我是KatepиHa，一个原神养成小助手。')),
                          Container(margin: const EdgeInsets.all(8), child: customText('不知道该干点啥？有一堆角色武器要养？材料我该合成多少打多少？要多久才能攒够材料？KatepиHa帮您忙！')),
                          Container(margin: const EdgeInsets.all(8), child: customText('在这里，把你的要养的角色武器还有背包里的东西都告诉凯瑟琳，KatepиHa就会自动帮你计算出所缺材料数量，还可以给出养成顺序。')),
                          Container(margin: const EdgeInsets.all(8), child: customText('有了KatepиHa，你可有事干了！')),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            customDivider(),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: customText('当前服务器时间：${standardTimeString(getNowDateTime())}'),
            ),
            customDivider(),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      textAlign: TextAlign.left,
                      onChanged: (value) => _update(value),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FloatingActionButton.small(
                    onPressed: _addAccount,
                    backgroundColor: unLackColor(),
                    foregroundColor: Colors.white,
                    child: const Icon(
                      Icons.add,
                      size: 20,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: customText('当前账号：', Colors.deepOrangeAccent),
                  ),
                  Container(
                    child: customText(currentAccount),
                  ),
                ],
              ),
            ),
            Container(
              width: 400,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(30, 8, 0, 0),
              child: Column(
                children: allAccountsWidgetList,
              ),
            ),
            customDivider(),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: customText('生日'),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 5),
              child: Wrap(
                children: recentBirthdayCharacterList,
              ),
            ),
            customDivider(),
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    alignment: Alignment.centerLeft,
                    child: customText('更新日志'),
                  ),
                  updateContainer('25-12-03：适配6.2数据。'),
                  updateContainer('25-11-23：修复“事件”页材料数量改变时不更新的问题。'),
                  updateContainer('25-10-25：适配6.1数据。'),
                  updateContainer('25-09-10：适配6.0数据。'),
                  updateContainer('25-08-08：适配5.8数据。'),
                  updateContainer('25-06-21：适配5.7数据。'),
                  updateContainer('25-05-10：适配5.6数据。'),
                  updateContainer('25-03-26：适配5.5数据。'),
                  updateContainer('25-02-25：适配5.4数据。'),
                  updateContainer('25-02-10：修复部分材料显示不正确的问题。'),
                  updateContainer('25-01-01：适配5.3数据。'),
                  updateContainer('24-12-07：修复时间判断逻辑，针对不在服务器时区的使用者进行时间计算逻辑优化。'),
                  updateContainer('24-11-28：修复5.2新增材料计算不正确的问题。'),
                  updateContainer('24-11-20：适配5.2数据。'),
                  updateContainer('24-10-09：适配5.1数据，调整背包页材料展示顺序。'),
                  updateContainer('24-08-28：适配5.0数据，调整部分布局。'),
                  updateContainer('24-07-30：修复新增事件时判定能否完成的错误问题。'),
                  updateContainer('24-07-29：适配4.8数据，调整部分布局。'),
                  updateContainer('24-06-21：调整背包内材料展示顺序，针对周本BOSS给出考虑转化情况的推荐顺序，调整部分ID。'),
                  updateContainer('24-06-05：适配4.7数据。'),
                  updateContainer('24-04-25：适配4.6数据，调整部分布局。'),
                  updateContainer('24-03-13：适配4.5数据，调整部分布局。'),
                  updateContainer('24-02-20：修复部分副本显示重复和遗漏的问题。'),
                  updateContainer('24-01-31：适配4.4数据，调整部分布局。'),
                  updateContainer('23-12-21：适配4.3数据，修复部分数据展示错误。'),
                  updateContainer('23-11-08：适配4.2数据。'),
                  updateContainer('23-10-29：修复特殊情况下账号无法切换的问题。'),
                  updateContainer('23-10-24：修复数据可能被清除的问题。'),
                  updateContainer('23-10-24：新增多账号功能。'),
                  updateContainer('23-10-21：适配4.1数据，修复bug若干。'),
                  updateContainer('23-10-09：修复部分信息显示错误问题。'),
                  updateContainer('23-09-13：修复武器页不生效的问题。'),
                  updateContainer('23-09-06：修复规划页时间分钟为60的问题。'),
                  updateContainer('23-09-05：添加菲米尼相关信息，调整部分ID。'),
                  updateContainer('23-09-02：添加规划页树脂刷新时间。'),
                  updateContainer('23-09-01：修复树脂计时器逻辑，修复规划页预计总共消耗未包含当天不能进入秘境数据。'),
                  updateContainer('23-08-23：修复规划页显示信息不完整的问题，重新梳理规划材料推荐逻辑，修复若干bug。'),
                  updateContainer('23-08-21：修复规划页面树脂显示延迟等问题。'),
                  updateContainer('23-08-20：修复角色多莉星级显示错误的问题，修复版本更新后配置文件不通用的问题。'),
                  updateContainer('23-08-19：新增数据持久化，修复材料展示顺序问题。'),
                  updateContainer('23-08-18：适配4.0数据，修复若干bug。'),
                  updateContainer('23-08-14：V1.0.0'),
                ],
              ),
            ),
            customDivider(),
          ],
        ),
      ),
    );
  }

  Widget updateContainer(String info) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 5),
      alignment: Alignment.centerLeft,
      child: customText(info, Colors.white, 15),
    );
  }

  void _addAccount() {
    setState(() {
      if (!allAccounts.contains(nameTextFieldTmp)) {
        saveGlobalVarsToFile();
        allAccounts.add(nameTextFieldTmp);
        currentAccount = nameTextFieldTmp;
        allConfig[nameTextFieldTmp] = {};
        resetData();
        saveGlobalVarsToFile();
        loadGlobalVarsFromFile();
      }
    });
  }

  void _changeAccount(String acc) {
    setState(() {
      saveGlobalVarsToFile();
      currentAccount = acc;
      final Map<String, dynamic> m = allConfig[acc];
      readMapConfigToInnerDataStructure(m);
      saveGlobalVarsToFile();
    });
  }

  void _deleteAccount(String acc) {
    setState(() {
      saveGlobalVarsToFile();
      if (allAccounts.length >= 2) {
        allAccounts.remove(acc);
        currentAccount = allAccounts[0];
        allConfig.remove(acc);
        final m = allConfig[currentAccount];
        readMapConfigToInnerDataStructure(m);
      }
      saveGlobalVarsToFile();
    });
  }

  void _renameAccount(String acc) {
    setState(() {
      saveGlobalVarsToFile();
      if (!allAccounts.contains(nameTextFieldTmp)) {
        int index = 0;
        for (int i = 0; i < allAccounts.length; i++) {
          if (allAccounts[i] == acc) {
            index = i;
          }
        }
        allAccounts[index] = nameTextFieldTmp;
        currentAccount = nameTextFieldTmp;
        allConfig[nameTextFieldTmp] = allConfig[acc];
        allConfig.remove(acc);
        saveGlobalVarsToFile();
      }
    });
  }

  void _update(String s) {
    setState(() {
      nameTextFieldTmp = s;
    });
  }
}
