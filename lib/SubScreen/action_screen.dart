import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/Utils/number_convert.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/character_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/DTO/weapon_dto.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';
import 'package:katepnha/Utils/lack_calculate.dart';

class ActionScreen extends StatelessWidget {
  const ActionScreen({super.key});

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
    return getNavigationSubScreen(5, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  Map<ItemDTO, TextEditingController> allController = {};

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

  @override
  Widget build(BuildContext context) {
    initial();
    return SizedBox(
      width: MediaQuery.of(context).size.width - 200,
      child: Material(
        color: backColor(),
        child: ListView(
          children: _getAllContent(),
        ),
      ),
    );
  }

  List<Widget> _getAllContent() {
    final List<Widget> res = [];
    res.add(
      Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 30, 5),
        child: customText('事件'),
      ),
    );
    res.add(customDivider());
    final Map<PlanType, Set<String>> planTypeItemMap = {};
    for (int i = 0; i < planList.length; i++) {
      final PlanDTO thisPlan = planList[i];
      final PlanType thisPlanType = thisPlan.planType;
      if (!planTypeItemMap.containsKey(thisPlanType)) {
        planTypeItemMap[thisPlanType] = {};
      }
      bool isCanComplete = true;
      isCanComplete = !planTypeItemMap[thisPlanType]!.contains(thisPlan.id);
      planTypeItemMap[thisPlanType]!.add(thisPlan.id);
      res.add(
        Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            border: Border.all(
              color: Colors.white,
            ),
          ),
          margin: const EdgeInsets.fromLTRB(30, 5, 30, 0),
          height: 52,
          child: Row(
            children: [
              Container(
                width: 60,
                alignment: Alignment.center,
                child: customText((i + 1).toString()),
              ),
              SizedBox(
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image(
                        image: AssetImage(backgroundMap[thisPlan.item.star]!),
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Positioned(
                      child: Image(
                        image: AssetImage(thisPlan.item.imageAddress),
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
                child: customText(thisPlan.item.name),
              ),
              Container(
                width: 70,
                alignment: Alignment.center,
                child: customText(planTypeText[thisPlan.planType]!, Colors.white, 15),
              ),
              Container(
                width: 100,
                alignment: Alignment.center,
                child: getLevelWidget(thisPlan.planType, thisPlan.num),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 1,
                  padding: const EdgeInsets.fromLTRB(0, 0, 2, 0),
                  scrollDirection: Axis.horizontal,
                  children: getAllMaterial(thisPlan.planType, thisPlan.item, thisPlan.num),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  onPressed: () => _top(i),
                  child: const Icon(
                    Icons.vertical_align_top,
                    size: 40,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  onPressed: () => _up(i),
                  child: const Icon(
                    Icons.arrow_circle_up,
                    size: 40,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  onPressed: () => _down(i),
                  child: const Icon(
                    Icons.arrow_circle_down,
                    size: 40,
                    color: Colors.white70,
                  ),
                ),
              ),
              Container(
                width: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  onPressed: () => _complete(i, isCanComplete),
                  child: Icon(
                    Icons.check_box_rounded,
                    size: 40,
                    color: isCanComplete ? unLackColor() : noCanCompleteColor(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return res;
  }

  void _top(int index) {
    setState(() {
      final String thisId = planList[index].id;
      final List<PlanDTO> l1 = [];
      final List<PlanDTO> l2 = [];
      for (final p in planList) {
        if (thisId == p.id) {
          l1.add(p);
        } else {
          l2.add(p);
        }
      }
      planList = [];
      planList.addAll(l1);
      planList.addAll(l2);
      saveGlobalVarsToFile();
    });
  }

  void _up(int index) {
    setState(() {
      final String thisId = planList[index].id;
      String previousId = planList[0].id;
      for (final p in planList) {
        if (p.id == thisId) {
          break;
        }
        previousId = p.id;
      }
      final List<PlanDTO> l1 = [];
      final List<PlanDTO> l2 = [];
      bool f = false;
      for (final p in planList) {
        if (p.id == thisId) {
          l1.add(p);
        } else if (p.id == previousId) {
          l2.add(p);
          f = true;
        } else if (f == false) {
          l1.add(p);
        } else {
          l2.add(p);
        }
      }
      planList = [];
      planList.addAll(l1);
      planList.addAll(l2);
      saveGlobalVarsToFile();
    });
  }

  void _down(int index) {
    setState(() {
      final String thisId = planList[index].id;
      String postId = planList[planList.length - 1].id;
      for (int i = planList.length - 1; i >= 0; i--) {
        final PlanDTO p = planList[i];
        if (p.id == thisId) {
          break;
        }
        postId = p.id;
      }
      final List<PlanDTO> l1 = [];
      final List<PlanDTO> l2 = [];
      bool f = false;
      for (final p in planList) {
        if (p.id == postId) {
          l1.add(p);
          f = true;
        } else if (p.id == thisId) {
          l2.add(p);
        } else if (f == false) {
          l1.add(p);
        } else {
          l2.add(p);
        }
      }
      planList = [];
      planList.addAll(l1);
      planList.addAll(l2);
      saveGlobalVarsToFile();
    });
  }

  void _complete(int index, bool isCanComplete) {
    setState(() {
      // 判断是否可以完成：前面没有相同的就可以，避免被套娃
      if (isCanComplete == false) {
        return;
      }
      // 删除背包内数据，注意0
      final PlanDTO thisPlan = planList[index];
      final List<ItemPairDTO> thisMaterialList = getMaterialList(thisPlan.planType, thisPlan.item, thisPlan.num);
      for (final element in thisMaterialList) {
        final ItemDTO thisItem = element.itemId;
        final int thisNum = element.num.round();
        if (!haveNumMap.containsKey(thisItem)) {
          haveNumMap[thisItem] = 0;
        } else {
          haveNumMap[thisItem] = max(0, haveNumMap[thisItem]! - thisNum);
        }
        needNumMap[thisItem] = needNumMap[thisItem]! - thisNum;
      }
      // 删除list所在index
      planList.removeAt(index);
      // 反馈给角色页
      feedback(thisPlan);
      saveGlobalVarsToFile();
    });
  }

  void feedback(PlanDTO planDTO) {
    setState(() {
      final PlanType planType = planDTO.planType;
      final int thisNum = planDTO.num;
      final ItemDTO thisItem = planDTO.item;
      switch (planType) {
        case PlanType.characterLevel:
          characterLevelMap[thisItem.vid]![1] = thisNum + 1;
          break;
        case PlanType.characterTalent1:
          characterLevelMap[thisItem.vid]![3] = thisNum + 1;
          break;
        case PlanType.characterTalent2:
          characterLevelMap[thisItem.vid]![5] = thisNum + 1;
          break;
        case PlanType.characterTalent3:
          characterLevelMap[thisItem.vid]![7] = thisNum + 1;
          break;
        case PlanType.weaponLevel:
          // 更改内部数据
          weaponLevelMap[thisItem.vid]![1] = thisNum + 1;
          // 更改武器右边list数据
          final String thisWeaponPlanId = planDTO.id;
          int weaponListIndex = -1;
          for (int i = 0; i < weaponList.length; i++) {
            if (weaponList[i].id == thisWeaponPlanId) {
              weaponListIndex = i;
              weaponList[i].lowerBound = thisNum + 1;
            }
          }
          // 如果事件全部解决删除武器右边list
          bool isAllDone = true;
          for (final p in planList) {
            if (p.id == thisWeaponPlanId) {
              isAllDone = false;
            }
          }
          if (isAllDone) {
            weaponList.removeAt(weaponListIndex);
          }
          break;
        // todo:其他情况
        default:
          break;
      }
    });
  }

  Widget getLevelWidget(PlanType planType, int num) {
    if (planType == PlanType.characterLevel || planType == PlanType.weaponLevel) {
      return customText(levelUpText[num]!);
    } else if (planType == PlanType.pick) {
      return customText(num.toString());
    } else {
      return customText(talentUpText[num]!);
    }
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

  List<Widget> getAllMaterial(PlanType planType, ItemDTO item, int num) {
    final List<Widget> res = [];
    final List<ItemPairDTO> thisMaterialList = getMaterialList(planType, item, num);
    for (final element in thisMaterialList) {
      res.add(
        SizedBox(
          width: 40,
          child: Column(
            children: [
              MaterialButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return Center(
                            child: Material(
                              child: infoWidgets(element.itemId, onUpdate: () {
                                setState(() {});
                              }),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image(
                          image: AssetImage(backgroundMap[element.itemId.star]!),
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Positioned(
                        child: Image(
                          image: AssetImage(element.itemId.imageAddress),
                          width: 40,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 40,
                height: 10,
                // 颜色标识
                color: have(element.itemId) < element.num ? lackColor() : unLackColor(),
                child: customText(have(element.itemId) < element.num ? convertNumberToString(element.num - have(element.itemId)) : convertNumberToString(element.num), Colors.white, 10),
              ),
            ],
          ),
        ),
      );
    }
    return res;
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

  Widget infoWidgets(ItemDTO item, {VoidCallback? onUpdate}) {
    List<ItemDTO> allItems = [item];
    for (final element in allGroup) {
      if (element.groupList.contains(item)) {
        allItems = [];
        allItems.addAll(element.groupList);
      }
    }
    allItems.sort((o1, o2) => o2.vid.compareTo(o1.vid));
    final List<Widget> res = [];
    for (final element in allItems) {
      res.add(infoWidget(element, onUpdate: onUpdate));
    }
    return Container(
      color: frontColor(),
      padding: const EdgeInsets.all(2),
      width: (85 + 5) * allItems.length + 4,
      height: 195 + 4 + 4,
      child: Row(
        children: res,
      ),
    );
  }

  Widget infoWidget(ItemDTO item, {VoidCallback? onUpdate}) {
    double fontSize = 18;
    if (item.rid == 202) {
      fontSize = 10;
    }
    return Container(
      width: 85,
      height: 195,
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
            height: 35,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              textAlign: TextAlign.center,
              controller: allController[item],
              onChanged: (value) {
                _updateHaveNum(item, value);
                if (onUpdate != null) onUpdate();
              },
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
          mergeContainer(item, onUpdate: onUpdate),
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
      saveGlobalVarsToFile();
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
      saveGlobalVarsToFile();
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
      saveGlobalVarsToFile();
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
      saveGlobalVarsToFile();
    });
  }

  static Widget needNumWidget(ItemDTO item) {
    double fontSize = 15;
    if (item.rid == 202) {
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

  Widget mergeContainer(ItemDTO item, {VoidCallback? onUpdate}) {
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
                onPressed: () {
                  _minusHave(item);
                  if (onUpdate != null) onUpdate();
                },
                child: customText('-', Colors.white, 15),
              ),
            ),
            Container(
              width: 26,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _addHave(item);
                  if (onUpdate != null) onUpdate();
                },
                child: customText('+', Colors.white, 15),
              ),
            ),
            Container(
              width: 26,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _merge(item, mergeMap[item]!);
                  if (onUpdate != null) onUpdate();
                },
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
                onPressed: () {
                  _minusHave(item);
                  if (onUpdate != null) onUpdate();
                },
                child: customText('-', Colors.white, 15),
              ),
            ),
            Container(
              width: 41,
              height: 25,
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  _addHave(item);
                  if (onUpdate != null) onUpdate();
                },
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
    if (item.rid == 202) {
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
