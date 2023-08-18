import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/material_dto.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';
import 'package:katepnha/Utils/lack_calculate.dart';

class InventoryScreen extends StatelessWidget {
  const InventoryScreen({super.key});

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
    return getNavigationSubScreen(4, context);
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
    // 初始化合并关系map
    if (mergeMap.isEmpty) {
      for (final element in allGroup) {
        final List<ItemDTO> thisGroupList = element.groupList;
        for (int i = 0; i < thisGroupList.length - 1; i++) {
          final ItemDTO littleItem = thisGroupList[i];
          final ItemDTO bigItem = thisGroupList[i + 1];
          mergeMap[bigItem] = littleItem;
          reverseMergeMap[littleItem] = bigItem;
        }
      }
    }
    // 初始化输入框控制器
    if (allController.isEmpty) {
      for (final element in allMaterial) {
        allController[element] = getController(element);
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

  List<Widget> _buttons() {
    final List<Widget> res = [];
    final Widget thisContainer = Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 0, 10),
      child: Wrap(
        spacing: 5,
        children: <Widget>[
          MaterialButton(
            color: inventoryDisplay == 1 ? buttonSelectedColor() : buttonUnselectedColor(),
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            onPressed: () => _switchInventoryDisplay(1),
            child: const Text('全部'),
          ),
          MaterialButton(
            color: inventoryDisplay == 2 ? buttonSelectedColor() : buttonUnselectedColor(),
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            onPressed: () => _switchInventoryDisplay(2),
            child: const Text('养成道具'),
          ),
          MaterialButton(
            color: inventoryDisplay == 3 ? buttonSelectedColor() : buttonUnselectedColor(),
            disabledTextColor: Colors.white,
            textColor: Colors.white,
            onPressed: () => _switchInventoryDisplay(3),
            child: const Text('材料'),
          ),
        ],
      ),
    );
    res.add(thisContainer);
    return res;
  }

  List<Widget> _certainContents() {
    final List<Widget> res = [];
    res.add(widgetListContainer(GMaterialType.exp));
    res.add(customDivider());
    if (inventoryDisplay == 1 || inventoryDisplay == 2) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('角色与武器培养素材', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.cwp));
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('角色培养素材-周本掉落', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.clu));
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('角色培养素材-BOSS掉落', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.cb));
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('角色突破素材', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.cc));
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('角色天赋素材', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.ct));
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('武器突破素材', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.wlu));
      res.add(customDivider());
    }
    if (inventoryDisplay == 1 || inventoryDisplay == 3) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 10, 0, 10),
          child: customText('特产', Colors.white, 15),
        ),
      );
      res.add(widgetListContainer(GMaterialType.spec));
    }
    return res;
  }

  Widget widgetListContainer(GMaterialType t) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
      child: Wrap(
        children: widgetList(t),
      ),
    );
  }

  List<Widget> widgetList(GMaterialType t) {
    final List<Widget> res = [];
    for (var element in allMaterial) {
      element = element as MaterialDTO;
      if (t == element.materialType) {
        res.add(infoWidget(element));
      }
    }
    return res;
  }

  void _switchInventoryDisplay(int i) {
    setState(() {
      if (inventoryDisplay == i) {
        inventoryDisplay = 1;
      } else {
        inventoryDisplay = i;
      }
      saveGlobalVars();
    });
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
