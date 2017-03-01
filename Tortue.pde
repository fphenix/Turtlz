// Fred Limouzin
// 24/02/2017

ArrayList<Codeblock> glob_repeatMatrix;
ArrayList<Procblock> glob_procMatrix;
String[] glob_filelines;
StringList glob_lines;
StringList glob_repeatBlock;
StringList glob_procBlock;
StringList glob_procArgs;
String glob_line;
String glob_procName;
HashMap<String, Integer> glob_varAssoArray = new HashMap<String, Integer>();

Turtle tortue;

int glob_repeatNb;
int glob_recLvl;
int glob_currRecLvl;
int glob_lineNb;
int glob_itx;

boolean glob_inRepeat;
boolean glob_inProc;

void setup () {
  size(800, 600);
  glob_repeatMatrix = new ArrayList<Codeblock>();
  glob_procMatrix = new ArrayList<Procblock>();
  glob_lines = new StringList();
  //glob_filelines = loadStrings("aymeric1.tortue");
  glob_filelines = loadStrings("carre3.tortue");
  for (String fileline : glob_filelines) {
    glob_lines.append(fileline);
  }
  glob_repeatMatrix.add(new Codeblock(glob_lines.copy(), 1, 0));
  glob_repeatBlock = new StringList();
  glob_procBlock = new StringList();
  glob_procArgs = new StringList();
  glob_procName = "";

  tortue = new Turtle();

  glob_repeatNb = 0;
  glob_recLvl = 0;
  glob_currRecLvl = 0;
  glob_lineNb = 0;
  glob_itx = 0;

  glob_inRepeat = false;
  glob_inProc = false;
}

void draw () {
  glob_currRecLvl = glob_recLvl;

  glob_itx    = glob_repeatMatrix.get(glob_currRecLvl).iter;
  glob_lineNb = glob_repeatMatrix.get(glob_currRecLvl).lineNb;
  glob_line   = glob_repeatMatrix.get(glob_currRecLvl).codeBlock.get(glob_lineNb);

  updatePixels();
  tortue.instructions(glob_line);
  loadPixels();
  tortue.show();
  tortue.nap();

  glob_lineNb++;
  glob_repeatMatrix.get(glob_currRecLvl).lineNb = glob_lineNb;

  if (glob_lineNb >= glob_repeatMatrix.get(glob_currRecLvl).codeBlock.size()) {
    glob_itx--;
    glob_repeatMatrix.get(glob_currRecLvl).iter = glob_itx;
    glob_repeatMatrix.get(glob_currRecLvl).lineNb = 0;

    if (glob_itx == 0) {
      glob_repeatMatrix.remove(glob_currRecLvl);
      glob_recLvl--;
    }
  }
  if ((glob_repeatMatrix.size() == 0) || (tortue.hasBeenStopped())) {
//println(glob_procMatrix.get(0).name);
//printArray(glob_procMatrix.get(0).procBlock);
//printArray(glob_procMatrix.get(0).args);
//println(glob_procMatrix.get(0).lineNb);
    println("Fin du Code");
    noLoop();
  }
}