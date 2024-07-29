import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/DTO/weapon_dto.dart';
import 'package:katepnha/DTO/weapon_list_dto.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

import '../Utils/random_id_generator.dart';

class WeaponScreen extends StatelessWidget {
  const WeaponScreen({super.key});

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
    return getNavigationSubScreen(3, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  void initial() {
    if (weaponLevelMap.length != allWeapon.length) {
      for (final element in allWeapon) {
        if (!weaponLevelMap.containsKey(element.vid)) {
          weaponLevelMap[element.vid] = {1: 1, 2: 1};
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
        child: Row(
          children: [
            filterList(),
            confirmedList(),
          ],
        ),
      ),
    );
  }

  Widget filterList() {
    final List<Widget> listViewWidgetList = [];
    listViewWidgetList.addAll(buttons());
    listViewWidgetList.add(customDivider());
    listViewWidgetList.addAll(certainContents());
    final Widget thisContainer = SizedBox(
      width: MediaQuery.of(context).size.width - 700,
      child: ListView(
        children: listViewWidgetList,
      ),
    );
    return thisContainer;
  }

  List<Widget> buttons() {
    final List<Widget> res = [];
    // by star
    res.add(
      Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 0, 10),
        child: Wrap(
          spacing: 5,
          children: [
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchStar(1),
              child: Container(
                width: 50,
                color: weaponStarFilter == 1 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(starMap[1]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('1星'),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchStar(2),
              child: Container(
                width: 50,
                color: weaponStarFilter == 2 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(starMap[2]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('2星'),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchStar(3),
              child: Container(
                width: 50,
                color: weaponStarFilter == 3 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(starMap[3]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('3星'),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchStar(4),
              child: Container(
                width: 50,
                color: weaponStarFilter == 4 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(starMap[4]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('4星'),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchStar(5),
              child: Container(
                width: 50,
                color: weaponStarFilter == 5 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(starMap[5]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('5星'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // by type
    res.add(
      Container(
        margin: const EdgeInsets.fromLTRB(30, 20, 0, 10),
        child: Wrap(
          spacing: 5,
          children: [
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchWeapon(1),
              child: Container(
                width: 50,
                color: weaponFilter == 1 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(weaponPictureAddress[WeaponType.sword]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('单手剑', Colors.white, 12),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchWeapon(2),
              child: Container(
                width: 50,
                color: weaponFilter == 2 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(weaponPictureAddress[WeaponType.claymore]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('双手剑', Colors.white, 12),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchWeapon(3),
              child: Container(
                width: 50,
                color: weaponFilter == 3 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(weaponPictureAddress[WeaponType.pole]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('长柄武器', Colors.white, 12),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchWeapon(4),
              child: Container(
                width: 50,
                color: weaponFilter == 4 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(weaponPictureAddress[WeaponType.bow]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('弓', Colors.white, 12),
                  ],
                ),
              ),
            ),
            MaterialButton(
              highlightColor: backColor(),
              splashColor: backColor(),
              minWidth: 30,
              onPressed: () => _switchWeapon(5),
              child: Container(
                width: 50,
                color: weaponFilter == 5 ? selectedColor() : backColor(),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage(weaponPictureAddress[WeaponType.catalyst]!),
                      width: 50,
                      height: 50,
                    ),
                    customText('法器', Colors.white, 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return res;
  }

  List<Widget> certainContents() {
    final List<Widget> res = [];
    final List<Widget> wrapList = [];
    for (var thisWeapon in allWeapon) {
      thisWeapon = thisWeapon as WeaponDTO;
      final int thisStar = thisWeapon.star;
      final WeaponType thisWeaponType = thisWeapon.weaponType;
      bool isStar = true;
      bool isWeapon = true;
      switch (weaponStarFilter) {
        case 1:
          if (thisStar != 1) {
            isStar = false;
          }
          break;
        case 2:
          if (thisStar != 2) {
            isStar = false;
          }
          break;
        case 3:
          if (thisStar != 3) {
            isStar = false;
          }
          break;
        case 4:
          if (thisStar != 4) {
            isStar = false;
          }
          break;
        case 5:
          if (thisStar != 5) {
            isStar = false;
          }
          break;
        default:
          break;
      }
      switch (weaponFilter) {
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
      if (isStar && isWeapon) {
        wrapList.add(
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                color: Colors.white,
              ),
            ),
            height: 270,
            width: 161,
            child: Column(
              children: [
                Stack(
                  children: [
                    Positioned(
                      child: Image(
                        image: AssetImage(backgroundMap[thisWeapon.star]!),
                        width: 160,
                        height: 160,
                      ),
                    ),
                    Positioned(
                      child: Image(
                        image: AssetImage(thisWeapon.imageAddress),
                        width: 160,
                        height: 160,
                      ),
                    ),
                    Positioned(
                      child: Image(
                        image: AssetImage(weaponPictureAddress[thisWeapon.weaponType]!),
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 160,
                  margin: const EdgeInsets.all(2),
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: customText(thisWeapon.name),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.white30,
                    ),
                  ),
                  width: 161,
                  height: 33,
                  child: Column(
                    children: [
                      infoWidgetProducer(thisWeapon, thisWeapon.star >= 3 ? level90DropdownItems : level70DropdownItems, PlanType.weaponLevel, thisWeapon.levelUpDTO!.itemMap),
                    ],
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: MaterialButton(
                    onPressed: () => _confirmWeapon(thisWeapon as WeaponDTO),
                    child: Icon(
                      Icons.check_box_rounded,
                      size: 30,
                      color: unLackColor(),
                    ),
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

  void _confirmWeapon(WeaponDTO weapon) {
    setState(() {
      // 判断前后等级是否一致
      if (weaponLevelMap[weapon.vid]![1]! == weaponLevelMap[weapon.vid]![2]!) {
        return;
      }
      // weapon list
      final String thisKey = getRandomId();
      final WeaponListDTO thisWeaponListDTO = WeaponListDTO(thisKey, weapon, weaponLevelMap[weapon.vid]![1]!, weaponLevelMap[weapon.vid]![2]! - 1);
      weaponList.add(thisWeaponListDTO);
      // action
      for (int i = weaponLevelMap[weapon.vid]![1]!; i < weaponLevelMap[weapon.vid]![2]!; i++) {
        final PlanDTO thisPlanDTO = PlanDTO(thisKey, weapon, PlanType.weaponLevel, i);
        planList.add(thisPlanDTO);
        for (final e in weapon.levelUpDTO!.itemMap[i]!) {
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
  }

  Widget infoWidgetProducer(ItemDTO weapon, List<DropdownMenuItem> dropdownItemList, PlanType planType, Map<int, List<ItemPairDTO>> itemMap) {
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
                    weaponLevelMap[weapon.vid]![1] = value!;
                    if (weaponLevelMap[weapon.vid]![2]! < value) {
                      weaponLevelMap[weapon.vid]![2] = value;
                    }
                    saveGlobalVarsToFile();
                  });
                },
                isExpanded: true,
                value: weaponLevelMap[weapon.vid]![1],
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
                    weaponLevelMap[weapon.vid]![2] = value!;
                    if (weaponLevelMap[weapon.vid]![1]! > value) {
                      weaponLevelMap[weapon.vid]![1] = value;
                    }
                    saveGlobalVarsToFile();
                  });
                },
                isExpanded: true,
                value: weaponLevelMap[weapon.vid]![2],
                style: TextStyle(backgroundColor: backColor()),
                decoration: const InputDecoration.collapsed(hintText: ''),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _switchStar(int i) {
    setState(() {
      if (weaponStarFilter == i) {
        weaponStarFilter = 0;
      } else {
        weaponStarFilter = i;
      }
      saveGlobalVarsToFile();
    });
  }

  void _switchWeapon(int i) {
    setState(() {
      if (weaponFilter == i) {
        weaponFilter = 0;
      } else {
        weaponFilter = i;
      }
      saveGlobalVarsToFile();
    });
  }

  Widget confirmedList() {
    final List<Widget> listViewWidgetList = [];
    for (final thisWeaponList in weaponList) {
      listViewWidgetList.add(
        Container(
          height: 50,
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          child: Row(
            children: [
              SizedBox(
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                      child: Image(
                        image: AssetImage(backgroundMap[thisWeaponList.weapon.star]!),
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Positioned(
                      child: Image(
                        image: AssetImage(thisWeaponList.weapon.imageAddress),
                        height: 50,
                        width: 50,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: customText(thisWeaponList.weapon.name),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: customText(thisWeaponList.weapon.star >= 2 ? level90Text[thisWeaponList.lowerBound]! : level70Text[thisWeaponList.lowerBound]!),
              ),
              Container(
                alignment: Alignment.center,
                width: 50,
                child: customText('>>'),
              ),
              Container(
                alignment: Alignment.center,
                width: 100,
                child: customText(thisWeaponList.weapon.star >= 2 ? level90Text[thisWeaponList.upperBound + 1]! : level70Text[thisWeaponList.upperBound + 1]!),
              ),
              Container(
                alignment: Alignment.center,
                width: 50,
                padding: const EdgeInsets.all(5),
                child: MaterialButton(
                  child: Icon(
                    Icons.delete_forever,
                    size: 40,
                    color: lackColor(),
                  ),
                  onPressed: () => _deleteWeaponList(thisWeaponList),
                ),
              ),
            ],
          ),
        ),
      );
    }
    final Widget thisContainer = Container(
      width: 500,
      color: frontColor(),
      child: ListView(
        children: listViewWidgetList,
      ),
    );
    return thisContainer;
  }

  void _deleteWeaponList(WeaponListDTO weaponListDTO) {
    setState(() {
      final String thisWeaponListId = weaponListDTO.id;
      // 删除列表中的条目
      int removeIndex = -1;
      for (int i = 0; i < weaponList.length; i++) {
        if (weaponList[i].id == thisWeaponListId) {
          removeIndex = i;
          break;
        }
      }
      weaponList.removeAt(removeIndex);
      // 删除事件中的条目
      final List<int> deleteIndex = [];
      for (int i = planList.length - 1; i >= 0; i--) {
        if (planList[i].id == thisWeaponListId) {
          deleteIndex.add(i);
        }
      }
      for (final thisIndex in deleteIndex) {
        planList.removeAt(thisIndex);
      }
      // 恢复needMap
      final Map<int, List<ItemPairDTO>> weaponLevelUpMap = (weaponListDTO.weapon as WeaponDTO).levelUpDTO!.itemMap;
      for (int i = weaponListDTO.lowerBound; i <= weaponListDTO.upperBound; i++) {
        final List<ItemPairDTO> thisItemPairList = weaponLevelUpMap[i]!;
        for (final itemPair in thisItemPairList) {
          final ItemDTO thisItem = itemPair.itemId;
          needNumMap[thisItem] = needNumMap[thisItem]! - itemPair.num.round();
        }
      }
      saveGlobalVarsToFile();
    });
  }
}
