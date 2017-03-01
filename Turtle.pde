// Fred Limouzin
// 24/02/2017

class Turtle {
  float angle; // angle !
  float angleRad;
  PVector userPos; // position in user ref ([0,0] center of the screen, x inreasing towards the right, y incr to the up direction
  PVector pos; // position in Processing canvas
  int strkW; // strokeWeight
  color colour; // pen color
  color bgcolour; // background color
  boolean penDown;
  boolean hidden;
  boolean stop;
  int speed;

  int diam;
  PVector arrowPos;

  Turtle () {
    this.init();   
    this.diam = 20;
    this.setPenColor("gris");
    this.setCanvasColor("blanc");
  }

  void bound() {
    this.pos.x = constrain(this.pos.x, 0, width-1);
    this.pos.y = constrain(this.pos.y, 0, height-1);
  }

  void init() {
    this.setUserPos(0, 0); // [0, 0] center of the screen
    this.setAngle(90);     // in degree
    this.setStrkW(1);
    this.setPenDown();
    this.setTurtleVisible();
    this.setSpeed(3);
    this.setStart();
  }

  void setStart () {
    this.stop = false;
  }

  void setStop () {
    this.stop = true;
  }

  boolean hasBeenStopped () {
    return this.stop;
  }

  void setSpeed (int sp) {
    this.speed = constrain(sp, 0, 10);
  }

  void setTurtleVisible () {
    this.hidden = false;
  }

  void setTurtleInvisible () {
    this.hidden = true;
  }

  void clearScreen() {
    background(this.bgcolour);
  }

  void setPenDown () {
    this.penDown = true;
  }

  void setPenUp () {
    this.penDown = false;
  }

  void setStrkW (int stw) {
    this.strkW = constrain(stw, 0, 5);
  }

  void setUserPos (float x, float y) {
    this.userPos = new PVector(x, y);
    this.pos = new PVector((x + (width/2)), ((height/2) - y));
  }

  void setUserPosX (float x) {
    this.setUserPos(x, this.userPos.y);
  }

  void setUserPosY (float y) {
    this.setUserPos(this.userPos.x, y);
  }

  void fixUserPostoInt () {
    this.userPos.x = round(this.userPos.x);
    this.userPos.y = round(this.userPos.y);
    this.setUserPos(this.userPos.x, this.userPos.y);
  }

  void moveForward (float len) {
    PVector prevpos = this.pos.copy();
    PVector fwvec = new PVector(1, 0);
    fwvec.rotate(-angleRad);
    fwvec.mult(len);
    this.userPos.add(fwvec);
    this.fixUserPostoInt();

    if (this.penDown) {
      strokeWeight(this.strkW);
      stroke(this.colour);
      line(prevpos.x, prevpos.y, this.pos.x, this.pos.y);
    }
  }

  void writeText (StringList words) {
    String str = "";
    for (String word : words) {
      str += word + " ";
    }
    text(trim(str), this.pos.x, this.pos.y);
  }

  void moveBack (float len) {
    this.moveForward(-len);
  }

  void setAngle (float deg) {
    this.angle = deg % 360;
    // this.angle = (this.angle <= -180) ? (360 + this.angle) : this.angle;
    // this.angle = (this.angle >   180) ? (360 - this.angle) : this.angle;  
    this.angleRad = radians(-this.angle);  // minus: to have 0° point ing right, 90° up, 180° left, 270° down.
  }

  void turnLeft(float deg) {
    this.setAngle(this.angle + deg);
  }

  void turnRight (float deg) {
    this.turnLeft(-deg);
  }

  color setColor (String colorName) {
    color c;
    switch (colorName.toLowerCase()) {
      case "black"   : case "noir"    : c = color(0,   0,   0);   break;
      case "dgray"   : case "grisf"   : c = color(64,  64,  64);  break;
      case "gray"    : case "gris"    : c = color(128, 128, 128); break;
      case "silver"  : case "argent"  : c = color(192, 192, 192); break;
      case "white"   : case "blanc"   : c = color(255, 255, 255); break;
      case "maroon"  : case "marron"  : c = color(128, 64,   0);  break;
      case "red"     : case "rouge"   : c = color(255, 0,   0);   break;
      case "olive"   :                  c = color(128, 128, 0);   break;
      case "dred"    : case "rougef"  : c = color(165, 0,   0);   break;
      case "yellow"  : case "jaune"   : c = color(255, 255, 0);   break;
      case "green"   : case "vert"    : c = color(0,   128, 0);   break;
      case "lgreen"  : case "vertc"   : c = color(0,   255, 0);   break;
      case "teal"    :                  c = color(0,   128, 128); break;
      case "bluello" : case "blaune"  : c = color(128, 192, 128); break;
      case "cyan"    :                  c = color(0,   255, 255); break;
      case "navy"    :                  c = color(0,   0,   128); break;
      case "blue"    : case "bleu"    : c = color(0,   0,   255); break;
      case "lblue"   : case "bleuc"   : c = color(0,   128, 255); break;
      case "purple"  : case "pourpre" : c = color(128, 0,   128); break;
      case "fushia"  : case "fuchia"  : c = color(255, 0,   255); break;
      case "orange"  :                  c = color(255, 165, 0);   break;
      case "piggy"   : case "cochon"  : c = color(255, 192, 192); break;
      case "pink"    : case "rose"    : c = color(255, 128, 128); break;
      default : c = color(0, 0, 0);
    }
    return c;
  }

