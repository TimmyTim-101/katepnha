import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';

class ItemDTO {
  int id = 0;
  String name = '';
  int star = 0;
  ItemType itemType = ItemType.unknown;
  String imageAddress = '';

  ItemDTO(this.id, this.name, this.star, this.itemType, this.imageAddress);

  Widget getItemInfoWidget() {
    return Container();
  }
}
