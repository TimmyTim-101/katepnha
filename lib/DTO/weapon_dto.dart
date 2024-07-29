import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/weapon_level_up_dto.dart';

class WeaponDTO extends ItemDTO {
  WeaponType weaponType = WeaponType.unknown;
  BaseWeaponLevelUpDTO? levelUpDTO;

  WeaponDTO(super.vid, super.rid, super.name, super.star, super.itemType, super.imageAddress, this.weaponType, BaseWeaponLevelUpDTO weaponLevelUpDTO) {
    levelUpDTO = weaponLevelUpDTO;
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
    if (thisLevelUpTotalItemList.length == 12) {
      final List<ItemDTO> newList = [
        thisLevelUpTotalItemList[0],
        thisLevelUpTotalItemList[2],
        thisLevelUpTotalItemList[6],
        thisLevelUpTotalItemList[9],
        thisLevelUpTotalItemList[1],
        thisLevelUpTotalItemList[3],
        thisLevelUpTotalItemList[7],
        thisLevelUpTotalItemList[10],
        thisLevelUpTotalItemList[4],
        thisLevelUpTotalItemList[5],
        thisLevelUpTotalItemList[8],
        thisLevelUpTotalItemList[11],
      ];
      thisLevelUpTotalItemList = newList;
    } else if (thisLevelUpTotalItemList.length == 9) {
      final List<ItemDTO> newList = [
        thisLevelUpTotalItemList[0],
        thisLevelUpTotalItemList[1],
        thisLevelUpTotalItemList[2],
        thisLevelUpTotalItemList[6],
        thisLevelUpTotalItemList[3],
        thisLevelUpTotalItemList[7],
        thisLevelUpTotalItemList[4],
        thisLevelUpTotalItemList[5],
        thisLevelUpTotalItemList[8],
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
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      width: 172,
      height: 362,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Stack(
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
                    image: AssetImage(weaponPictureAddress[weaponType]!),
                    width: 43,
                    height: 43,
                  ),
                ),
              ],
            ),
          ),
          Image(
            image: AssetImage(starMap[star]!),
            height: 20,
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: customText(name),
            ),
          ),
          Container(
            height: 10,
            alignment: Alignment.center,
            child: customText(rid == 0 ? '-' : 'id:$rid', Colors.white30, 10),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              border: Border.all(color: Colors.white30),
            ),
            width: 160,
            height: 120,
            padding: const EdgeInsets.all(5),
            child: Wrap(
              children: thisLevelUpList,
            ),
          ),
        ],
      ),
    );
  }
}
