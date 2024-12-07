import 'dart:async';

import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/DTO/weapon_list_dto.dart';
import 'package:katepnha/Utils/json_util.dart';

// 全局配置
String currentAccount = '默认账号'; // 当前账号
List<String> allAccounts = ['默认账号']; // 全部账号list
Map<String, dynamic> allConfig = <String, dynamic>{currentAccount: <String, dynamic>{}}; // 存储的所有账号配置，注意单账号配置更改的同时注意此数据的更改

// 单账号配置
Map<ItemDTO, int> haveNumMap = {}; // 背包数量
Map<ItemDTO, int> needNumMap = {}; // 所需数量

// 角色展示内容配置
Map<int, Map<int, int>> characterLevelMap = {}; // <角色ID, <1～8, 数据>>，一个角色8个field
int characterElementFilter = 0; // 角色元素筛选
int characterWeaponFilter = 0; // 角色武器筛选

// 武器展示内容配置
Map<int, Map<int, int>> weaponLevelMap = {};
List<WeaponListDTO> weaponList = [];
int weaponStarFilter = 0;
int weaponFilter = 0;

// 背包展示内容配置
int inventoryDisplay = 1;

// 事件展示内容
List<PlanDTO> planList = [];

// 规划展示内容配置
int refreshDuration = 10; //10
int plusDuration = 480; // 480
int resinNum = 0;
DateTime refreshTime = DateTime.now();
Timer? resinRefreshTimer;

// 数据库展示内容配置
int databaseDisplay = 1;

// 服务器时间偏移
int utcOffset = 8;

Map<String, dynamic> toJson() {
  final Map<String, dynamic> rres = <String, dynamic>{};
  final Map<String, dynamic> allConfigmap = cloneMap(allConfig);

  final Map<String, dynamic> res = <String, dynamic>{};

  final Map<String, dynamic> haveNumMap_ = <String, dynamic>{};
  haveNumMap.forEach((k, v) {
    haveNumMap_[k.vid.toString()] = v;
  });
  res['haveNumMap'] = haveNumMap_;

  final Map<String, dynamic> needNumMap_ = <String, dynamic>{};
  needNumMap.forEach((k, v) {
    needNumMap_[k.vid.toString()] = v;
  });
  res['needNumMap'] = needNumMap_;

  final Map<String, dynamic> characterLevelMap_ = <String, dynamic>{};
  characterLevelMap.forEach((k, v) {
    final Map<String, dynamic> mm = <String, dynamic>{};
    v.forEach((kk, vv) {
      mm[kk.toString()] = vv;
    });
    characterLevelMap_[k.toString()] = mm;
  });
  res['characterLevelMap'] = characterLevelMap_;

  res['characterElementFilter'] = characterElementFilter;

  res['characterWeaponFilter'] = characterWeaponFilter;

  final Map<String, dynamic> weaponLevelMap_ = <String, dynamic>{};
  weaponLevelMap.forEach((k, v) {
    final Map<String, dynamic> mm = <String, dynamic>{};
    v.forEach((kk, vv) {
      mm[kk.toString()] = vv;
    });
    weaponLevelMap_[k.toString()] = mm;
  });
  res['weaponLevelMap'] = weaponLevelMap_;

  final List<Map<String, dynamic>> weaponList_ = [];
  for (final e in weaponList) {
    final Map<String, dynamic> m = <String, dynamic>{};
    m['id'] = e.id;
    m['weapon'] = e.weapon.vid;
    m['lowerBound'] = e.lowerBound;
    m['upperBound'] = e.upperBound;
    weaponList_.add(m);
  }
  res['weaponList'] = weaponList_;

  res['weaponStarFilter'] = weaponStarFilter;

  res['weaponFilter'] = weaponFilter;

  res['inventoryDisplay'] = inventoryDisplay;

  final List<Map<String, dynamic>> planList_ = [];
  for (final e in planList) {
    final Map<String, dynamic> m = <String, dynamic>{};
    m['id'] = e.id;
    m['item'] = e.item.vid;
    m['planType'] = e.planType.toString();
    m['num'] = e.num;
    planList_.add(m);
  }
  res['planList'] = planList_;

  res['refreshDuration'] = refreshDuration;

  res['plusDuration'] = plusDuration;

  res['resinNum'] = resinNum;

  res['refreshTime'] = refreshTime.toString();

  res['databaseDisplay'] = databaseDisplay;

  res['utcOffset'] = utcOffset;

  allConfigmap[currentAccount] = res;

  rres['currentAccount'] = currentAccount;
  rres['allAccounts'] = allAccounts;
  rres['allConfig']  = allConfigmap;

  return rres;
}

void resetData(){
  haveNumMap = {}; // 背包数量
  needNumMap = {}; // 所需数量

  // 角色展示内容配置
  characterLevelMap = {}; // <角色ID, <1～8, 数据>>，一个角色8个field
  characterElementFilter = 0; // 角色元素筛选
  characterWeaponFilter = 0; // 角色武器筛选

  // 武器展示内容配置
  weaponLevelMap = {};
  weaponList = [];
  weaponStarFilter = 0;
  weaponFilter = 0;

  // 背包展示内容配置
  inventoryDisplay = 1;

  // 事件展示内容
  planList = [];

  // 规划展示内容配置
  refreshDuration = 10; //10
  plusDuration = 480; // 480
  resinNum = 0;
  refreshTime = DateTime.now();

  // 数据库展示内容配置
  databaseDisplay = 1;

  // 服务器时间偏移
  utcOffset = 8;
}
