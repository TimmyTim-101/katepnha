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
