import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/character_level_up_dto.dart';
import 'package:katepnha/DTO/character_talent_level_up_dto.dart';
import 'package:katepnha/DTO/item_group_dto.dart';

class CharacterDTO extends ItemDTO {
  ElementType elementType = ElementType.unknown;
  WeaponType weaponType = WeaponType.unknown;
  CharacterLevelUpDTO? levelUpDTO;
  BaseTalentLevelUpDTO? talentLevelUpDTO;
  int birthday = 0;

  CharacterDTO(int vid, int rid, String name, int star, this.birthday, ItemType itemType, String imageAddress, this.elementType, this.weaponType, ItemDTO spec, ItemGroupDTO cry, ItemGroupDTO reg, ItemDTO? boss, BaseTalentLevelUpDTO this.talentLevelUpDTO) : super(vid, rid, name, star, itemType, imageAddress) {
    levelUpDTO = CharacterLevelUpDTO(spec, cry, reg, boss);
  }

  @override
  Widget getItemInfoWidget() {
    final List<Widget> thisLevelUpList = [];
    List<ItemDTO> thisLevelUpTotalItemList = [];
    final List<int> thisLevelUpTotalItemIdList = [];
    levelUpDTO?.itemMap.forEach((key, value) {
      for (final element in value) {
        final ItemDTO thisItem = element.itemId;
        if (!thisLevelUpTotalItemIdList.contains(thisItem.vid)) {
          thisLevelUpTotalItemList.add(thisItem);
          thisLevelUpTotalItemIdList.add(thisItem.vid);
        }
      }
    });
    talentLevelUpDTO?.itemMap1.forEach((key, value) {
      for (final element in value) {
        final ItemDTO thisItem = element.itemId;
        if (!thisLevelUpTotalItemIdList.contains(thisItem.vid)) {
          thisLevelUpTotalItemList.add(thisItem);
          thisLevelUpTotalItemIdList.add(thisItem.vid);
        }
      }
    });
    talentLevelUpDTO?.itemMap2.forEach((key, value) {
      for (final element in value) {
        final ItemDTO thisItem = element.itemId;
        if (!thisLevelUpTotalItemIdList.contains(thisItem.vid)) {
          thisLevelUpTotalItemList.add(thisItem);
          thisLevelUpTotalItemIdList.add(thisItem.vid);
        }
      }
    });
    talentLevelUpDTO?.itemMap3.forEach((key, value) {
      for (final element in value) {
        final ItemDTO thisItem = element.itemId;
        if (!thisLevelUpTotalItemIdList.contains(thisItem.vid)) {
          thisLevelUpTotalItemList.add(thisItem);
          thisLevelUpTotalItemIdList.add(thisItem.vid);
        }
      }
    });
    if (thisLevelUpTotalItemList.length == 16) {
      final List<ItemDTO> newList = [
        thisLevelUpTotalItemList[0],
        thisLevelUpTotalItemList[1],
        thisLevelUpTotalItemList[6],
        thisLevelUpTotalItemList[14],
        thisLevelUpTotalItemList[4],
        thisLevelUpTotalItemList[7],
        thisLevelUpTotalItemList[9],
        thisLevelUpTotalItemList[2],
        thisLevelUpTotalItemList[11],
        thisLevelUpTotalItemList[12],
        thisLevelUpTotalItemList[13],
        thisLevelUpTotalItemList[15],
        thisLevelUpTotalItemList[3],
        thisLevelUpTotalItemList[5],
        thisLevelUpTotalItemList[8],
        thisLevelUpTotalItemList[10],
      ];
      thisLevelUpTotalItemList = newList;
    }
    for (final element in thisLevelUpTotalItemList) {
      thisLevelUpList.add(
        Container(
          margin: const EdgeInsets.all(2),
          child: Tooltip(
            message: element.name,
            child: Stack(
              children: [
                Positioned(
                  child: Image(
                    image: AssetImage(backgroundMap[element.star]!),
                    width: 33,
                    height: 33,
                  ),
                ),
                Positioned(
                  child: Image(
                    image: AssetImage(element.imageAddress),
                    width: 33,
                    height: 33,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    final Widget finalListWidget = thisLevelUpTotalItemList.length == 16
        ? Wrap(
            children: thisLevelUpList,
          )
        : GridView.count(
            crossAxisCount: 4,
            children: thisLevelUpList,
          );
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      height: 399,
      width: 172,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Image(
                  image: AssetImage(backgroundMap[star]!),
                  width: 170,
                  height: 170,
                ),
              ),
              Positioned(
                child: Image(
                  image: AssetImage(imageAddress),
                  width: 170,
                  height: 170,
                ),
              ),
              Positioned(
                child: Image(
                  image: AssetImage(elementPictureAddress[elementType]!),
                  width: 43,
                  height: 43,
                ),
              ),
            ],
          ),
          Image(
            image: AssetImage(starMap[star]!),
            height: 20,
          ),
          Container(
            width: 120,
            height: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Column(
              children: [
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(weaponPictureAddress[weaponType]!),
                          width: 25,
                          height: 25,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: customText(name),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 10,
                  alignment: Alignment.center,
                  child: customText(rid == 0 ? '-' : 'id:$rid', Colors.white30, 10),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white30),
            ),
            width: 160,
            height: 160,
            padding: const EdgeInsets.all(5),
            child: finalListWidget,
          ),
        ],
      ),
    );
  }
}
