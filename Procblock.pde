// Fred Limouzin
// 24/02/2017

class Procblock {
  String name;
  StringList procBlock;
  StringList args;
  int lineNb;

  Procblock (String tName, StringList tCode, StringList tArgs, int tLineNb) {
    name = tName;
    procBlock = tCode;
    lineNb = tLineNb;
    args = tArgs;
  }
}