import 'package:flutter/material.dart';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/custom_style.dart';
import 'package:katepnha/DTO/item_dto.dart';

class MaterialDTO extends ItemDTO {
  GMaterialType materialType = GMaterialType.unknown;

  MaterialDTO(super.id, super.name, super.star, super.itemType, super.imageAddress, this.materialType);

  @override
  Widget getItemInfoWidget() {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 5, 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      height: 159,
      width: 110,
      child: Column(
        children: [
          Stack(
            children: [
              Positioned(
                child: Image(
                  image: AssetImage(backgroundMap[star]!),
                  width: 110,
                  height: 110,
                ),
              ),
              Positioned(
                child: Image(
                  image: AssetImage(imageAddress),
                  width: 110,
                  height: 110,
                ),
              ),
            ],
          ),
          Container(
            height: 15,
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(starMap[star]!),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: customText(name, Colors.white, 12),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: customText('id:$id', Colors.white30, 10),
          ),
        ],
      ),
    );
  }
}
