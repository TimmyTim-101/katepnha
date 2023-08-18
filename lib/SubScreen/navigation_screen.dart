import 'package:flutter/material.dart';
import '../custom_style.dart';
import '../Utils/page_route.dart';
import '../SubScreen/home_screen.dart';
import '../SubScreen/character_screen.dart';
import '../SubScreen/weapon_screen.dart';
import '../SubScreen/inventory_screen.dart';
import '../SubScreen/plan_screen.dart';
import '../SubScreen/action_screen.dart';
import '../SubScreen/library_screen.dart';

Widget getNavigationSubScreen(int i, BuildContext context) {
  return SizedBox(
    width: 200,
    child: Material(
      color: frontColor(),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(CustomRoute(const HomeScreen()));
              },
              child: Image.asset('images/KatepиHa_title.png'),
            ),
          ),
          customDivider(),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/character.png'),
              width: 30,
              height: 30,
            ),
            title: customText('角色', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const CharacterScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 2,
          ),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/weapons.png'),
              width: 30,
              height: 30,
            ),
            title: customText('武器', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const WeaponScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 3,
          ),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/bag.png'),
              width: 30,
              height: 30,
            ),
            title: customText('背包', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const InventoryScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 4,
          ),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/quest.png'),
              width: 30,
              height: 30,
            ),
            title: customText('事件', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const ActionScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 5,
          ),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/timeline.png'),
              width: 30,
              height: 30,
            ),
            title: customText('规划', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const PlanScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 6,
          ),
          ListTile(
            leading: const Image(
              image: AssetImage('images/navigation/todos.png'),
              width: 30,
              height: 30,
            ),
            title: customText('数据库', Colors.white70),
            onTap: () {
              Navigator.of(context).push(CustomRoute(const LibraryScreen()));
            },
            selectedTileColor: selectedColor(),
            selected: i == 7,
          ),
          customDivider(),
        ],
      ),
    ),
  );
}
