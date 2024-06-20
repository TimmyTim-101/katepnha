import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_pair_dto.dart';
import 'package:katepnha/Utils/number_convert.dart';

class DungeonDTO {
  int vid = 0;
  String name = '';
  String subName = '';
  DungeonType dungeonType = DungeonType.unknown;
  List<ItemPairDTO> dropItemMap = [];
  List<int> time = [];
  int cost = 0;
  String imageAddress = '';

  DungeonDTO(this.vid, this.name, this.subName, this.dungeonType, this.dropItemMap, this.time, this.cost);
  DungeonDTO.withImage(this.vid, this.name, this.subName, this.dungeonType, this.dropItemMap, this.time, this.cost, this.imageAddress);

  Widget getItemInfoWidget() {
    String timeString = '';
    if (time.length == 7) {
      timeString = '-';
    } else {
      for (final d in time) {
        final StringBuffer sb = StringBuffer();
        sb.write(timeString);
        sb.write('周${weekNameText[d]!} / ');
        timeString = sb.toString();
      }
      timeString = timeString.substring(0, timeString.length - 2);
    }
    final List<Widget> costWidget = [];
    if (cost == 0) {
      costWidget.add(
        Container(
          alignment: Alignment.center,
          child: customText('不消耗'),
        ),
      );
    } else {
      costWidget.add(
        Container(
          alignment: Alignment.center,
          child: customText(cost.toString()),
        ),
      );
    }
    costWidget.add(
      const Image(
        image: AssetImage(resinImageAddress),
        height: 20,
        width: 20,
      ),
    );
    final int rowNum = (dropItemMap.length / 4).ceil();
    final List<Widget> gridViewList = [];
    for (final pair in dropItemMap) {
      gridViewList.add(
        Container(
          margin: const EdgeInsets.all(2),
          child: Column(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: Tooltip(
                  message: pair.itemId.name,
                  child: Stack(
                    children: [
                      Positioned(
                        child: Image(
                          image: AssetImage(backgroundMap[pair.itemId.star]!),
                          height: 50,
                          width: 50,
                        ),
                      ),
                      Positioned(
                        child: Image(
                          image: AssetImage(pair.itemId.imageAddress),
                          height: 50,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 12,
                width: 50,
                child: customText(convertNumberToString(pair.num), Colors.white, 12),
              ),
            ],
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      width: 230,
      height: 131 + 66.0 * rowNum,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            alignment: Alignment.center,
            height: 25,
            child: customText(name),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            alignment: Alignment.center,
            height: 15,
            child: customText(subName, Colors.white, 15),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white30),
            ),
            height: 4 + 66.0 * rowNum,
            width: 218,
            child: Wrap(
              children: gridViewList,
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            height: 25,
            alignment: Alignment.center,
            child: customText(timeString),
          ),
          Container(
            height: 25,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: costWidget,
            ),
          ),
        ],
      ),
    );
  }
}
