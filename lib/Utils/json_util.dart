import 'dart:convert';
import 'dart:io';
import 'package:katepnha/BaseData/constants.dart';
import 'package:katepnha/BaseData/global_vars.dart';
import 'package:katepnha/BaseData/item_species.dart';
import 'package:katepnha/DTO/item_dto.dart';
import 'package:katepnha/DTO/plan_dto.dart';
import 'package:katepnha/DTO/weapon_list_dto.dart';
import 'package:shared_preferences/shared_preferences.dart';

String tmp = '';

String getGlobalVarsJsonString() {
  final String res = jsonEncode(toJson());
  return res;
}

bool setGlobalVarsJsonString(String s) {
  try{
    final Map<String,dynamic> m = jsonDecode(s);

    haveNumMap = {};
    final Map<String, dynamic> haveNumMap_ = m['haveNumMap'];
    haveNumMap_.forEach((k, v) {
      haveNumMap[getItemDTO(int.parse(k))] = v;
    });

    needNumMap = {};
    final Map<String, dynamic> needNumMap_ = m['needNumMap'];
    needNumMap_.forEach((k, v) {
      needNumMap[getItemDTO(int.parse(k))] = v;
    });

    characterLevelMap = {};
    final Map<String, dynamic> characterLevelMap_ = m['characterLevelMap'];
    characterLevelMap_.forEach((k, v) {
      characterLevelMap[int.parse(k)] = {};
      v as Map<String,dynamic>;
      v.forEach((kk, vv) {
        characterLevelMap[int.parse(k)]![int.parse(kk)] = vv;
      });
    });

    characterElementFilter = m['characterElementFilter'];

    characterWeaponFilter = m['characterWeaponFilter'];

    weaponLevelMap = {};
    final Map<String,dynamic> weaponLevelMap_ = m['weaponLevelMap'];
    weaponLevelMap_.forEach((k, v) {
      weaponLevelMap[int.parse(k)] = {};
      v as Map<String,dynamic>;
      v.forEach((kk, vv) {
        weaponLevelMap[int.parse(k)]![int.parse(kk)] = vv;
      });
    });

    weaponList = [];
    for(final Map<String, dynamic> mm in m['weaponList']){
      final String thisId = mm['id'];
      final ItemDTO thisWeapon = getItemDTO(mm['weapon']);
      final int thisLowerBound = mm['lowerBound'];
      final int thisUpperBound = mm['upperBound'];
      final WeaponListDTO thisWeaponListDTO = WeaponListDTO(thisId, thisWeapon, thisLowerBound, thisUpperBound);
      weaponList.add(thisWeaponListDTO);
    }

    weaponStarFilter = m['weaponStarFilter'];

    weaponFilter = m['weaponFilter'];

    inventoryDisplay = m['inventoryDisplay'];

    planList = [];
    for(final Map<String,dynamic> mm in m['planList']){
      final String id = mm['id'];
      final ItemDTO item = getItemDTO(mm['item']);
      PlanType planType = PlanType.unknown;
      final String planType_ = mm['planType'];
      switch(planType_){
        case 'PlanType.characterLevel':planType = PlanType.characterLevel;break;
        case 'PlanType.characterTalent1':planType = PlanType.characterTalent1;break;
        case 'PlanType.characterTalent2':planType = PlanType.characterTalent2;break;
        case 'PlanType.characterTalent3':planType = PlanType.characterTalent3;break;
        case 'PlanType.weaponLevel':planType = PlanType.weaponLevel;break;
        case 'PlanType.pick':planType = PlanType.pick;break;
        default:break;
      }
      final int num = mm['num'];
      final PlanDTO thisPlanDTO = PlanDTO(id,item,planType,num);
      planList.add(thisPlanDTO);
    }

     refreshDuration = m['refreshDuration'];

     plusDuration = m['plusDuration'];

     resinNum = m['resinNum'];

     refreshTime = DateTime.parse(m['refreshTime']);

     databaseDisplay = m['databaseDisplay'];

  }
  catch(e){
    return false;
  }
  return true;
}

Future<void> saveGlobalVars() async {
  final prefs = await SharedPreferences.getInstance();
  final String newJson = getGlobalVarsJsonString();
  prefs.setString('config', newJson);
  saveGlobalVarsToFile();
}

Future<void> readGlobalVars() async{
  final prefs = await SharedPreferences.getInstance();
  final result = prefs.getString('config');
  tmp =  result ?? '';
}

Future<void> _downloadConfig() async {
  const String configAddress = '.';
  final String configString = getGlobalVarsJsonString();
  try {
    final File f = File('$configAddress/KatepиHa_config.json');
    if((await f.exists()) == false){
      f.create();
    }
    final IOSink sink = f.openWrite();
    sink.write(configString);
    sink.close();
  } catch (e) {
    return;
  }
}

void saveGlobalVarsToFile() {
  _downloadConfig();
}

void loadGlobalVarsFromFile(){
  const String configAddress = '.';
  try {
    final File f = File('$configAddress/KatepиHa_config.json');
    f.readAsString().then((String s) {
      setGlobalVarsJsonString(s);
    });
  }
  catch(e){
    return;
  }
}
