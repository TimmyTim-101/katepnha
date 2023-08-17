import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_group_dto.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';

class BaseTalentLevelUpDTO {
  Map<int, List<ItemPairDTO>> itemMap1 = {};
  Map<int, List<ItemPairDTO>> itemMap2 = {};
  Map<int, List<ItemPairDTO>> itemMap3 = {};

  BaseTalentLevelUpDTO();
}

class CharacterTalentLevelUpDTO extends BaseTalentLevelUpDTO {
  CharacterTalentLevelUpDTO(ItemGroupDTO book, ItemGroupDTO reg, ItemDTO boss) {
    super.itemMap1[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(book.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap1[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(book.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap1[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(book.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap1[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(book.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap1[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(book.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap1[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(book.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(book.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(book.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap1[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(book.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap2[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(book.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap2[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(book.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap2[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(book.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap2[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(book.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap2[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(book.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap2[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(book.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap2[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(book.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap2[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(book.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap2[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(book.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap3[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(book.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap3[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(book.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap3[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(book.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap3[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(book.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap3[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(book.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap3[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(book.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap3[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(book.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap3[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(book.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap3[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(book.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
  }
}

// 旅行者天赋
class TravellerTalentLevelUpDTO extends BaseTalentLevelUpDTO {
  TravellerTalentLevelUpDTO(ItemGroupDTO reg, ItemDTO boss, ItemGroupDTO b1, ItemGroupDTO b2, ItemGroupDTO b3) {
    super.itemMap1[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap1[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap1[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap1[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap1[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap1[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap1[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap2[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap2[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap2[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap2[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap2[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap2[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap2[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap2[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap2[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap3[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap3[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap3[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap3[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap3[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap3[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap3[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap3[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap3[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
  }
}

// 岩旅行者天赋
class TravellerGeoTalentLevelUpDTO extends BaseTalentLevelUpDTO {
  TravellerGeoTalentLevelUpDTO(ItemGroupDTO reg, ItemDTO boss, ItemGroupDTO b1, ItemGroupDTO b2, ItemGroupDTO b3, ItemGroupDTO reg_, ItemDTO boss_, ItemGroupDTO b1_, ItemGroupDTO b2_, ItemGroupDTO b3_) {
    super.itemMap1[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1.groupList[0], 3),
      ItemPairDTO(reg.groupList[0], 6),
    ];
    super.itemMap1[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2.groupList[1], 2),
      ItemPairDTO(reg.groupList[1], 3),
    ];
    super.itemMap1[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3.groupList[1], 4),
      ItemPairDTO(reg.groupList[1], 4),
    ];
    super.itemMap1[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1.groupList[1], 6),
      ItemPairDTO(reg.groupList[1], 6),
    ];
    super.itemMap1[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2.groupList[1], 9),
      ItemPairDTO(reg.groupList[1], 9),
    ];
    super.itemMap1[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3.groupList[2], 4),
      ItemPairDTO(reg.groupList[2], 4),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1.groupList[2], 6),
      ItemPairDTO(reg.groupList[2], 6),
      ItemPairDTO(boss, 1),
    ];
    super.itemMap1[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2.groupList[2], 12),
      ItemPairDTO(reg.groupList[2], 9),
      ItemPairDTO(boss, 2),
    ];
    super.itemMap1[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3.groupList[2], 16),
      ItemPairDTO(reg.groupList[2], 12),
      ItemPairDTO(boss, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap2[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1_.groupList[0], 3),
      ItemPairDTO(reg_.groupList[0], 6),
    ];
    super.itemMap2[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2_.groupList[1], 2),
      ItemPairDTO(reg_.groupList[1], 3),
    ];
    super.itemMap2[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3_.groupList[1], 4),
      ItemPairDTO(reg_.groupList[1], 4),
    ];
    super.itemMap2[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1_.groupList[1], 6),
      ItemPairDTO(reg_.groupList[1], 6),
    ];
    super.itemMap2[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2_.groupList[1], 9),
      ItemPairDTO(reg_.groupList[1], 9),
    ];
    super.itemMap2[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3_.groupList[2], 4),
      ItemPairDTO(reg_.groupList[2], 4),
      ItemPairDTO(boss_, 1),
    ];
    super.itemMap2[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1_.groupList[2], 6),
      ItemPairDTO(reg_.groupList[2], 6),
      ItemPairDTO(boss_, 1),
    ];
    super.itemMap2[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2_.groupList[2], 12),
      ItemPairDTO(reg_.groupList[2], 9),
      ItemPairDTO(boss_, 2),
    ];
    super.itemMap2[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3_.groupList[2], 16),
      ItemPairDTO(reg_.groupList[2], 12),
      ItemPairDTO(boss_, 2),
      ItemPairDTO(i_104319, 1),
    ];
    super.itemMap3[1] = [
      ItemPairDTO(i_202, 12500),
      ItemPairDTO(b1_.groupList[0], 3),
      ItemPairDTO(reg_.groupList[0], 6),
    ];
    super.itemMap3[2] = [
      ItemPairDTO(i_202, 17500),
      ItemPairDTO(b2_.groupList[1], 2),
      ItemPairDTO(reg_.groupList[1], 3),
    ];
    super.itemMap3[3] = [
      ItemPairDTO(i_202, 25000),
      ItemPairDTO(b3_.groupList[1], 4),
      ItemPairDTO(reg_.groupList[1], 4),
    ];
    super.itemMap3[4] = [
      ItemPairDTO(i_202, 30000),
      ItemPairDTO(b1_.groupList[1], 6),
      ItemPairDTO(reg_.groupList[1], 6),
    ];
    super.itemMap3[5] = [
      ItemPairDTO(i_202, 37500),
      ItemPairDTO(b2_.groupList[1], 9),
      ItemPairDTO(reg_.groupList[1], 9),
    ];
    super.itemMap3[6] = [
      ItemPairDTO(i_202, 120000),
      ItemPairDTO(b3_.groupList[2], 4),
      ItemPairDTO(reg_.groupList[2], 4),
      ItemPairDTO(boss_, 1),
    ];
    super.itemMap3[7] = [
      ItemPairDTO(i_202, 260000),
      ItemPairDTO(b1_.groupList[2], 6),
      ItemPairDTO(reg_.groupList[2], 6),
      ItemPairDTO(boss_, 1),
    ];
    super.itemMap3[8] = [
      ItemPairDTO(i_202, 450000),
      ItemPairDTO(b2_.groupList[2], 12),
      ItemPairDTO(reg_.groupList[2], 9),
      ItemPairDTO(boss_, 2),
    ];
    super.itemMap3[9] = [
      ItemPairDTO(i_202, 700000),
      ItemPairDTO(b3_.groupList[2], 16),
      ItemPairDTO(reg_.groupList[2], 12),
      ItemPairDTO(boss_, 2),
      ItemPairDTO(i_104319, 1),
    ];
  }
}
