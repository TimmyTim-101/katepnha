import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_dto.dart';

class WeaponListDTO {
  String id = '';
  ItemDTO weapon = iNull;
  int lowerBound = 0;
  int upperBound = 0;

  WeaponListDTO(this.id, this.weapon, this.lowerBound, this.upperBound);
}
