import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';

class ItemDTO {
  int vid = 0; // 虚拟ID，用作应用内数据唯一标识
  int rid = 0; // 游戏中实际ID，仅作为展示用
  String name = '';
  int star = 0;
  ItemType itemType = ItemType.unknown;
  String imageAddress = '';

  ItemDTO(this.vid, this.rid, this.name, this.star, this.itemType, this.imageAddress);

  Widget getItemInfoWidget() {
    return Container();
  }
}
