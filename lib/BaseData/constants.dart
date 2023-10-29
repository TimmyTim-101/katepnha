import 'package:flutter/material.dart';
import 'package:katepnha/custom_style.dart';

// 元素类型：火水风雷草冰岩
enum ElementType {
  pyro, // 火
  hydro, // 水
  anemo, // 风
  electro, // 雷
  dendro, // 草
  cryo, // 冰
  geo, // 岩
  traveller,
  unknown,
}

// 武器类型
enum WeaponType { sword, catalyst, claymore, bow, pole, unknown }

// 材料类型
enum GMaterialType { exp, cwp, clu, cb, cc, ct, wlu, spec, unknown }

// 实体类型
enum ItemType { character, weapon, material, unknown }

// 事件类型
enum PlanType { characterLevel, characterTalent1, characterTalent2, characterTalent3, weaponLevel, pick, unknown }

// 秘境类型
enum DungeonType { mora, exp, pick, monster, talent, weapon, boss, week, unknown }

// 秘境掉落概率
final Map<DungeonType, List<double>> dungeonOddMap = {
  DungeonType.monster: [1.0, 1.0, 1.0],
  DungeonType.talent: [2.2, 1.98, 0.22],
  DungeonType.weapon: [2.2, 2.418, 0.62, 0.062],
  DungeonType.boss: [2.1607, 1.5961, 0.144, 0.0141],
  DungeonType.week: [3.8343, 2.0423, 0.2556, 0.025],
};

// 元素类型贴图
final Map<ElementType, String> elementPictureAddress = {
  ElementType.pyro: 'images/!others/Pyro.png',
  ElementType.hydro: 'images/!others/Hydro.png',
  ElementType.anemo: 'images/!others/Anemo.png',
  ElementType.electro: 'images/!others/Electro.png',
  ElementType.dendro: 'images/!others/Dendro.png',
  ElementType.cryo: 'images/!others/Cryo.png',
  ElementType.geo: 'images/!others/Geo.png',
  ElementType.traveller: 'images/!others/traveller.png',
};

// 武器类型贴图
final Map<WeaponType, String> weaponPictureAddress = {
  WeaponType.sword: 'images/!others/UI_GachaTypeIcon_Sword.png',
  WeaponType.catalyst: 'images/!others/UI_GachaTypeIcon_Catalyst.png',
  WeaponType.claymore: 'images/!others/UI_GachaTypeIcon_Claymore.png',
  WeaponType.bow: 'images/!others/UI_GachaTypeIcon_Bow.png',
  WeaponType.pole: 'images/!others/UI_GachaTypeIcon_Pole.png',
};

// 物品背景图片
final Map<int, String> backgroundMap = {
  1: 'images/!others/1_star_background.png',
  2: 'images/!others/2_star_background.png',
  3: 'images/!others/3_star_background.png',
  4: 'images/!others/4_star_background.png',
  5: 'images/!others/5_star_background.png',
  6: 'images/!others/5C_star_background.png',
};

// 星级图片
final Map<int, String> starMap = {
  1: 'images/!others/Icon_1_Star.png',
  2: 'images/!others/Icon_2_Star.png',
  3: 'images/!others/Icon_3_Star.png',
  4: 'images/!others/Icon_4_Star.png',
  5: 'images/!others/Icon_5_Star.png',
  6: 'images/!others/Icon_5_Star.png',
};

// 事件类型文本
final Map<PlanType, String> planTypeText = {
  PlanType.characterLevel: '角色等级',
  PlanType.characterTalent1: '普通攻击',
  PlanType.characterTalent2: '元素战技',
  PlanType.characterTalent3: '元素爆发',
  PlanType.weaponLevel: '武器等级',
  PlanType.pick: '采集',
};

// 树脂图片地址
const String resinImageAddress = 'images/!others/resin.png';
const String condensedResinAddress = 'images/!others/condensed_resin.png';

final Map<int, List<int>> dungeonWeekMap = {
  1: [1, 2, 3, 4, 5, 6, 7],
  2: [1, 4, 7],
  3: [2, 5, 7],
  4: [3, 6, 7],
};

// 星期文本
final Map<int, String> weekNameText = {1: '一', 2: '二', 3: '三', 4: '四', 5: '五', 6: '六', 7: '日'};

final Map<int, String> level90Text = {1: '1', 2: '20-', 3: '20+', 4: '40-', 5: '40+', 6: '50-', 7: '50+', 8: '60-', 9: '60+', 10: '70-', 11: '70+', 12: '80-', 13: '80+', 14: '90'};

final Map<int, String> level70Text = {1: '1', 2: '20-', 3: '20+', 4: '40-', 5: '40+', 6: '50-', 7: '50+', 8: '60-', 9: '60+', 10: '70'};

// 升级文本
final Map<int, String> levelUpText = {
  1: '1 → 20',
  2: '20 ↑',
  3: '20 → 40',
  4: '40 ↑',
  5: '40 → 50',
  6: '50 ↑',
  7: '50 → 60',
  8: '60 ↑',
  9: '60 → 70',
  10: '70 ↑',
  11: '70 → 80',
  12: '80 ↑',
  13: '80 → 90',
};

// 天赋文本
final Map<int, String> talentUpText = {
  1: '1 → 2',
  2: '2 → 3',
  3: '3 → 4',
  4: '4 → 5',
  5: '5 → 6',
  6: '6 → 7',
  7: '7 → 8',
  8: '8 → 9',
  9: '9 → 10',
};

// 等级下拉按钮
final List<DropdownMenuItem> level90DropdownItems = [
  DropdownMenuItem(
    value: 1,
    child: customText('1', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 2,
    child: customText('20-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 3,
    child: customText('20+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 4,
    child: customText('40-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 5,
    child: customText('40+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 6,
    child: customText('50-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 7,
    child: customText('50+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 8,
    child: customText('60-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 9,
    child: customText('60+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 10,
    child: customText('70-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 11,
    child: customText('70+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 12,
    child: customText('80-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 13,
    child: customText('80+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 14,
    child: customText('90', Colors.white, 15),
  ),
];
final List<DropdownMenuItem> level70DropdownItems = [
  DropdownMenuItem(
    value: 1,
    child: customText('1', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 2,
    child: customText('20-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 3,
    child: customText('20+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 4,
    child: customText('40-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 5,
    child: customText('40+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 6,
    child: customText('50-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 7,
    child: customText('50+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 8,
    child: customText('60-', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 9,
    child: customText('60+', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 10,
    child: customText('70', Colors.white, 15),
  ),
];
final List<DropdownMenuItem> talent10DropdownItems = [
  DropdownMenuItem(
    value: 1,
    child: customText('1', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 2,
    child: customText('2', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 3,
    child: customText('3', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 4,
    child: customText('4', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 5,
    child: customText('5', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 6,
    child: customText('6', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 7,
    child: customText('7', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 8,
    child: customText('8', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 9,
    child: customText('9', Colors.white, 15),
  ),
  DropdownMenuItem(
    value: 10,
    child: customText('10', Colors.white, 15),
  ),
];
