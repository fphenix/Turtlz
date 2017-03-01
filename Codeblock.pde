// Fred Limouzin
// 24/02/2017

class Codeblock {
  StringList codeBlock;
  int iter;
  int lineNb;

  Codeblock (StringList tCode, int tIter, int tLineNb) {
    codeBlock = tCode;
    lineNb = tLineNb;
    iter = tIter;
  }
}