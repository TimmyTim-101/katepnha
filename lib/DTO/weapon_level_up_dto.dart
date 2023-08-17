import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_group_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';

class BaseWeaponLevelUpDTO {
  Map<int, List<ItemPairDTO>> itemMap = {};
}

class WeaponStar1LevelUpDTO extends BaseWeaponLevelUpDTO {
  WeaponStar1LevelUpDTO(ItemGroupDTO reg1, ItemGroupDTO reg2, ItemGroupDTO wea) {
    super.itemMap[1] = [
      ItemPairDTO(i_202, 2432),
      ItemPairDTO(i_104013, 3),
    ];
    super.itemMap[2] = [
      ItemPairDTO(reg1.groupList[0], 1),
      ItemPairDTO(reg2.groupList[0], 1),
      ItemPairDTO(wea.groupList[0], 1),
    ];
    super.itemMap[3] = [
      ItemPairDTO(i_202, 12455),
      ItemPairDTO(i_104013, 13),
    ];
    super.itemMap[4] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[0], 2),
      ItemPairDTO(reg2.groupList[0], 4),
      ItemPairDTO(wea.groupList[1], 1),
    ];
    super.itemMap[5] = [
      ItemPairDTO(i_202, 12562),
      ItemPairDTO(i_104013, 13),
    ];
    super.itemMap[6] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[1], 2),
      ItemPairDTO(reg2.groupList[1], 2),
      ItemPairDTO(wea.groupList[1], 2),
    ];
    super.itemMap[7] = [
      ItemPairDTO(i_202, 18552),
      ItemPairDTO(i_104013, 19),
    ];
    super.itemMap[8] = [
      ItemPairDTO(i_202, 10000),
      ItemPairDTO(reg1.groupList[1], 3),
      ItemPairDTO(reg2.groupList[1], 4),
      ItemPairDTO(wea.groupList[2], 1),
    ];
    super.itemMap[9] = [
      ItemPairDTO(i_202, 25985),
      ItemPairDTO(i_104013, 26),
    ];
  }
}

class WeaponStar2LevelUpDTO extends BaseWeaponLevelUpDTO {
  WeaponStar2LevelUpDTO(ItemGroupDTO reg1, ItemGroupDTO reg2, ItemGroupDTO wea) {
    super.itemMap[1] = [
      ItemPairDTO(i_202, 3640),
      ItemPairDTO(i_104013, 4),
    ];
    super.itemMap[2] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[0], 1),
      ItemPairDTO(reg2.groupList[0], 1),
      ItemPairDTO(wea.groupList[0], 1),
    ];
    super.itemMap[3] = [
      ItemPairDTO(i_202, 18842),
      ItemPairDTO(i_104013, 19),
    ];
    super.itemMap[4] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[0], 4),
      ItemPairDTO(reg2.groupList[0], 5),
      ItemPairDTO(wea.groupList[1], 1),
    ];
    super.itemMap[5] = [
      ItemPairDTO(i_202, 18842),
      ItemPairDTO(i_104013, 19),
    ];
    super.itemMap[6] = [
      ItemPairDTO(i_202, 10000),
      ItemPairDTO(reg1.groupList[1], 3),
      ItemPairDTO(reg2.groupList[1], 3),
      ItemPairDTO(wea.groupList[1], 3),
    ];
    super.itemMap[7] = [
      ItemPairDTO(i_202, 27830),
      ItemPairDTO(i_104013, 28),
    ];
    super.itemMap[8] = [
      ItemPairDTO(i_202, 15000),
      ItemPairDTO(reg1.groupList[1], 4),
      ItemPairDTO(reg2.groupList[1], 5),
      ItemPairDTO(wea.groupList[2], 1),
    ];
    super.itemMap[9] = [
      ItemPairDTO(i_202, 38972),
      ItemPairDTO(i_104013, 39),
    ];
  }
}

