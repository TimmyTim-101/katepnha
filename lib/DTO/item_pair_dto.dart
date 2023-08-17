import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_group_dto.dart';

class ItemPairDTO {
  ItemDTO itemId = iNull;
  double num = 0;

  ItemPairDTO(this.itemId, this.num);

  static List<ItemPairDTO> pairList(ItemGroupDTO g, List<double> l) {
    final List<ItemPairDTO> res = [];
    for (int i = l.length - 1; i >= 0; i--) {
      res.add(ItemPairDTO(g.groupList[i], l[i]));
    }
    return res;
  }

  static List<ItemPairDTO> pairListExtra(List<List<ItemPairDTO>> l) {
    final List<ItemPairDTO> res = [];
    for(int i=0;i<l.length;i++){
      res.addAll(l[i]);
    }
    return res;
  }
}
