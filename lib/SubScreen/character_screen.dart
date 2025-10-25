import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/Utils/random_id_generator.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/character_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

class CharacterScreen extends StatelessWidget {
  const CharacterScreen({super.key});

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
    return getNavigationSubScreen(2, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  void initial() {
    if (characterLevelMap.length != allCharacter.length) {
      for (final element in allCharacter) {
        if (!characterLevelMap.containsKey(element.vid)) {
          characterLevelMap[element.vid] = {1: 1, 2: 1, 3: 1, 4: 1, 5: 1, 6: 1, 7: 1, 8: 1};
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
    res.addAll(_buttons());
    res.add(customDivider());
    res.addAll(_certainContents());
    return res;
  }

  Widget elementButtonProducer(int n, ElementType elementType, String s) {
    return MaterialButton(
      highlightColor: backColor(),
      splashColor: backColor(),
      minWidth: 30,
      onPressed: () => _switchElement(n),
      child: Container(
        width: 50,
        color: characterElementFilter == n ? selectedColor() : backColor(),
        child: Column(
          children: [
            Image(
              image: AssetImage(elementPictureAddress[elementType]!),
              width: 50,
              height: 50,
            ),
            customText(s),
          ],
        ),
      ),
    );
  }

  Widget weaponButtonProducer(int n, WeaponType weaponType, String s) {
    return MaterialButton(
      highlightColor: backColor(),
      splashColor: backColor(),
      minWidth: 30,
      onPressed: () => _switchWeapon(n),
      child: Container(
        width: 50,
        color: characterWeaponFilter == n ? selectedColor() : backColor(),
        child: Column(
          children: [
            Image(
              image: AssetImage(weaponPictureAddress[weaponType]!),
              width: 50,
              height: 50,
            ),
            customText(s, Colors.white, 12),
          ],
        ),
      ),
    );
  }

  List<Widget> _buttons() {
    final List<Widget> res = [];
    final Widget elementFilterContainer = Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 0, 10),
      child: Wrap(
        spacing: 5,
        children: [
          elementButtonProducer(1, ElementType.pyro, '火'),
          elementButtonProducer(2, ElementType.hydro, '水'),
          elementButtonProducer(3, ElementType.anemo, '风'),
          elementButtonProducer(4, ElementType.electro, '雷'),
          elementButtonProducer(5, ElementType.dendro, '草'),
          elementButtonProducer(6, ElementType.cryo, '冰'),
          elementButtonProducer(7, ElementType.geo, '岩'),
        ],
      ),
    );
    res.add(elementFilterContainer);
    final Widget weaponFilterContainer = Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 0, 10),
      child: Wrap(
        spacing: 5,
        children: [
          weaponButtonProducer(1, WeaponType.sword, '单手剑'),
          weaponButtonProducer(2, WeaponType.claymore, '双手剑'),
          weaponButtonProducer(3, WeaponType.pole, '长柄武器'),
          weaponButtonProducer(4, WeaponType.bow, '弓'),
          weaponButtonProducer(5, WeaponType.catalyst, '法器'),
        ],
      ),
    );
    res.add(weaponFilterContainer);
    return res;
  }

