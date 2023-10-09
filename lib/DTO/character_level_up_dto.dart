import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_group_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';

class CharacterLevelUpDTO {
  Map<int, List<ItemPairDTO>> itemMap = {};

  CharacterLevelUpDTO(ItemDTO spec, ItemGroupDTO cry, ItemGroupDTO reg, ItemDTO? boss) {
    itemMap[1] = [
      ItemPairDTO(i_3010001, 24035),
      ItemPairDTO(i_3010004, 7),
    ];
    itemMap[2] = [
      ItemPairDTO(i_3010001, 20000),
      ItemPairDTO(spec, 3),
      ItemPairDTO(cry.groupList[0], 1),
      ItemPairDTO(reg.groupList[0], 3),
    ];
    itemMap[3] = [
      ItemPairDTO(i_3010001, 115665),
      ItemPairDTO(i_3010004, 29),
    ];
    itemMap[4] = [
      ItemPairDTO(i_3010001, 40000),
      ItemPairDTO(spec, 10),
      ItemPairDTO(cry.groupList[1], 3),
      ItemPairDTO(reg.groupList[0], 15),
    ];
    itemMap[5] = [
      ItemPairDTO(i_3010001, 115820),
      ItemPairDTO(i_3010004, 29),
    ];
    itemMap[6] = [
      ItemPairDTO(i_3010001, 60000),
      ItemPairDTO(spec, 20),
      ItemPairDTO(cry.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 12),
    ];
    itemMap[7] = [
      ItemPairDTO(i_3010001, 170825),
      ItemPairDTO(i_3010004, 43),
    ];
    itemMap[8] = [
      ItemPairDTO(i_3010001, 80000),
      ItemPairDTO(spec, 30),
      ItemPairDTO(cry.groupList[2], 3),
      ItemPairDTO(reg.groupList[1], 18),
    ];
    itemMap[9] = [
      ItemPairDTO(i_3010001, 239185),
      ItemPairDTO(i_3010004, 60),
    ];
    itemMap[10] = [
      ItemPairDTO(i_3010001, 100000),
      ItemPairDTO(spec, 45),
      ItemPairDTO(cry.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 12),
    ];
    itemMap[11] = [
      ItemPairDTO(i_3010001, 322375),
      ItemPairDTO(i_3010004, 81),
    ];
    itemMap[12] = [
      ItemPairDTO(i_3010001, 120000),
      ItemPairDTO(spec, 60),
      ItemPairDTO(cry.groupList[3], 6),
      ItemPairDTO(reg.groupList[2], 24),
    ];
    itemMap[13] = [
      ItemPairDTO(i_3010001, 684625),
      ItemPairDTO(i_3010004, 172),
    ];
    if (boss != null) {
      itemMap[4]?.add(ItemPairDTO(boss, 2));
      itemMap[6]?.add(ItemPairDTO(boss, 4));
      itemMap[8]?.add(ItemPairDTO(boss, 8));
      itemMap[10]?.add(ItemPairDTO(boss, 12));
      itemMap[12]?.add(ItemPairDTO(boss, 20));
    }
  }
}