class WeaponStar3LevelUpDTO extends BaseWeaponLevelUpDTO {
  WeaponStar3LevelUpDTO(ItemGroupDTO reg1, ItemGroupDTO reg2, ItemGroupDTO wea) {
    super.itemMap[1] = [
      ItemPairDTO(i_202, 5347),
      ItemPairDTO(i_104013, 6),
    ];
    super.itemMap[2] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[0], 1),
      ItemPairDTO(reg2.groupList[0], 2),
      ItemPairDTO(wea.groupList[0], 2),
    ];
    super.itemMap[3] = [
      ItemPairDTO(i_202, 27400),
      ItemPairDTO(i_104013, 28),
    ];
    super.itemMap[4] = [
      ItemPairDTO(i_202, 10000),
      ItemPairDTO(reg1.groupList[0], 5),
      ItemPairDTO(reg2.groupList[0], 8),
      ItemPairDTO(wea.groupList[1], 2),
    ];
    super.itemMap[5] = [
      ItemPairDTO(i_202, 27635),
      ItemPairDTO(i_104013, 28),
    ];
    super.itemMap[6] = [
      ItemPairDTO(i_202, 15000),
      ItemPairDTO(reg1.groupList[1], 4),
      ItemPairDTO(reg2.groupList[1], 4),
      ItemPairDTO(wea.groupList[1], 4),
    ];
    super.itemMap[7] = [
      ItemPairDTO(i_202, 40815),
      ItemPairDTO(i_104013, 41),
    ];
    super.itemMap[8] = [
      ItemPairDTO(i_202, 20000),
      ItemPairDTO(reg1.groupList[1], 6),
      ItemPairDTO(reg2.groupList[1], 8),
      ItemPairDTO(wea.groupList[2], 2),
    ];
    super.itemMap[9] = [
      ItemPairDTO(i_202, 57162),
      ItemPairDTO(i_104013, 58),
    ];
    super.itemMap[10] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(reg1.groupList[2], 4),
      ItemPairDTO(reg2.groupList[2], 6),
      ItemPairDTO(wea.groupList[2], 4),
    ];
    super.itemMap[11] = [
      ItemPairDTO(i_202, 77012),
      ItemPairDTO(i_104013, 78),
    ];
    super.itemMap[12] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(reg1.groupList[2], 8),
      ItemPairDTO(reg2.groupList[2], 12),
      ItemPairDTO(wea.groupList[3], 3),
    ];
    super.itemMap[13] = [
      ItemPairDTO(i_202, 163447),
      ItemPairDTO(i_104013, 164),
    ];
  }
}

class WeaponStar4LevelUpDTO extends BaseWeaponLevelUpDTO {
  WeaponStar4LevelUpDTO(ItemGroupDTO reg1, ItemGroupDTO reg2, ItemGroupDTO wea) {
    super.itemMap[1] = [
      ItemPairDTO(i_202, 8100),
      ItemPairDTO(i_104013, 9),
    ];
    super.itemMap[2] = [
      ItemPairDTO(i_202, 5000),
      ItemPairDTO(reg1.groupList[0], 2),
      ItemPairDTO(reg2.groupList[0], 3),
      ItemPairDTO(wea.groupList[0], 3),
    ];
    super.itemMap[3] = [
      ItemPairDTO(i_202, 41512),
      ItemPairDTO(i_104013, 42),
    ];
    super.itemMap[4] = [
      ItemPairDTO(i_202, 15000),
      ItemPairDTO(reg1.groupList[0], 8),
      ItemPairDTO(reg2.groupList[0], 12),
      ItemPairDTO(wea.groupList[1], 3),
    ];
    super.itemMap[5] = [
      ItemPairDTO(i_202, 41872),
      ItemPairDTO(i_104013, 42),
    ];
    super.itemMap[6] = [
      ItemPairDTO(i_202, 20000),
      ItemPairDTO(reg1.groupList[1], 6),
      ItemPairDTO(reg2.groupList[1], 6),
      ItemPairDTO(wea.groupList[1], 6),
    ];
    super.itemMap[7] = [
      ItemPairDTO(i_202, 61840),
      ItemPairDTO(i_104013, 62),
    ];
    super.itemMap[8] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(reg1.groupList[1], 9),
      ItemPairDTO(reg2.groupList[1], 12),
      ItemPairDTO(wea.groupList[2], 3),
    ];
    super.itemMap[9] = [
      ItemPairDTO(i_202, 86605),
      ItemPairDTO(i_104013, 87),
    ];
    super.itemMap[10] = [
      ItemPairDTO(i_202, 35000),
      ItemPairDTO(reg1.groupList[2], 6),
      ItemPairDTO(reg2.groupList[2], 9),
      ItemPairDTO(wea.groupList[2], 6),
    ];
    super.itemMap[11] = [
      ItemPairDTO(i_202, 116687),
      ItemPairDTO(i_104013, 117),
    ];
    super.itemMap[12] = [
      ItemPairDTO(i_202, 45000),
      ItemPairDTO(reg1.groupList[2], 12),
      ItemPairDTO(reg2.groupList[2], 18),
      ItemPairDTO(wea.groupList[3], 4),
    ];
    super.itemMap[13] = [
      ItemPairDTO(i_202, 247647),
      ItemPairDTO(i_104013, 248),
    ];
  }
}