  List<Widget> _certainContents() {
    final List<Widget> res = [];
    final List<Widget> wrapList = [];
    for (var element in allCharacter) {
      element = element as CharacterDTO;
      final ElementType thisElementType = element.elementType;
      final WeaponType thisWeaponType = element.weaponType;
      bool isElement = true;
      bool isWeapon = true;
      switch (characterElementFilter) {
        case 1:
          if (thisElementType != ElementType.pyro) {
            isElement = false;
          }
          break;
        case 2:
          if (thisElementType != ElementType.hydro) {
            isElement = false;
          }
          break;
        case 3:
          if (thisElementType != ElementType.anemo) {
            isElement = false;
          }
          break;
        case 4:
          if (thisElementType != ElementType.electro) {
            isElement = false;
          }
          break;
        case 5:
          if (thisElementType != ElementType.dendro) {
            isElement = false;
          }
          break;
        case 6:
          if (thisElementType != ElementType.cryo) {
            isElement = false;
          }
          break;
        case 7:
          if (thisElementType != ElementType.geo) {
            isElement = false;
          }
          break;
        default:
          break;
      }
      switch (characterWeaponFilter) {
        case 1:
          if (thisWeaponType != WeaponType.sword) {
            isWeapon = false;
          }
          break;
        case 2:
          if (thisWeaponType != WeaponType.claymore) {
            isWeapon = false;
          }
          break;
        case 3:
          if (thisWeaponType != WeaponType.pole) {
            isWeapon = false;
          }
          break;
        case 4:
          if (thisWeaponType != WeaponType.bow) {
            isWeapon = false;
          }
          break;
        case 5:
          if (thisWeaponType != WeaponType.catalyst) {
            isWeapon = false;
          }
          break;
        default:
          break;
      }
      if (isElement && isWeapon) {
        wrapList.add(
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            height: 206,
            width: 400,
            child: Row(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          child: Image(
                            image: AssetImage(backgroundMap[element.star]!),
                            width: 170,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          child: Image(
                            image: AssetImage(element.imageAddress),
                            width: 170,
                            height: 170,
                          ),
                        ),
                        Positioned(
                          child: Image(
                            image: AssetImage(elementPictureAddress[element.elementType]!),
                            width: 43,
                            height: 43,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 170,
                      margin: const EdgeInsets.all(2),
                      alignment: Alignment.center,
                      child: customText(element.name),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.white30,
                    ),
                  ),
                  width: 214,
                  height: 200,
                  child: Column(
                    children: [
                      infoWidgetProducer(element, '角色', '等级', level90DropdownItems, 1, 2, PlanType.characterLevel, element.levelUpDTO!.itemMap),
                      infoWidgetProducer(element, '普通', '攻击', talent10DropdownItems, 3, 4, PlanType.characterTalent1, element.talentLevelUpDTO!.itemMap1),
                      infoWidgetProducer(element, '元素', '战技', talent10DropdownItems, 5, 6, PlanType.characterTalent2, element.talentLevelUpDTO!.itemMap2),
                      infoWidgetProducer(element, '元素', '爆发', talent10DropdownItems, 7, 8, PlanType.characterTalent3, element.talentLevelUpDTO!.itemMap3),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }
    res.add(
      Wrap(
        children: wrapList,
      ),
    );
    res.add(customDivider());
    return res;
  }

  Widget infoWidgetProducer(ItemDTO element, String s1, String s2, List<DropdownMenuItem> dropdownItemList, int n1, int n2, PlanType planType, Map<int, List<ItemPairDTO>> itemMap) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white10,
        ),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                Container(
                  child: customText(s1, Colors.white, 13),
                ),
                Container(
                  child: customText(s2, Colors.white, 13),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 51,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: frontColor(),
              ),
              child: DropdownButtonFormField(
                items: dropdownItemList,
                onChanged: (value) {
                  setState(() {
                    characterLevelMap[element.vid]![n1] = value!;
                    if (characterLevelMap[element.vid]![n2]! < value) {
                      characterLevelMap[element.vid]![n2] = value;
                    }
                    // 删除已有相关信息
                    final List<int> deleteIndex = [];
                    for (int i = planList.length - 1; i >= 0; i--) {
                      final PlanDTO thisPlan = planList[i];
                      if (thisPlan.item.vid == element.vid && thisPlan.planType == planType) {
                        for (final e in itemMap[thisPlan.num]!) {
                          final ItemDTO thisItem = e.itemId;
                          final int thisNum = e.num.round();
                          needNumMap[thisItem] = needNumMap[thisItem]! - thisNum;
                        }
                        deleteIndex.add(i);
                      }
                    }
                    for (int i = 0; i < deleteIndex.length; i++) {
                      planList.removeAt(deleteIndex[i]);
                    }
                    // 添加新信息
                    final String thisKey = getRandomId();
                    for (int i = characterLevelMap[element.vid]![n1]!; i < characterLevelMap[element.vid]![n2]!; i++) {
                      planList.add(PlanDTO(thisKey, element, planType, i));
                      for (final e in itemMap[i]!) {
                        final ItemDTO thisItem = e.itemId;
                        final int thisNum = e.num.round();
                        if (needNumMap.containsKey(thisItem)) {
                          needNumMap[thisItem] = needNumMap[thisItem]! + thisNum;
                        } else {
                          needNumMap[thisItem] = thisNum;
                        }
                      }
                    }
                    saveGlobalVarsToFile();
                  });
                },
                isExpanded: true,
                initialValue: characterLevelMap[element.vid]![n1],
                style: TextStyle(backgroundColor: backColor()),
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: customText('>>', Colors.white, 15),
          ),
          SizedBox(
            width: 51,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: frontColor(),
              ),
              child: DropdownButtonFormField(
                items: dropdownItemList,
                onChanged: (value) {
                  setState(() {
                    characterLevelMap[element.vid]![n2] = value!;
                    if (characterLevelMap[element.vid]![n1]! > value) {
                      characterLevelMap[element.vid]![n1] = value;
                    }
                    // 删除已有相关信息
                    final List<int> deleteIndex = [];
                    for (int i = planList.length - 1; i >= 0; i--) {
                      final PlanDTO thisPlan = planList[i];
                      if (thisPlan.item.vid == element.vid && thisPlan.planType == planType) {
                        for (final e in itemMap[thisPlan.num]!) {
                          final ItemDTO thisItem = e.itemId;
                          final int thisNum = e.num.round();
                          needNumMap[thisItem] = needNumMap[thisItem]! - thisNum;
                        }
                        deleteIndex.add(i);
                      }
                    }
                    for (int i = 0; i < deleteIndex.length; i++) {
                      planList.removeAt(deleteIndex[i]);
                    }
                    // 添加新信息
                    final String thisKey = getRandomId();
                    for (int i = characterLevelMap[element.vid]![n1]!; i < characterLevelMap[element.vid]![n2]!; i++) {
                      planList.add(PlanDTO(thisKey, element, planType, i));
                      for (final e in itemMap[i]!) {
                        final ItemDTO thisItem = e.itemId;
                        final int thisNum = e.num.round();
                        if (needNumMap.containsKey(thisItem)) {
                          needNumMap[thisItem] = needNumMap[thisItem]! + thisNum;
                        } else {
                          needNumMap[thisItem] = thisNum;
                        }
                      }
                    }
                    saveGlobalVarsToFile();
                  });
                },
                isExpanded: true,
                initialValue: characterLevelMap[element.vid]![n2],
                style: TextStyle(backgroundColor: backColor()),
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _switchElement(int i) {
    setState(() {
      if (characterElementFilter == i) {
        characterElementFilter = 0;
      } else {
        characterElementFilter = i;
      }
      saveGlobalVarsToFile();
    });
  }

  void _switchWeapon(int i) {
    setState(() {
      if (characterWeaponFilter == i) {
        characterWeaponFilter = 0;
      } else {
        characterWeaponFilter = i;
      }
      saveGlobalVarsToFile();
    });
  }
}
