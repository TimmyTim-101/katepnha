import 'package:katepnha/DTO/item_dto.dart';

class ItemGroupDTO {
  int groupBeginId = 0;
  List<ItemDTO> groupList = [];

  ItemGroupDTO(List<ItemDTO> list) {
    groupBeginId = list[0].vid;
    groupList = list;
  }
}