class WeaponStar5LevelUpDTO extends BaseWeaponLevelUpDTO {
  WeaponStar5LevelUpDTO(ItemGroupDTO reg1, ItemGroupDTO reg2, ItemGroupDTO wea) {
    super.itemMap[1] = [
      ItemPairDTO(i_202, 12155),
      ItemPairDTO(i_104013, 13),
    ];
    super.itemMap[2] = [
      ItemPairDTO(i_202, 10000),
      ItemPairDTO(reg1.groupList[0], 3),
      ItemPairDTO(reg2.groupList[0], 5),
      ItemPairDTO(wea.groupList[0], 5),
    ];
    super.itemMap[3] = [
      ItemPairDTO(i_202, 62280),
      ItemPairDTO(i_104013, 63),
    ];
    super.itemMap[4] = [
      ItemPairDTO(i_202, 20000),
      ItemPairDTO(reg1.groupList[0], 12),
      ItemPairDTO(reg2.groupList[0], 18),
      ItemPairDTO(wea.groupList[1], 5),
    ];
    super.itemMap[5] = [
      ItemPairDTO(i_202, 62815),
      ItemPairDTO(i_104013, 63),
    ];
    super.itemMap[6] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(reg1.groupList[1], 9),
      ItemPairDTO(reg2.groupList[1], 9),
      ItemPairDTO(wea.groupList[1], 9),
    ];
    super.itemMap[7] = [
      ItemPairDTO(i_202, 92767),
      ItemPairDTO(i_104013, 93),
    ];
    super.itemMap[8] = [
      ItemPairDTO(i_202, 45000),
      ItemPairDTO(reg1.groupList[1], 14),
      ItemPairDTO(reg2.groupList[1], 18),
      ItemPairDTO(wea.groupList[2], 5),
    ];
    super.itemMap[9] = [
      ItemPairDTO(i_202, 129912),
      ItemPairDTO(i_104013, 130),
    ];
    super.itemMap[10] = [
      ItemPairDTO(i_202, 55000),
      ItemPairDTO(reg1.groupList[2], 9),
      ItemPairDTO(reg2.groupList[2], 14),
      ItemPairDTO(wea.groupList[2], 9),
    ];
    super.itemMap[11] = [
      ItemPairDTO(i_202, 175037),
      ItemPairDTO(i_104013, 176),
    ];
    super.itemMap[12] = [
      ItemPairDTO(i_202, 65000),
      ItemPairDTO(reg1.groupList[2], 18),
      ItemPairDTO(reg2.groupList[2], 27),
      ItemPairDTO(wea.groupList[3], 6),
    ];
    super.itemMap[13] = [
      ItemPairDTO(i_202, 371477),
      ItemPairDTO(i_104013, 372),
    ];
  }
}
