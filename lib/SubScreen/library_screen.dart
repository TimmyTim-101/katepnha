import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/Utils/json_util.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/SubScreen/navigation_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

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
    return getNavigationSubScreen(7, context);
  }
}

class Contents extends StatefulWidget {
  const Contents({super.key});

  @override
  State<StatefulWidget> createState() => _ContentsState();
}

class _ContentsState extends State<Contents> {
  @override
  Widget build(BuildContext context) {
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
    res.addAll(buttons());
    res.add(customDivider());
    res.addAll(certainContents());
    return res;
  }

  List<Widget> buttons() {
    final List<Widget> res = [];
    final Widget thisContainer = Container(
      margin: const EdgeInsets.fromLTRB(30, 20, 0, 10),
      child: Wrap(
        spacing: 5,
        children: <Widget>[
          filterButtonProducer(1, '全部'),
          filterButtonProducer(2, '角色'),
          filterButtonProducer(3, '武器'),
          filterButtonProducer(4, '材料'),
          filterButtonProducer(5, '秘境'),
        ],
      ),
    );
    res.add(thisContainer);
    return res;
  }

  Widget filterButtonProducer(int n, String s) {
    return MaterialButton(
      color: databaseDisplay == n ? buttonSelectedColor() : buttonUnselectedColor(),
      disabledTextColor: Colors.white,
      textColor: Colors.white,
      onPressed: () => _switchDatabaseDisplay(n),
      child: Text(s),
    );
  }

  List<Widget> certainContents() {
    final List<Widget> res = [];
    if (databaseDisplay == 1 || databaseDisplay == 2) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: customText('角色'),
        ),
      );
      final List<Widget> characterWrapChildren = [];
      for (final element in allCharacter) {
        characterWrapChildren.add(element.getItemInfoWidget());
      }
      final Widget characterWrap = Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
        child: Wrap(
          children: characterWrapChildren,
        ),
      );
      res.add(characterWrap);
      res.add(customDivider());
    }
    if (databaseDisplay == 1 || databaseDisplay == 3) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: customText('武器'),
        ),
      );
      final List<Widget> weaponWrapChildren = [];
      for (final element in allWeapon) {
        weaponWrapChildren.add(element.getItemInfoWidget());
      }
      final Widget weaponWrap = Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
        child: Wrap(
          children: weaponWrapChildren,
        ),
      );
      res.add(weaponWrap);
      res.add(customDivider());
    }
    if (databaseDisplay == 1 || databaseDisplay == 4) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: customText('材料'),
        ),
      );
      final List<Widget> materialWrapChildren = [];
      for (final element in allMaterial) {
        materialWrapChildren.add(element.getItemInfoWidget());
      }
      final Widget materialWrap = Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
        child: Wrap(
          children: materialWrapChildren,
        ),
      );
      res.add(materialWrap);
      res.add(customDivider());
    }
    if (databaseDisplay == 1 || databaseDisplay == 5) {
      res.add(
        Container(
          margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: customText('秘境'),
        ),
      );
      final List<Widget> dungeonWrapChildren = [];
      for (final element in allDungeon) {
        dungeonWrapChildren.add(element.getItemInfoWidget());
      }
      final Widget dungeonWrap = Container(
        margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
        child: Wrap(
          children: dungeonWrapChildren,
        ),
      );
      res.add(dungeonWrap);
      res.add(customDivider());
    }
    return res;
  }

  void _switchDatabaseDisplay(int i) {
    setState(() {
      if (databaseDisplay == i) {
        databaseDisplay = 1;
      } else {
        databaseDisplay = i;
      }
      saveGlobalVars();
    });
  }
}