  void setPenColor (String colorName) {
    this.colour = this.setColor(colorName);
  }

  void setCanvasColor (String colorName) {
    this.bgcolour = this.setColor(colorName);
  }

  int getVal(String arg) {
    if (str(int(arg)).equals(arg)) {
      return int(arg);
    } else {
      return glob_varAssoArray.get(arg);
    }
  }

  //------------------------------------------------------------------------------------------
  void instructions (String line) {
    StringList tlst;
    StringList args = new StringList();
    line.toLowerCase();
    line = trim(line);

    args.clear();
    for (String elmt : splitTokens(line, " ")) {
      args.append(elmt);
    }
    if ((args.size() == 0) || (line == "")) {
      return;
    }

    String instr = args.get(0);

    String pad = "";
    String iLine = "";
    for (int i = 0; i < glob_recLvl; i++) {
      pad += "__";
    }
    iLine = pad + glob_lineNb + "  :  " + line;

    if ((!glob_inRepeat) && (!glob_inProc)) {
      println("(E) : " + iLine);
      switch (instr) {
        case "ve" : case "videecran" : case "cs" : case "clearscreen" :
          this.init();
          this.clearScreen();
          break;
        case "net" : case "nettoie" : case "clean" :
          this.clearScreen();
          break;
          
        case "td" : case "tournedroite" : case "turnright" : case "rt" :
          this.turnRight(float(getVal(args.get(1))));
          break;
        case "tg" : case "tournegauche" : case "turnleft" : case "lt" :
          this.turnLeft(float(getVal(args.get(1))));
          break;
        case "dr" : case "droite" : case "right" : case "est" : case "east" :
          this.setAngle(0);
          break;
        case "ga" : case "gauche" : case "left" : case "ouest" : case "west" :
          this.setAngle(180);
          break;
        case "haut" : case "up" : case "nord" : case "north" :
          this.setAngle(90);
          break;
        case "bas" : case "down" : case "sud" : case "south" :
          this.setAngle(-90);
          break;
        
        case "avance" : case "av" : case "fd" : case "forward" :
          this.moveForward(float(getVal(args.get(1))));
          break;
        case "recule" : case "re" : case "bk" : case "back" :
          this.moveBack(float(getVal(args.get(1))));
          break;
          
        case "cc" : case "couleurcrayon" : case "fixecouleurcrayon" : case "fcc" : case "setpc" : 
          this.setPenColor(args.get(1));
          break;
        case "cf" : case "couleurfond" : case "bg" : case "fcfg" : case "fixecouleurfond" : case "setbg" : 
          this.setCanvasColor(args.get(1));
          break;
          
        case "ct" : case "cachetortue" : case "hide" : case "ht" : case "hideturtle" :
          this.setTurtleInvisible();
          break;
        case "mt" : case "montretortue" : case "show" : case "st" : case "showturtle" :
          this.setTurtleVisible();
          break;
          
        case "lc" : case "levecrayon" : case "pu" : case "penup" :
          this.setPenUp();
          break;
        case "bc" : case "baissecrayon" : case "pd" : case "pendown" :
          this.setPenDown();
          break;
  
        case "orig" : case "origine" : case "home" :
          this.setUserPos(0, 0);
          break;
        case "position" : case "pos" : case "posxy" : case "goto" : case "setxy" : case "fixexy" : 
          this.setUserPos(getVal(args.get(1)), getVal(args.get(2)));
          break;
        case "positionx" : case "posx" : case "fixex" :
          this.setUserPosX(getVal(args.get(1)));
          break;
        case "positiony" : case "posy" : case "fixey" :
          this.setUserPosY(getVal(args.get(1)));
          break;
        case "cap" :
          this.setAngle(getVal(args.get(1)));
          break;
  
        case "ep" : case "epaisseur" : case "weight" : case "w" :
          this.setStrkW(getVal(args.get(1)));
          break;
          
        case "vitesse" : case "speed" :
          this.setSpeed(getVal(args.get(1)));
          break;
          
        case "ecris" : case "write" : case "texte" : case "text" :
          tlst = args.copy();
          tlst.remove(0);
          this.writeText(tlst.copy());
          break;
          
        case "rep" : case "repete" : case "repeat" :
          glob_inRepeat = true;
          glob_repeatNb = getVal(args.get(1));
          glob_repeatBlock.clear();
          break;
        
        case "pour" : case "to" :
          glob_inProc = true;
          glob_procName = args.get(1);
          glob_procArgs.clear();
          tlst = args.copy();
          tlst.remove(0); // remove command "pour" or "to"
          tlst.remove(0); // remove procedure name so only the arguments list (if any) is left.
          glob_procArgs = tlst.copy();
          glob_procBlock.clear();
          break;
        
        case "var" : case "variable" :
          glob_varAssoArray.put(args.get(1), getVal(args.get(2)));
          break;
        
        case "stop" :
          this.setStop();
          break;
        
        case "" : case ";" : case "//" :
          break;
        
        default :
          tlst = args.copy();
          tlst.remove(0); // remove procedure name so only the arguments list (if any) is left.
          int pIdx = this.isProc(instr, tlst.copy());
          if (pIdx >= 0) {
            glob_repeatMatrix.add(new Codeblock(glob_procMatrix.get(pIdx).procBlock.copy(), 1, 0));
            glob_recLvl++;
            println("(C) : " + iLine); // Call
          } else {
            println("ERREUR! Je ne connais pas l'instruction ligne n°" + glob_lineNb);
            println("  > " + line);
            noLoop();
          }
          break;
      }
    } else if (glob_inRepeat) {
      switch (instr) {
       case "finrep" : case "finrepete" : case "endrepeat" :
          glob_repeatMatrix.add(new Codeblock(glob_repeatBlock.copy(), glob_repeatNb, 0));
          glob_recLvl++;
          glob_inRepeat = false; // problem when nested repeat
          glob_repeatBlock.clear();
          println("(C) : " + iLine); // Call
          break;

        default :
          println("(R) : " + iLine); // Read
          glob_repeatBlock.append(line);
          break;
      }
    } else if (glob_inProc) {
      switch (instr) {
        case "finpour" : case "endto" :
          glob_procMatrix.add(new Procblock(glob_procName, glob_procBlock.copy(), glob_procArgs.copy(), 0));
          glob_inProc = false; // problem when nested repeat
          glob_procBlock.clear();
          glob_procArgs.clear();
          println("(S) : " + iLine); // Stocke, Store
          break;

        default :
          println("(M) : " + iLine); // Memorize
          glob_procBlock.append(line);
          break;
      }
    } else {
      println("I am LOST !! Help!!!");
      noLoop();
    }
  }
  
