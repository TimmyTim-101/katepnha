import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/item_dto.dart';

class PlanDTO {
  String id = '';
  ItemDTO item = iNull;
  PlanType planType = PlanType.unknown;
  int num = 0;

  PlanDTO(this.id, this.item, this.planType, this.num);
}
