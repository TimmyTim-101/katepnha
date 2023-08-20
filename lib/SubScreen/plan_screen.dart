import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/character_dto.dart';
import 'package:katepnha/DTO/dungeon_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';
import 'package:katepnha/DTO/material_dto.dart';
import 'package:katepnha/DTO/weapon_dto.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/Utils/lack_calculate.dart';
import 'package:katepnha/Utils/number_convert.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    return getNavigationSubScreen(6, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  Map<ItemDTO, TextEditingController> allController = {};
  int totalResinNum = 0;
  int totalCondensedNum = 0;
  int totalDayNum = 0;
  int d20Time = 0;
  int d40Time = 0;
  int d60Time = 0;
  int dMaxTime = 0;
  Set<int> todayItemSet = {};

  void initial() {
    // 初始化输入框控制器
    if (allController.length != allMaterial.length) {
      for (final element in allMaterial) {
        if (!allController.containsKey(element)) {
          allController[element] = getController(element);
        }
      }
    }
  }

  TextEditingController getController(ItemDTO item) {
    final TextEditingController r = TextEditingController();
    final String initialText = haveNumMap.containsKey(item) ? haveNumMap[item].toString() : '0';
    r.value = TextEditingValue(
      text: initialText,
      selection: TextSelection.fromPosition(TextPosition(offset: initialText.length)),
    );
    return r;
  }

  @override
  Widget build(BuildContext context) {
    initial();
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: Material(
        color: backColor(),
        child: Row(
          children: [
            taskList(),
            recommendList(),
          ],
        ),
      ),
    );
  }

  Widget taskList() {
    d20Time = 0;
    d40Time = 0;
    d60Time = 0;
    dMaxTime = 0;
    todayItemSet = {};
    final Map<int, List<DungeonDTO>> costDungeonListMap = {0: [], 20: [], 40: [], 60: []};
    for (final d in allDungeon) {
      bool isNeed = false;
      for (final ip in d.dropItemMap) {
        final ItemDTO thisItem = ip.itemId;
        final int thisLack = mergeLack(thisItem);
        if (thisLack > 0) {
          isNeed = true;
          todayItemSet.add(thisItem.id);
        }
      }
      if (isNeed) {
        final DateTime now = DateTime.now();
        int weekday = now.weekday;
        final int hour = now.hour;
        if (hour < 4) {
          weekday = weekday - 1;
          if (weekday == 0) {
            weekday = 7;
          }
        }
        if (d.time.contains(weekday)) {
          final int thisCost = d.cost;
          costDungeonListMap[thisCost]!.add(d);
        } else {
          for (final ip in d.dropItemMap) {
            final int thisItemId = ip.itemId.id;
            if (todayItemSet.contains(thisItemId)) {
              todayItemSet.remove(thisItemId);
            }
          }
        }
      }
    }
    final Map<ItemDTO, List<ItemDTO>> materialPlanListMap = {};
    for (final p in planList) {
      final List<ItemPairDTO> thisAllMaterial = getMaterialList(p.planType, p.item, p.num);
      for (final ip in thisAllMaterial) {
        final int thisLack = mergeLack(ip.itemId);
        if (thisLack > 0) {
          if (!materialPlanListMap.containsKey(ip.itemId)) {
            materialPlanListMap[ip.itemId] = [];
          }
          if (!materialPlanListMap[ip.itemId]!.contains(p.item)) {
            materialPlanListMap[ip.itemId]!.add(p.item);
          }
        }
      }
    }
    final Map<int, List<ItemDTO>> dungeonPlanListMap = {};
    for (final d in allDungeon) {
      for (final ip in d.dropItemMap) {
        if (materialPlanListMap.containsKey(ip.itemId)) {
          if (!dungeonPlanListMap.containsKey(d.id)) {
            dungeonPlanListMap[d.id] = [];
          }
          for (final i in materialPlanListMap[ip.itemId]!) {
            if (!dungeonPlanListMap[d.id]!.contains(i)) {
              dungeonPlanListMap[d.id]!.add(i);
            }
          }
        }
      }
    }
    final List<Widget> cost00WidgetList = [];
    final List<Widget> cost20WidgetList = [];
    final List<Widget> cost40WidgetList = [];
    final List<Widget> cost60WidgetList = [];
    for (final d in costDungeonListMap[0]!) {
      cost00WidgetList.add(dungeonInfoWidget(d, dungeonPlanListMap));
    }
    for (final d in costDungeonListMap[20]!) {
      cost20WidgetList.add(dungeonInfoWidget(d, dungeonPlanListMap));
    }
    for (final d in costDungeonListMap[40]!) {
      cost40WidgetList.add(dungeonInfoWidget(d, dungeonPlanListMap));
    }
    for (final d in costDungeonListMap[60]!) {
      cost60WidgetList.add(dungeonInfoWidget(d, dungeonPlanListMap));
    }
    final int weekCostDay = dMaxTime * 7;
    final int weekAllResin = dMaxTime * 7 * 180;
    final int weekRemainResin = weekAllResin - d60Time * 60;
    final int otherCostResin = d20Time * 20 + d40Time * 40;
    totalResinNum = d20Time * 20 + d40Time * 40 + d60Time * 60;
    totalDayNum = weekCostDay + (max(0, otherCostResin - weekRemainResin) / 180).ceil();
    return Container(
      width: MediaQuery.of(context).size.width - 620,
      padding: const EdgeInsets.all(5),
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(30, 5, 5, 5),
                child: Row(
                  children: [
                    customText('预计共消耗约$totalResinNum'),
                    const Image(
                      image: AssetImage(resinImageAddress),
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 5, 5, 5),
                child: Row(
                  children: [
                    customText('可合成浓缩树脂约$totalCondensedNum'),
                    const Image(
                      image: AssetImage(condensedResinAddress),
                      width: 20,
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30, 5, 5, 5),
                child: Row(
                  children: [
                    customText('预计完成全部任务需花费$totalDayNum天（不包含粒儿片儿块儿钻儿）'),
                  ],
                ),
              ),
            ],
          ),
          customDivider(),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                customText('不消耗'),
                const Image(
                  image: AssetImage(resinImageAddress),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            child: Wrap(
              children: cost00WidgetList,
            ),
          ),
          customDivider(),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                customText('20'),
                const Image(
                  image: AssetImage(resinImageAddress),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            child: Wrap(
              children: cost20WidgetList,
            ),
          ),
          customDivider(),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                customText('40'),
                const Image(
                  image: AssetImage(resinImageAddress),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            child: Wrap(
              children: cost40WidgetList,
            ),
          ),
          customDivider(),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                customText('60'),
                const Image(
                  image: AssetImage(resinImageAddress),
                  width: 30,
                  height: 30,
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(30, 5, 5, 0),
            child: Wrap(
              children: cost60WidgetList,
            ),
          ),
          customDivider(),
        ],
      ),
    );
  }

  Widget recommendList() {
    final Timer resinTimer = Timer.periodic(Duration(seconds: refreshDuration), (timer) {
      if (resinNum <= 160) {
        final DateTime now = DateTime.now();
        if (now.difference(refreshTime).inSeconds >= plusDuration) {
          refreshTime = refreshTime.add(Duration(seconds: plusDuration));
          resinNum = resinNum + 1;
          _refresh();
        }
      }
    });
    resinTimer.isActive;
    final List<Widget> resinHintList = [];
    for (int i = (resinNum / 20).ceil() * 20 + 20; i <= 160; i += 20) {
      if (i == 0) continue;
      final int remainSeconds = (i - resinNum) * 8 * 60;
      final DateTime finishTime = refreshTime.add(Duration(seconds: remainSeconds));
      final String thisRemainHint = durationConvert(remainSeconds);
      final String thisFinishHint = timeConvert(finishTime);
      final Widget thisHintWidget = SizedBox(
        height: 25,
        width: 480,
        child: Row(
          children: [
            Container(
              width: 100,
              alignment: Alignment.centerRight,
              child: customText(thisRemainHint, Colors.white, 15),
            ),
            Container(
              width: 100,
              alignment: Alignment.center,
              child: customText('（$thisFinishHint）', Colors.white, 15),
            ),
            Container(
              width: 75,
              alignment: Alignment.center,
              child: customText('树脂数达到', Colors.white, 15),
            ),
            Container(
              width: 50,
              alignment: Alignment.center,
              child: customText('$i'),
            ),
          ],
        ),
      );
      resinHintList.add(thisHintWidget);
    }
    final List<Widget> recommendWidgetList = [];
    final Set<int> recommendItemList = {};
    for (final p in planList) {
      for (final pp in getMaterialList(p.planType, p.item, p.num)) {
        final ItemDTO thisItem = pp.itemId;
        final int thisItemId = thisItem.id;
        if (!recommendItemList.contains(thisItemId)) {
          final double thisNum = pp.num;
          final int haveNum = simpleMergeHave(thisItem);
          if (haveNum < thisNum) {
            recommendItemList.add(thisItemId);
            recommendWidgetList.add(
              Container(
                height: 50,
                margin: const EdgeInsets.all(5),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Image(
                              image: AssetImage(backgroundMap[thisItem.star]!),
                              width: 50,
                              height: 50,
                            ),
                          ),
                          Positioned(
                            child: Image(
                              image: AssetImage(thisItem.imageAddress),
                              width: 50,
                              height: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150,
                      alignment: Alignment.center,
                      child: customText(thisItem.name, todayItemSet.contains(thisItemId) ? Colors.white : Colors.white30, 15),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: customText(have(thisItem).toString(), Colors.white, 12),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: customText(simpleMergeHave(thisItem).toString(), Colors.white, 12),
                    ),
                    Container(
                      width: 60,
                      alignment: Alignment.center,
                      child: customText((thisNum - simpleMergeHave(thisItem)).round().toString(), Colors.white, 12),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      }
    }
    return Container(
      width: 420,
      color: frontColor(),
      child: Column(
        children: [
          Container(
            width: 410,
            height: 121.0 + 25 * resinHintList.length,
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        padding: const EdgeInsets.all(10),
                        child: const Image(
                          image: AssetImage(resinImageAddress),
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 50,
                        child: customText(resinNum.toString()),
                      ),
                      Container(
                        width: 50,
                        alignment: Alignment.center,
                        child: customText('/ 160'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: lackColor(),
                          child: customText('-1', Colors.white, 12),
                          onPressed: () => _changeResinNum(-1),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: unLackColor(),
                          child: customText('+1', Colors.white, 12),
                          onPressed: () => _changeResinNum(1),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: lackColor(),
                          child: customText('-20', Colors.white, 12),
                          onPressed: () => _changeResinNum(-20),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: lackColor(),
                          child: customText('-30', Colors.white, 12),
                          onPressed: () => _changeResinNum(-30),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: lackColor(),
                          child: customText('-40', Colors.white, 12),
                          onPressed: () => _changeResinNum(-40),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: lackColor(),
                          child: customText('-60', Colors.white, 12),
                          onPressed: () => _changeResinNum(-60),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                        width: 40,
                        child: MaterialButton(
                          color: unLackColor(),
                          child: customText('+60', Colors.white, 12),
                          onPressed: () => _changeResinNum(60),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.white10,
                    ),
                  ),
                  height: 25.0 * resinHintList.length + 12,
                  child: Column(
                    children: resinHintList,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 410,
            height: 480,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: ListView(
              children: recommendWidgetList,
            ),
          ),
        ],
      ),
    );
  }

  void _changeResinNum(int num) {
    setState(() {
      resinNum = max(0, resinNum + num);
      if (num == 1 || num == -1) {
        refreshTime = DateTime.now();
      }
      saveGlobalVars();
    });
  }

  void _refresh() {
    setState(() {
      saveGlobalVars();
    });
  }

  List<ItemPairDTO> getMaterialList(PlanType planType, ItemDTO item, int num) {
    List<ItemPairDTO> thisMaterialList = [];
    switch (planType) {
      case PlanType.characterLevel:
        thisMaterialList = (item as CharacterDTO).levelUpDTO!.itemMap[num]!;
        break;
      case PlanType.characterTalent1:
        thisMaterialList = (item as CharacterDTO).talentLevelUpDTO!.itemMap1[num]!;
        break;
      case PlanType.characterTalent2:
        thisMaterialList = (item as CharacterDTO).talentLevelUpDTO!.itemMap2[num]!;
        break;
      case PlanType.characterTalent3:
        thisMaterialList = (item as CharacterDTO).talentLevelUpDTO!.itemMap3[num]!;
        break;
      case PlanType.weaponLevel:
        thisMaterialList = (item as WeaponDTO).levelUpDTO!.itemMap[num]!;
      // todo:pickup
      default:
        break;
    }
    return thisMaterialList;
  }

  Widget dungeonInfoWidget(DungeonDTO d, Map<int, List<ItemDTO>> m) {
    final List<Widget> itemWidgetList = [];
    for (final ip in d.dropItemMap) {
      itemWidgetList.add(infoWidget(ip.itemId));
    }
    final int materialRowNum = (d.dropItemMap.length / 4).ceil();
    final List<Widget> planWidgetList = [];
    for (final i in m[d.id]!) {
      planWidgetList.add(
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 9, 9),
          height: 50,
          width: 50,
          child: Tooltip(
            message: i.name,
            child: Stack(
              children: [
                Positioned(
                  child: Image(
                    image: AssetImage(backgroundMap[i.star]!),
                    height: 50,
                    width: 50,
                  ),
                ),
                Positioned(
                  child: Image(
                    image: AssetImage(i.imageAddress),
                    height: 50,
                    width: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final int planRowNum = (planWidgetList.length / 6).ceil();
    int timeNum = 0;
    int resinNum = 0;
    int dayNum = 0;
    if (d.dungeonType == DungeonType.exp) {
      // 经验花
      final int needNum = max(0, need(i_104003) - have(i_104003));
      timeNum = (needNum / (4.5 + 6.5 / 4)).ceil();
      resinNum = timeNum * 20;
      dayNum = (resinNum / 180).ceil();
      d20Time = d20Time + timeNum;
      totalCondensedNum = totalCondensedNum + (timeNum / 2).ceil();
    } else if (d.dungeonType == DungeonType.talent) {
      final int a1 = have(d.dropItemMap[2].itemId);
      final int a2 = have(d.dropItemMap[1].itemId);
      final int a3 = have(d.dropItemMap[0].itemId);
      final int b1 = need(d.dropItemMap[2].itemId);
      final int b2 = need(d.dropItemMap[1].itemId);
      final int b3 = need(d.dropItemMap[0].itemId);
      final double c1 = d.dropItemMap[2].num;
      final double c2 = d.dropItemMap[1].num;
      final double c3 = d.dropItemMap[0].num;
      int solveTime = 0;
      for (int i = 0; i < 9999; i++) {
        bool getSolution = true;
        getSolution = getSolution && (a1 + c1 * solveTime >= b1);
        final int i2 = ((a1 + c1 * solveTime - b1) / 3).floor();
        getSolution = getSolution && (a2 + c2 * solveTime + i2 >= b2);
        final int i3 = ((a2 + c2 * solveTime + i2 - b2) / 3).floor();
        getSolution = getSolution && (a3 + c3 * solveTime + i3 >= b3);
        if (getSolution == true) break;
        solveTime = solveTime + 1;
      }
      timeNum = solveTime;
      resinNum = timeNum * 20;
      dayNum = (resinNum / 180).ceil();
      d20Time = d20Time + timeNum;
      totalCondensedNum = totalCondensedNum + (timeNum / 2).ceil();
    } else if (d.dungeonType == DungeonType.weapon) {
      final int a1 = have(d.dropItemMap[3].itemId);
      final int a2 = have(d.dropItemMap[2].itemId);
      final int a3 = have(d.dropItemMap[1].itemId);
      final int a4 = have(d.dropItemMap[0].itemId);
      final int b1 = need(d.dropItemMap[3].itemId);
      final int b2 = need(d.dropItemMap[2].itemId);
      final int b3 = need(d.dropItemMap[1].itemId);
      final int b4 = need(d.dropItemMap[0].itemId);
      final double c1 = d.dropItemMap[3].num;
      final double c2 = d.dropItemMap[2].num;
      final double c3 = d.dropItemMap[1].num;
      final double c4 = d.dropItemMap[0].num;
      int solveTime = 0;
      for (int i = 0; i < 9999; i++) {
        bool getSolution = true;
        getSolution = getSolution && (a1 + c1 * solveTime >= b1);
        final int i2 = ((a1 + c1 * solveTime - b1) / 3).floor();
        getSolution = getSolution && (a2 + c2 * solveTime + i2 >= b2);
        final int i3 = ((a2 + c2 * solveTime + i2 - b2) / 3).floor();
        getSolution = getSolution && (a3 + c3 * solveTime + i3 >= b3);
        final int i4 = ((a3 + c3 * solveTime + i3 - b3) / 3).floor();
        getSolution = getSolution && (a4 + c4 * solveTime + i4 >= b4);
        if (getSolution == true) break;
        solveTime = solveTime + 1;
      }
      timeNum = solveTime;
      resinNum = timeNum * 20;
      dayNum = (resinNum / 180).ceil();
      d20Time = d20Time + timeNum;
      totalCondensedNum = totalCondensedNum + (timeNum / 2).ceil();
    } else if (d.dungeonType == DungeonType.boss || d.dungeonType == DungeonType.mora) {
      for (final ip in d.dropItemMap) {
        if (((ip.itemId) as MaterialDTO).materialType == GMaterialType.cc) {
          continue;
        }
        final int thisTimeNum = (max(0, need(ip.itemId) - have(ip.itemId)) / ip.num).ceil();
        timeNum = max(timeNum, thisTimeNum);
      }
      resinNum = timeNum * d.cost;
      dayNum = (resinNum / 180).ceil();
      if (d.cost == 20) {
        d20Time = d20Time + timeNum;
        totalCondensedNum = totalCondensedNum + (timeNum / 2).ceil();
      } else {
        d40Time = d40Time + timeNum;
      }
    } else if (d.dungeonType == DungeonType.week) {
      for (final ip in d.dropItemMap) {
        if (((ip.itemId) as MaterialDTO).materialType == GMaterialType.cc) {
          continue;
        }
        final int thisTimeNum = (max(0, need(ip.itemId) - have(ip.itemId)) / ip.num).ceil();
        timeNum = max(timeNum, thisTimeNum);
      }
      resinNum = timeNum * d.cost;
      dayNum = timeNum * 7;
      d60Time = d60Time + timeNum;
      dMaxTime = max(dMaxTime, timeNum);
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
      width: 367,
      height: 215 * materialRowNum + 59 * planRowNum + 59,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 25,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: customText(d.name),
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: customText(d.subName, Colors.white, 15),
          ),
          Container(
            height: 20,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    customText('x$timeNum', Colors.white, 15),
                  ],
                ),
                Row(
                  children: [
                    customText('$resinNum', Colors.white, 15),
                    const Image(
                      image: AssetImage(resinImageAddress),
                      width: 15,
                      height: 15,
                    ),
                  ],
                ),
                Row(
                  children: [
                    customText('约$dayNum天', Colors.white, 15),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 190 * materialRowNum - 5,
            width: 365,
            margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
            child: Wrap(
              children: itemWidgetList,
            ),
          ),
          Container(
            height: 59 * planRowNum - 9,
            width: 365,
            margin: const EdgeInsets.fromLTRB(8, 8, 3, 3),
            child: Wrap(
              children: planWidgetList,
            ),
          ),
        ],
      ),
    );
  }

  Widget infoWidget(ItemDTO item) {
    double fontSize = 18;
    if (item.id == 202) {
      fontSize = 10;
    }
    return Container(
      width: 85,
      height: 185,
      margin: const EdgeInsets.fromLTRB(0, 0, 5, 5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        children: <Widget>[
          Tooltip(
            message: item.name,
            child: Stack(
              children: [
                Positioned(
                  child: Image(
                    image: AssetImage(backgroundMap[item.star]!),
                    width: 85,
                    height: 85,
                  ),
                ),
                Positioned(
                  child: Image(
                    image: AssetImage(item.imageAddress),
                    width: 85,
                    height: 85,
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.zero,
            child: needNumWidget(item),
          ),
          mergeNumWidget(item),
          Container(
            alignment: Alignment.center,
            height: 25,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: allController[item],
              onChanged: (value) => _updateHaveNum(item, value),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ),
          mergeContainer(item),
        ],
      ),
    );
  }

  void _updateHaveNum(ItemDTO item, String num) {
    setState(() {
      if (num == '') {
        haveNumMap[item] = 0;
      } else {
        haveNumMap[item] = int.parse(num);
      }
      saveGlobalVars();
    });
  }

  void _minusHave(ItemDTO item) {
    setState(() {
      int? thisHave = 0;
      if (haveNumMap.containsKey(item)) {
        thisHave = haveNumMap[item];
      } else {
        haveNumMap[item] = 0;
      }
      if (thisHave! > 0) {
        haveNumMap[item] = thisHave - 1;
      }
      allController[item]?.text = haveNumMap[item].toString();
      saveGlobalVars();
    });
  }

  void _addHave(ItemDTO item) {
    setState(() {
      int? thisHave = 0;
      if (haveNumMap.containsKey(item)) {
        thisHave = haveNumMap[item];
      } else {
        haveNumMap[item] = 0;
      }
      haveNumMap[item] = thisHave! + 1;
      allController[item]?.text = haveNumMap[item].toString();
      saveGlobalVars();
    });
  }

  void _merge(ItemDTO item1, ItemDTO item2) {
    setState(() {
      int? thisId1Have = 0;
      int? thisId2Have = 0;
      if (haveNumMap.containsKey(item1)) {
        thisId1Have = haveNumMap[item1];
      } else {
        haveNumMap[item1] = 0;
      }
      if (haveNumMap.containsKey(item2)) {
        thisId2Have = haveNumMap[item2];
      } else {
        haveNumMap[item2] = 0;
      }
      if (thisId2Have! >= 3) {
        haveNumMap[item1] = thisId1Have! + 1;
        haveNumMap[item2] = thisId2Have - 3;
      }
      allController[item1]?.text = haveNumMap[item1].toString();
      allController[item2]?.text = haveNumMap[item2].toString();
      saveGlobalVars();
    });
  }

  static Widget needNumWidget(ItemDTO item) {
    double fontSize = 15;
    if (item.id == 202) {
      fontSize = 10;
    }
    final int thisNeedNum = need(item);
    final int lack = mergeLack(item);
    if (lack == 0 && thisNeedNum > 0) {
      return Container(
        height: 20,
        color: unLackColor(),
        alignment: Alignment.center,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 15,
              ),
            ),
            Expanded(
              flex: 3,
              child: customText(thisNeedNum.toString(), Colors.white, fontSize),
            ),
          ],
        ),
      );
    } else if (lack > 0) {
      return Container(
        height: 20,
        color: lackColor(),
        alignment: Alignment.center,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 15,
              ),
            ),
            Expanded(
              flex: 3,
              child: customText(thisNeedNum.toString(), Colors.white, fontSize),
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 20,
        color: Colors.white10,
        alignment: Alignment.center,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 15,
              ),
            ),
            Expanded(
              flex: 3,
              child: customText(thisNeedNum.toString(), Colors.white, fontSize),
            ),
          ],
        ),
      );
    }
  }

  Widget mergeContainer(ItemDTO item) {
    if (mergeMap.containsKey(item)) {
      return Container(
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 26,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _minusHave(item),
                child: customText('-', Colors.white, 15),
              ),
            ),
            Container(
              width: 26,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _addHave(item),
                child: customText('+', Colors.white, 15),
              ),
            ),
            Container(
              width: 26,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _merge(item, mergeMap[item]!),
                child: customText('合', Colors.white, 15),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.fromLTRB(0, 3, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              width: 41,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _minusHave(item),
                child: customText('-', Colors.white, 15),
              ),
            ),
            Container(
              width: 41,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () => _addHave(item),
                child: customText('+', Colors.white, 15),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget mergeNumWidget(ItemDTO item) {
    double fontSize = 15;
    if (item.id == 202) {
      fontSize = 10;
    }
    final int lackNum = mergeLack(item);
    final int merge = mergeNum(item);
    String t = '';
    Color c = Colors.white;
    if (lackNum > 0) {
      t = lackNum.toString();
      c = lackColor();
    } else if (merge == 0) {
      t = '';
      c = Colors.white10;
    } else {
      t = merge.toString();
      c = mergeColor();
    }
    return Container(
      alignment: Alignment.center,
      height: 20,
      width: 85,
      margin: EdgeInsets.zero,
      color: c,
      child: customText(t, Colors.white, fontSize),
    );
  }
}