  int isProc (String instruc, StringList argval) {
    int ret = -1;
    String arg;
printArray(argval);
println(instruc);
    for (int i = 0; i < glob_procMatrix.size(); i++) {
      if (glob_procMatrix.get(i).name.equals(instruc)) {
        for (int j = 0; j < glob_procMatrix.get(i).args.size(); j++) {
          arg = glob_procMatrix.get(i).args.get(j);
          glob_varAssoArray.put(arg, int(argval.get(j)));
        }
        ret = i;
        break;
      }
    }
    return ret;
  }

  void nap () {
    delay(100 * this.speed);
  }

  //------------------------------------------------------------------------------------------
  void show () {
    bound();
    if (!this.hidden) {
      ellipseMode(CENTER);
      strokeWeight(this.strkW);
      stroke(0, 0, 0);
      noFill();
      ellipse(this.pos.x, this.pos.y, this.diam, this.diam);
      PVector dir = new PVector((this.diam / 2), 0);
      fill(colour);
      strokeWeight(1);
      beginShape();
      dir.rotate(angleRad);
      arrowPos = PVector.add(this.pos, dir);
      vertex(arrowPos.x, arrowPos.y);
      dir.rotate(radians(120));
      arrowPos = PVector.add(this.pos, dir);
      vertex(arrowPos.x, arrowPos.y);
      vertex(this.pos.x, this.pos.y);
      dir.rotate(radians(120));
      arrowPos = PVector.add(this.pos, dir);
      vertex(arrowPos.x, arrowPos.y);
      endShape(CLOSE);
      text("x,y = " + this.userPos.x + "," + this.userPos.y + " ; a° = " + this.angle, 50, height - 20);
      text(glob_line, 20, 20);
    }
  }
}