import 'dart:math';

import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/DTO/item_dto.dart';

int have(ItemDTO item) {
  int haveNum = 0;
  if (haveNumMap.containsKey(item)) {
    haveNum = haveNumMap[item]!;
  } else {
    haveNumMap[item] = 0;
  }
  return haveNum;
}

int need(ItemDTO item) {
  int needNum = 0;
  if (needNumMap.containsKey(item)) {
    needNum = needNumMap[item]!;
  } else {
    needNumMap[item] = 0;
  }
  return needNum;
}

// 简单计算：不考虑其他物品，只计算背包合成后是否满足
int simpleLack(ItemDTO item, int needNum) {
  final int haveNum = simpleMergeHave(item);
  return needNum - haveNum;
}

int simpleMergeHave(ItemDTO item) {
  int haveNum = have(item);
  if (mergeMap.containsKey(item)) {
    haveNum = haveNum + (simpleMergeHave(mergeMap[item]!) / 3).floor();
  }
  return haveNum;
}

// 某物品合成后剩余
int mergeLeft(ItemDTO item) {
  if (mergeMap.containsKey(item)) {
    return max(0, have(item) + (mergeLeft(mergeMap[item]!) / 3).floor() - need(item));
  } else {
    return max(0, have(item) - need(item));
  }
}

// 某物品合成后缺少
int mergeLack(ItemDTO item) {
  if (mergeMap.containsKey(item)) {
    return max(0, need(item) - have(item) - (mergeLeft(mergeMap[item]!) / 3).floor());
  } else {
    return max(0, need(item) - have(item));
  }
}

// 合成需求
int mergeDemand(ItemDTO item) {
  if (!mergeMap.containsKey(item) && !reverseMergeMap.containsKey(item)) {
    return 0;
  }
  if (!mergeMap.containsKey(item) && reverseMergeMap.containsKey(item)) {
    return 0;
  }
  if (mergeMap.containsKey(item) && !reverseMergeMap.containsKey(item)) {
    return max(0, need(item) - have(item));
  }
  return max(0, mergeDemand(reverseMergeMap[item]!) * 3 + need(item) - have(item));
}

// 某物品合成次数 = min(上游需要数, 下游产出数)
int mergeNum(ItemDTO item) {
  if (!mergeMap.containsKey(item) && !reverseMergeMap.containsKey(item)) {
    return 0;
  }
  if (!mergeMap.containsKey(item) && reverseMergeMap.containsKey(item)) {
    return 0;
  }
  if (mergeMap.containsKey(item) && !reverseMergeMap.containsKey(item)) {
    return min(mergeDemand(item), (mergeLeft(mergeMap[item]!) / 3).floor());
  }
  return min(mergeDemand(item), (mergeLeft(mergeMap[item]!) / 3).floor());
}
