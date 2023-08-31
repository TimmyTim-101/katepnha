import 'package:katepnha/BaseData/global_vars.dart';

void resinRefresh(){
  final DateTime lastRefreshTime = refreshTime;
  final DateTime now = DateTime.now();
  if(resinNum >= 160){
    // 超过160的部分不再累计树脂，直接更新上次更新时间
    refreshTime = now;
  }else{
    // 没超过的话看下时间差，计算下生成树脂数
    final int diffSeconds = now.difference(lastRefreshTime).inSeconds;
    if(diffSeconds >= plusDuration){
      // 说明有新增树脂
      final int newResinNum = (1.0 * diffSeconds/plusDuration).floor();
      if(newResinNum + resinNum >= 160){
        // 新增树脂溢出，直接树脂给160，时间给现在时间
        resinNum = 160;
        refreshTime = now;
      }else{
        // 新增树脂没有溢出，更新树脂数，时间更新为除去树脂的时间
        resinNum = resinNum + newResinNum;
        refreshTime = refreshTime.add(Duration(seconds: plusDuration * newResinNum));
      }
    }
  }
}
