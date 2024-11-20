import 'package:katepnha/BaseData/items.dart';
import 'package:katepnha/DTO/dungeon_dto.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/item_group_dto.dart';

List<ItemDTO> allCharacter = [
  i_1010090,i_1010089,i_1010088,i_1010087,i_1010086,i_1010085,i_1010084,i_1010083,i_1010082,i_1010081,i_1010080,i_1010079,i_1010078,i_1010077,i_1010076,i_1010075,i_1010074,i_1010073,i_1010071,i_1010072,i_1010070,i_1010069,i_1010068,i_1010046,i_1010067,i_1010066,i_1010065,i_1010064,i_1010063,i_1010062,i_1010060,i_1010061,i_1010059,i_1010058,i_1010055,i_1010056,i_1010057,i_1010053,i_1010054,i_1010052,i_1010044,i_1010050,i_1010045,i_1010051,i_1010043,i_1010048,i_1010049,i_1010042,i_1010040,i_1010035,i_1010039,i_1010037,i_1010041,i_1010047,i_1010034,i_1010038,i_1010001,i_1010032,i_1010036,i_1010033,i_1010030,i_1010031,i_1010013,i_1010023,i_1010024,i_1010016,i_1010029,i_1010019,i_1010025,i_1010015,i_1010009,i_1010027,i_1010026,i_1010021,i_1010006,i_1010002,i_1010028,i_1010022,i_1010020,i_1010018,i_1010017,i_1010014,i_1010012,i_1010011,i_1010010,i_1010007,i_1010004,i_1010003,i_1010005,i_1010008,i_1020001,i_1020002,i_1020003,i_1020004,i_1020005,i_1030001,i_1030002,i_1030003,i_1030004,i_1030005,
];
List<ItemDTO> allWeapon = [
  i_2010101,i_2010201,i_2010301,i_2010302,i_2010303,i_2010304,i_2010305,i_2010306,i_2010401,i_2010402,i_2010403,i_2010404,i_2010405,i_2010406,i_2010407,i_2010408,i_2010409,i_2010410,i_2010411,i_2010412,i_2010413,i_2010414,i_2010415,i_2010416,i_2010417,i_2010418,i_2010419,i_2010420,i_2010421,i_2010422,i_2010423,i_2010424,i_2010425,i_2010426,i_2010501,i_2010502,i_2010503,i_2010504,i_2010505,i_2010506,i_2010507,i_2010508,i_2010509,i_2010510,i_2010511,i_2010512,i_2010513,
  i_2020101,i_2020201,i_2020301,i_2020302,i_2020303,i_2020304,i_2020305,i_2020401,i_2020402,i_2020403,i_2020404,i_2020405,i_2020406,i_2020407,i_2020408,i_2020409,i_2020410,i_2020411,i_2020412,i_2020413,i_2020414,i_2020415,i_2020416,i_2020417,i_2020418,i_2020419,i_2020420,i_2020421,i_2020422,i_2020423,i_2020501,i_2020502,i_2020503,i_2020504,i_2020505,i_2020506,i_2020507,i_2020508,
  i_2030101,i_2030201,i_2030301,i_2030302,i_2030303,i_2030401,i_2030402,i_2030403,i_2030404,i_2030405,i_2030406,i_2030407,i_2030408,i_2030409,i_2030410,i_2030411,i_2030412,i_2030413,i_2030414,i_2030415,i_2030416,i_2030417,i_2030418,i_2030419,i_2030420,i_2030501,i_2030502,i_2030503,i_2030504,i_2030505,i_2030506,i_2030507,i_2030508,i_2030509,
  i_2040101,i_2040201,i_2040301,i_2040302,i_2040303,i_2040304,i_2040305,i_2040401,i_2040402,i_2040403,i_2040404,i_2040405,i_2040406,i_2040407,i_2040408,i_2040409,i_2040410,i_2040411,i_2040412,i_2040413,i_2040414,i_2040415,i_2040416,i_2040417,i_2040418,i_2040419,i_2040420,i_2040421,i_2040422,i_2040501,i_2040502,i_2040503,i_2040504,i_2040505,i_2040506,i_2040507,i_2040508,i_2040509,i_2040510,i_2040511,i_2040512,
  i_2050101,i_2050201,i_2050301,i_2050302,i_2050303,i_2050304,i_2050305,i_2050401,i_2050402,i_2050403,i_2050404,i_2050405,i_2050406,i_2050407,i_2050408,i_2050409,i_2050410,i_2050411,i_2050412,i_2050413,i_2050414,i_2050415,i_2050416,i_2050417,i_2050418,i_2050419,i_2050420,i_2050421,i_2050422,i_2050423,i_2050424,i_2050425,i_2050501,i_2050502,i_2050503,i_2050504,i_2050505,i_2050506,i_2050507,i_2050508,i_2050509,i_2050510,
];
List<ItemDTO> allMaterial = [
  // 特殊材料
  i_3010001,i_3010004,i_3010003,i_3010002,i_3010007,i_3010006,i_3010005,i_3010008,
  // 角色与武器培养素材 - 234
  i_3020015,i_3020014,i_3020013,i_3020021,i_3020020,i_3020019,i_3020024,i_3020023,i_3020022,i_3020027,i_3020026,i_3020025,i_3020030,i_3020029,i_3020028,i_3020042,i_3020041,i_3020040,i_3020048,i_3020047,i_3020046,i_3020051,i_3020050,i_3020049,i_3020057,i_3020056,i_3020055,i_3020018,i_3020017,i_3020016,i_3020063,i_3020062,i_3020061,i_3020069,i_3020068,i_3020067,i_3020072,i_3020071,i_3020070,i_3020075,i_3020074,i_3020073,i_3020078,i_3020077,i_3020076,i_3020087,i_3020086,i_3020085,i_3020090,i_3020089,i_3020088,i_3020093,i_3020092,i_3020091,i_3020096,i_3020095,i_3020094,i_3020099,i_3020098,i_3020097,i_3020108,i_3020107,i_3020106,i_3020111,i_3020110,i_3020109,i_3020114,i_3020113,i_3020112,i_3020117,i_3020116,i_3020115,
  // 角色与武器培养素材 - 123
  i_3020003,i_3020002,i_3020001,i_3020006,i_3020005,i_3020004,i_3020009,i_3020008,i_3020007,i_3020012,i_3020011,i_3020010,i_3020033,i_3020032,i_3020031,i_3020036,i_3020035,i_3020034,i_3020039,i_3020038,i_3020037,i_3020045,i_3020044,i_3020043,i_3020054,i_3020053,i_3020052,i_3020060,i_3020059,i_3020058,i_3020066,i_3020065,i_3020064,i_3020081,i_3020080,i_3020079,i_3020084,i_3020083,i_3020082,i_3020102,i_3020101,i_3020100,i_3020105,i_3020104,i_3020103,
  // 角色培养素材-周本
  i_3030001,i_3030002,i_3030003,i_3030004,i_3030005,i_3030006,i_3030007,i_3030008,i_3030009,i_3030010,i_3030011,i_3030012,i_3030013,i_3030014,i_3030015,i_3030016,i_3030017,i_3030018,i_3030019,i_3030020,i_3030021,i_3030022,i_3030023,i_3030024,i_3030025,i_3030026,i_3030027,i_3030028,i_3030029,i_3030030,
  // 角色培养素材-BOSS
  i_3040001,i_3040002,i_3040003,i_3040004,i_3040005,i_3040006,i_3040007,i_3040008,i_3040009,i_3040010,i_3040011,i_3040012,i_3040013,i_3040014,i_3040015,i_3040016,i_3040017,i_3040018,i_3040019,i_3040020,i_3040021,i_3040022,i_3040023,i_3040024,i_3040025,i_3040026,i_3040027,i_3040028,i_3040029,i_3040030,i_3040031,i_3040033,i_3040032,i_3040034,i_3040035,
  // 角色突破素材
  i_3050004,i_3050003,i_3050002,i_3050001,i_3050008,i_3050007,i_3050006,i_3050005,i_3050012,i_3050011,i_3050010,i_3050009,i_3050016,i_3050015,i_3050014,i_3050013,i_3050020,i_3050019,i_3050018,i_3050017,i_3050024,i_3050023,i_3050022,i_3050021,i_3050028,i_3050027,i_3050026,i_3050025,i_3050032,i_3050031,i_3050030,i_3050029,
  // 角色天赋素材
  i_3060003,i_3060002,i_3060001,i_3060006,i_3060005,i_3060004,i_3060009,i_3060008,i_3060007,i_3060012,i_3060011,i_3060010,i_3060015,i_3060014,i_3060013,i_3060018,i_3060017,i_3060016,i_3060022,i_3060021,i_3060020,i_3060025,i_3060024,i_3060023,i_3060028,i_3060027,i_3060026,i_3060031,i_3060030,i_3060029,i_3060034,i_3060033,i_3060032,i_3060037,i_3060036,i_3060035,i_3060040,i_3060039,i_3060038,i_3060043,i_3060042,i_3060041,i_3060046,i_3060045,i_3060044,i_3060049,i_3060048,i_3060047,i_3060052,i_3060051,i_3060050,i_3060055,i_3060054,i_3060053,i_3060019,
  // 武器突破素材
  i_3070004,i_3070003,i_3070002,i_3070001,i_3070008,i_3070007,i_3070006,i_3070005,i_3070012,i_3070011,i_3070010,i_3070009,i_3070016,i_3070015,i_3070014,i_3070013,i_3070020,i_3070019,i_3070018,i_3070017,i_3070024,i_3070023,i_3070022,i_3070021,i_3070028,i_3070027,i_3070026,i_3070025,i_3070032,i_3070031,i_3070030,i_3070029,i_3070036,i_3070035,i_3070034,i_3070033,i_3070040,i_3070039,i_3070038,i_3070037,i_3070044,i_3070043,i_3070042,i_3070041,i_3070048,i_3070047,i_3070046,i_3070045,i_3070052,i_3070051,i_3070050,i_3070049,i_3070056,i_3070055,i_3070054,i_3070053,i_3070060,i_3070059,i_3070058,i_3070057,i_3070064,i_3070063,i_3070062,i_3070061,i_3070068,i_3070067,i_3070066,i_3070065,i_3070072,i_3070071,i_3070070,i_3070069,
  // 各地特产
  i_3080001,i_3080002,i_3080003,i_3080004,i_3080005,i_3080006,i_3080007,i_3080008,i_3080009,i_3080010,i_3080011,i_3080012,i_3080013,i_3080014,i_3080015,i_3080016,i_3080043,i_3080017,i_3080018,i_3080019,i_3080020,i_3080021,i_3080022,i_3080023,i_3080024,i_3080025,i_3080026,i_3080027,i_3080028,i_3080029,i_3080030,i_3080031,i_3080032,i_3080033,i_3080034,i_3080035,i_3080036,i_3080037,i_3080038,i_3080039,i_3080041,i_3080040,i_3080042,i_3080044,i_3080045,i_3080046,i_3080047,i_3080048,i_3080049,
];
List<ItemGroupDTO> allGroup = [
  g_3020001,g_3020004,g_3020007,g_3020010,g_3020013,g_3020016,g_3020019,g_3020022,g_3020025,g_3020028,g_3020031,g_3020034,g_3020037,g_3020040,g_3020043,g_3020046,g_3020049,g_3020052,g_3020055,g_3020058,g_3020061,g_3020064,g_3020067,g_3020070,g_3020073,g_3020076,g_3020079,g_3020082,g_3020085,g_3020088,g_3020091,g_3020094,g_3020097,g_3020100,g_3020103,g_3020106,g_3020109,g_3020112,
  g_3050001,g_3050005,g_3050009,g_3050013,g_3050017,g_3050021,g_3050025,g_3050029,g_3060001,g_3060004,g_3060007,g_3060010,g_3060013,g_3060016,g_3060020,g_3060023,g_3060026,g_3060029,g_3060032,g_3060035,g_3060038,g_3060041,g_3060044,g_3060047,g_3060050,g_3060053,
  g_3070001,g_3070005,g_3070009,g_3070013,g_3070017,g_3070021,g_3070025,g_3070029,g_3070033,g_3070037,g_3070041,g_3070045,g_3070049,g_3070053,g_3070057,g_3070061,g_3070065,g_3070069,
];
List<DungeonDTO> allDungeon = [
  // 特产采集
  i_4010001,i_4010002,i_4010003,i_4010004,i_4010005,i_4010006,
  // 怪物掉落
  i_4020001,i_4020002,i_4020003,i_4020004,i_4020005,i_4020006,i_4020007,i_4020008,i_4020009,i_4020010,i_4020011,i_4020012,i_4020013,i_4020014,i_4020015,i_4020016,i_4020017,i_4020018,i_4020019,i_4020020,i_4020021,i_4020022,i_4020023,i_4020024,i_4020025,i_4020026,i_4020027,i_4020028,i_4020029,i_4020030,i_4020031,i_4020032,i_4020033,i_4020034,i_4020035,i_4020036,i_4020037,i_4020038,i_4020039,
  // 地脉花
  i_4030001, i_4030002,
  // 天赋书
  i_4040001,i_4040002,i_4040003,i_4040004,i_4040005,i_4040006,i_4040007,i_4040008,i_4040009,i_4040010,i_4040011,i_4040012,i_4040013,i_4040014,i_4040015,i_4040016,i_4040017,i_4040018,
  // 武器突破
  i_4050001,i_4050002,i_4050003,i_4050004,i_4050005,i_4050006,i_4050007,i_4050008,i_4050009,i_4050010,i_4050011,i_4050012,i_4050013,i_4050014,i_4050015,i_4050016,i_4050017,i_4050018,
  // BOSS
  i_4060001,i_4060002,i_4060003,i_4060004,i_4060005,i_4060007,i_4060006,i_4060008,i_4060009,i_4060010,i_4060011,i_4060012,i_4060013,i_4060014,i_4060015,i_4060016,i_4060017,i_4060018,i_4060019,i_4060020,i_4060021,i_4060022,i_4060023,i_4060024,i_4060025,i_4060026,i_4060027,i_4060028,i_4060029,i_4060030,i_4060031,i_4060032,i_4060033,i_4060034,i_4060035,
  // 周本
  i_4070001,i_4070002,i_4070003,i_4070004,i_4070005,i_4070006,i_4070007,i_4070008,i_4070009,i_4070010,
];
Map<ItemDTO, ItemDTO> mergeMap = {};
Map<ItemDTO, ItemDTO> reverseMergeMap = {};
Map<int, Set<ItemDTO>> birthdayCharacterMap = {};

ItemDTO getItemDTO(int id){
  for (final e in allCharacter) {
    if(e.vid == id) return e;
  }
  for(final e in allWeapon){
    if(e.vid == id) return e;
  }
  for(final e in allMaterial){
    if(e.vid == id) return e;
  }
  return iNull;
}
