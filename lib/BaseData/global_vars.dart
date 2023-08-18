import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/DTO/weapon_list_dto.dart';

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

// 数据库展示内容配置
int databaseDisplay = 1;

Map<String, dynamic> toJson() {
  final Map<String, dynamic> res = <String, dynamic>{};

  final Map<String, dynamic> haveNumMap_ = <String, dynamic>{};
  haveNumMap.forEach((k, v) {
    haveNumMap_[k.id.toString()] = v;
  });
  res['haveNumMap'] = haveNumMap_;

  final Map<String, dynamic> needNumMap_ = <String, dynamic>{};
  needNumMap.forEach((k, v) {
    needNumMap_[k.id.toString()] = v;
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
    final Map<String,dynamic> m = <String, dynamic>{};
    m['id'] = e.id;
    m['weapon'] = e.weapon.id;
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
    final Map<String,dynamic> m = <String, dynamic>{};
    m['id'] = e.id;
    m['item'] = e.item.id;
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
  return res;
}
