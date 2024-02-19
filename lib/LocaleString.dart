import 'package:get/get.dart';

class LocalString extends Translations{

  @override
  Map<String, Map<String, String>> get keys=>{
    'en_US':{
      'hello':'HELLO WORLD',
      'message':"WELCOME TO CODE POINT"
    },
    'en_KO':{
      'hello':'안녕하세요 세계',
      'message':"코드 포인트에 오신 것을 환영합니다"
    },
  };
}