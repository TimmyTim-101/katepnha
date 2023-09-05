import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/DTO/character_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void initial() {
    // 尝试获取配置
    loadGlobalVarsFromFile();
    setGlobalVarsJsonString(tmp);
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

class Navigation extends StatelessWidget {
  const Navigation({super.key});

  @override
  Widget build(BuildContext context) {
    return getNavigationSubScreen(1, context);
  }
}

class Contents extends StatelessWidget {
  const Contents({super.key});

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
    final List<Widget> recentBirthdayCharacterList = [];
    final DateTime now = DateTime.now();
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
          recentBirthdayCharacterList.add(
            Container(
              height: 153,
              width: 100,
              margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                  color: Colors.white,
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
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: Material(
        color: backColor(),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 300, child: Image.asset('images/KatepиHa_logo.png')),
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
            Container(
              margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
              height: 40,
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    color: unLackColor(),
                    width: 150,
                    child: MaterialButton(
                      onPressed: _downloadConfig,
                      child: customText('下载数据'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    color: unLackColor(),
                    width: 150,
                    child: MaterialButton(
                      onPressed: _uploadConfig,
                      child: customText('上传数据'),
                    ),
                  ),
                ],
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
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-09-05：添加菲米尼相关信息，调整部分ID。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-09-02：添加规划页树脂刷新时间。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-09-01：修复树脂计时器逻辑，修复规划页预计总共消耗未包含当天不能进入秘境数据。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-23：修复规划页显示信息不完整的问题，重新梳理规划材料推荐逻辑，修复若干bug。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-21：修复规划页面树脂显示延迟等问题。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-20：修复角色多莉星级显示错误的问题，修复版本更新后配置文件不通用的问题。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-19：新增数据持久化，修复材料展示顺序问题。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-18：适配4.0数据，修复若干bug。', Colors.white, 15),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: customText('23-08-14：V1.0.0', Colors.white, 15),
                  ),
                ],
              ),
            ),
            customDivider(),
          ],
        ),
      ),
    );
  }

  void _downloadConfig() {
    saveGlobalVarsToFile();
  }

  void _uploadConfig() {
    loadGlobalVarsFromFile();
  }
}
