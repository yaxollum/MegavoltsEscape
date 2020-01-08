/* Peter Ye
January 3, 2020
ICS20 ISP
Megavolt's Escape
I used processing.org as a reference while completing this project.
I have also previously learned some programming concepts such as passing parameters to methods
and returning values from "Think Java" by Allen B. Downey
*/

int loadingBarLength=0; // current length of loading bar
final int loadingBarMaxLength=400; // length of loading bar at 100%
PFont game_font; // font used in game
int screenID=0; // stores the ID of the current screen

int introTimeDisplay=0; // delays one week ago message
int helicopterX=0,helicopterY=200; // coordinates of helicopter
float helicopterBladeAngle=0; // angle of helicopter blade
float gangX1=300,gangY1=200; // coordinates of
float gangX2=300,gangY2=200; // gang members
float characterX=310,characterY=370; // coordinates of character
int mazeCharacterX=1,mazeCharacterY=0; // coordinates of character in maze
float bagAngle=0; // angle of the bag

int mazeStationTextDelay=0; // delays text inside maze stations
int exitWaves=0; // delays goodbye screen

int[][] mazeVerticalWalls={ // vertical walls of maze
{1,1,1,1,1},
{1,1,1,1,0},
{0,1,1,1,1},
{0,0,1,1,0},
{0,0,1,1,1},
{0,0,0,1,0},
{0,0,1,1,0},
{0,0,1,1,0},
{1,1,1,1,1}
};

int[][] mazeHorizontalWalls={ // horizontal walls of maze
{1,1,1,1,1,1,1,1},
{0,0,1,1,1,1,1,0},
{0,0,0,1,1,1,1,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,1,0,0,0},
{1,1,1,1,1,1,1,1}
};

boolean mazeStation1Done=false; // stores whether maze stations
boolean mazeStation2Done=false; // have been completed
boolean mazeStation3Done=false;
boolean mazeStation4Done=false;

boolean mazeStation1SwitchClosed=false; // stores state of switches
boolean mazeStation2SwitchClosed=false; // in maze stations
boolean mazeStation3Switch1Closed=false;
boolean mazeStation3Switch2Closed=true;
boolean mazeStation3Switch3Closed=true;
boolean mazeStation4Switch1Closed=false;
boolean mazeStation4Switch2Closed=false;
boolean mazeStation4Switch3Closed=false;

boolean mazeStation4Page1=true; // stores instruction page of maze station 4

boolean gameSwitch1Closed=true; // stores state of switches
boolean gameSwitch2Closed=false; // in game of testing

float characterSpeedY=0; // vertical speed of character in game of testing

boolean gameAPressed=false; // stores which keys are held down
boolean gameWPressed=false; // in game of testing
boolean gameDPressed=false;

int gameTextDelay=0; // delays success or fail banner in game of testing
boolean gamePaused=false; // stores whether game controls have been disabled

float armAngle=11*PI/8;
float armAngleSpeed=0.04;

boolean mouseInBox(int x,int y,int boxLength,int boxHeight) // returns whether mouse is in a given rectangular box
{
  return mouseX>=x&&mouseX<=x+boxLength&&mouseY>=y&&mouseY<=y+boxHeight;
}

void loadingBar() // loading bar
{
  background(50);
  noStroke();
  
  int loadPercentage=loadingBarLength*100/loadingBarMaxLength; // percentage of the bar that has been loaded
  fill(#4CF3FA);
  textFont(game_font,60);
  text("Megavolt's Escape",150,150);
  fill(#7CA718);
  textFont(game_font,30);
  text("Loading "+loadPercentage+"%",300,300); // display load percentage
  
  fill(255);
  rect(395-loadingBarMaxLength/2,195,loadingBarMaxLength+10,60);
  fill(#3DC622);
  
  
  rect(400-loadingBarMaxLength/2,200,loadingBarLength,50);
  ++loadingBarLength;
  if(loadingBarLength>loadingBarMaxLength) ++screenID; // moves to introTime screen
}

void introTime() // displays "One Week Ago ..." message
{
  background(50);
  textFont(game_font,50);
  fill(#EDE83E);
  text("One Week Ago ...",180,200);
  ++introTimeDisplay;
  if(introTimeDisplay>=180) ++screenID; // moves to introAnimationPart1 (part 1 of animation)
}

void drawHelicopter() // draws the helicopter
{
  stroke(80);
  strokeWeight(20);
  line(helicopterX,helicopterY-50,helicopterX,helicopterY-100);
  stroke(50);
  strokeWeight(15);
  line(helicopterX-50,helicopterY,helicopterX-50,helicopterY+70);
  line(helicopterX+50,helicopterY,helicopterX+50,helicopterY+70);
  line(helicopterX-120,helicopterY+70,helicopterX+120,helicopterY+70);
  stroke(0);
  strokeWeight(1);
  fill(#117C2E);
  rect(helicopterX-200,helicopterY-20,200,20);
  ellipse(helicopterX,helicopterY,200,100); // body of helicopter
  ellipse(helicopterX-200,helicopterY-20,30,80);
  fill(#20C9B9);
  rect(helicopterX-50,helicopterY-20,100,40);
  strokeWeight(20);
  stroke(#D3C011); // helicoter blades
  line(helicopterX-cos(helicopterBladeAngle)*150,(helicopterY-100)-sin(helicopterBladeAngle)*80,
    helicopterX+cos(helicopterBladeAngle)*150,(helicopterY-100)+sin(helicopterBladeAngle)*80); // helicopter blade
  strokeWeight(1);
  stroke(0);
  fill(80);
  ellipse(helicopterX,helicopterY-100,20,20);
}

void drawGang(float gangX,float gangY)
{
  fill(0);
  strokeWeight(1);
  ellipse(gangX,gangY,30,30); // head
  strokeWeight(8);
  line(gangX,gangY,gangX,gangY+50); // spine
  line(gangX,gangY+30,gangX-20,gangY+10); // left arm
  line(gangX,gangY+30,gangX+20,gangY+10); // right arm
  line(gangX,gangY+50,gangX-20,gangY+70); // left leg
  line(gangX,gangY+50,gangX+20,gangY+70); // right leg
}

void drawCharacter()
{
  strokeWeight(8);
  line(characterX,characterY,characterX,characterY+50); // spine
  line(characterX,characterY+30,characterX-20,characterY+10); // left arm
  line(characterX,characterY+30,characterX+20,characterY+10); // right arm
  line(characterX,characterY+50,characterX-20,characterY+70); // left leg
  line(characterX,characterY+50,characterX+20,characterY+70); // right leg
  fill(#CBA779);
  strokeWeight(1);
  ellipse(characterX,characterY,30,30); // head
  fill(#EA8911);
  arc(characterX,characterY,40,40,PI,2*PI,CHORD); // hat
}

void drawBag() // bag put over character's head in animation
{
  fill(#0C3981);
  strokeWeight(1);
  quad(gangX2-20,gangY2+15,
    gangX2-20+cos(bagAngle)*40,gangY2+15-sin(bagAngle)*40,
    gangX2-20+cos(bagAngle+atan(6/4))*sqrt(5200),gangY2+15-sin(bagAngle+atan(6/4))*sqrt(5200),
    gangX2-20+cos(bagAngle+PI/2)*60,gangY2+15-sin(bagAngle+PI/2)*60);
}

void drawStick() // stick stuck in character's mouth in animation
{
  fill(#814C0C);
  strokeWeight(1);
  rect(gangX1+20,gangY1+5,30,8);
}

void introAnimationPart1() // part 1 of animation
{
  background(150);
  drawHelicopter();
  fill(#79C9CB);
  rect(0,400,800,100);
  drawCharacter();
  helicopterBladeAngle+=0.1;
  if(helicopterX<300) ++helicopterX; // moves helicopter to the right
  else
  {
    drawGang(gangX1,gangY1);
    drawGang(gangX2,gangY2);
    drawStick();
    drawBag();
    if(gangY1<=370)
    {
      gangX1-=1; // gang member 1 moves towards the bottom left corner
      gangX2+=0.5; // gang member 2 moves towards the bottom right corner
      ++gangY1; // they stop when they hit the ground
      ++gangY2;
    }
    else
    {
      if(bagAngle<PI/2) bagAngle+=0.01; // rotates bag counter-clockwise
      else
      {
        gangX1+=1.2; // moves people to the right (gang member 1 moves faster to catch up)
        ++gangX2;
        ++characterX;
        if(gangX1>850)
        {
          ++screenID; // moves to introAnimationPart2 (part 2 of animation)
          gangX1-=800;
          characterX-=800;
          gangX2-=800;
        }
      }
    }
  }
}

void drawBuildingLeft() // draws left side of the building (including doorway)
{
  fill(#9EB45D);
  rect(400,450,300,-400);
  fill(50);
  rect(630,450,70,-150);
  fill(#159BCE);
  rect(450,250,100,70); // window
  stroke(100);
  strokeWeight(10);
  line(430,250,570,250);
  line(430,320,570,320);
  for(int x=440;x<=560;x+=20)
  {
    line(x,250,x,320); // draws bars on the window
  }
  stroke(0);
}

void drawBuildingRight() // draws right side of building (used to cover the people after they have entered)
{
  fill(#9EB45D);
  rect(700,450,200,-400);
  stroke(#9EB45D);
  line(700,50,700,450);
  stroke(0);
}

void drawBanner() // draws "BASE 3923" banner
{
  fill(200);
  rect(420,100,360,100);
  fill(#DD0000);
  textFont(game_font,60);
  text("BASE 3923",440,180);
}

void introAnimationPart2() // part 2 of animation
{
  background(150);
  fill(#B45DB3);
  rect(0,400,800,100);
  drawBuildingLeft();
  drawGang(gangX1,gangY1); // draws gang members
  drawGang(gangX2,gangY2);
  drawCharacter(); // draws character
  drawStick();
  drawBag();
  drawBuildingRight();
  drawBanner();
  ++gangX1; // moves people to the right
  ++gangX2;
  ++characterX;
  
  if(gangX1>=750) ++screenID; // moves to mainMenu (all of the introduction animation finished)
}

void mainMenu()
{
  strokeWeight(1);
  textFont(game_font,50);
  background(150);
  fill(#E0D144);
  
  if(mouseInBox(200,50,400,80)) fill(#EDE597); // instructions
  rect(200,50,400,80);
  fill(#E0D144);
  
  if(mouseInBox(200,150,400,80)) fill(#EDE597); // maze of learning
  rect(200,150,400,80);
  fill(#E0D144);
  
  if(mouseInBox(200,250,400,80)) fill(#EDE597); // game of testing
  rect(200,250,400,80);
  fill(#E0D144);
  
  if(mouseInBox(200,350,400,80)) fill(#EDE597); // exit
  rect(200,350,400,80);
  fill(#E0D144);
  
  fill(50);
  text("Instructions",240,110); // instructions button
  textFont(game_font,40);
  text("Maze of Learning",230,200); // maze button
  text("Game of Testing",230,300); // game button
  textFont(game_font,60);
  text("Exit",330,410); // exit button
}

void mainMenuMouse()
{
  if(mouseInBox(200,50,400,80)) ++screenID; // instructions
  else if(mouseInBox(200,150,400,80)) screenID+=2; // maze of learning
  else if(mouseInBox(200,250,400,80)) 
  {
    gameOfTestingInit();
    screenID+=3; // game of testing
  }
  else if(mouseInBox(200,350,400,80)) screenID+=4; // exit
}

void instructions()
{
  strokeWeight(1);
  fill(#64D126);
  background(50);
  textFont(game_font,25);
  text("You are a master electrician named Megavolt." // extremely long instructions
  +" You have been captured by a group of masked gang members" // split
  +" and thrown into a secret base hidden in underground Toronto." // across
  +" The gang has locked you up behind multiple layers of electrical security" // multiple
  +" equipment. You must escape undiscovered -" // lines!
  +" and not electrocuted, of course!\n\nControls\n"
  +"---------------\nW to go up\n"
  +"S to go down\nA to go left\nD to go right",50,50,700,400);
  if(mouseInBox(500,350,200,80)) fill(#49DCE3);
  else fill(#2FC2C9);
  rect(500,350,200,80);
  textFont(game_font,45);
  fill(0);
  text("Back",580,405);
  strokeWeight(3);
  line(520,390,560,390); // draws arrow
  line(520,390,540,380);
  line(520,390,540,400);
}

void instructionsMouse()
{
  if(mouseInBox(500,350,200,80)) --screenID; // go back to mainMenu
}

void drawMazeWalls() // draws walls of maze
{
  strokeWeight(10);
  stroke(#8B4EE3);
  for(int i=0;i<mazeVerticalWalls.length;++i)
  {
    for(int j=0;j<mazeVerticalWalls[i].length;++j)
    {
      if(mazeVerticalWalls[i][j]==1) line(i*100,j*100,i*100,j*100+100); 
        // vertical walls
    }
  }
  for(int i=0;i<mazeHorizontalWalls.length;++i)
  {
    for(int j=0;j<mazeHorizontalWalls[i].length;++j)
    {
      if(mazeHorizontalWalls[i][j]==1) line(j*100,i*100,j*100+100,i*100); 
        // horizontal walls
    }
  }
}

void drawMazeCharacter() // draws character in maze
{
  stroke(#C4BC28);
  strokeWeight(6);
  int tempCharacterX=mazeCharacterX*100+50;
  int tempCharacterY=mazeCharacterY*100+25;
  line(tempCharacterX,tempCharacterY,tempCharacterX,tempCharacterY+40); // spine
  line(tempCharacterX,tempCharacterY+24,tempCharacterX-16,tempCharacterY+8); // left arm
  line(tempCharacterX,tempCharacterY+24,tempCharacterX+16,tempCharacterY+8); // right arm
  line(tempCharacterX,tempCharacterY+40,tempCharacterX-16,tempCharacterY+64); // left leg
  line(tempCharacterX,tempCharacterY+40,tempCharacterX+16,tempCharacterY+64); // right leg
  fill(#CBA779);
  stroke(0);
  strokeWeight(1);
  ellipse(tempCharacterX,tempCharacterY,24,24); // head
  fill(#EA8911);
  arc(tempCharacterX,tempCharacterY,32,32,PI,2*PI,CHORD); // hat
}

void mazeOfLearningKey() // handles keyboard input for maze
{
  if(key=='w'&&mazeHorizontalWalls[mazeCharacterY][mazeCharacterX]==0) --mazeCharacterY;
  else if(key=='s'&&mazeHorizontalWalls[mazeCharacterY+1][mazeCharacterX]==0) ++mazeCharacterY;
  else if(key=='a'&&mazeVerticalWalls[mazeCharacterX][mazeCharacterY]==0) --mazeCharacterX;
  else if(key=='d'&&mazeVerticalWalls[mazeCharacterX+1][mazeCharacterY]==0) ++mazeCharacterX;
}

void drawLightningBolt(int x,int y,float scale)
{
  beginShape(); // scale changes the size of the lightning bolt
  vertex(x,y);
  vertex(x+40*scale,y-20*scale);
  vertex(x+60*scale,y-10*scale);
  vertex(x+100*scale,y-35*scale);
  vertex(x+60*scale,y+5*scale);
  vertex(x+40*scale,y-10*scale);
  endShape(CLOSE);
}

void drawMazeStation(int stationX,int stationY,boolean done)
{
  int tempStationX=stationX*100+50;
  int tempStationY=stationY*100+70;
  strokeWeight(5);
  stroke(#2A9DBC);
  line(tempStationX,tempStationY,tempStationX-30,tempStationY-50);
  line(tempStationX,tempStationY,tempStationX+30,tempStationY-50);
  line(tempStationX,tempStationY,tempStationX,tempStationY-50);
  strokeWeight(1);
  stroke(0);
  fill(#081798);
  ellipse(tempStationX,tempStationY,80,40); // body of the station
  
  if(done) fill(#00DD00); // green bolt if done
  else fill(#DD0000); // red otherwise
  
  drawLightningBolt(tempStationX-30,tempStationY+10,0.55);
}

void drawExit()
{
  int exitX=4,exitY=3; // coordinates of exit arrow
  exitX*=100;
  exitY*=100;
  exitX+=50;
  fill(#00DD00); // green
  beginShape();
  vertex(exitX+10,exitY);
  vertex(exitX+10,exitY+50);
  vertex(exitX+20,exitY+50);
  vertex(exitX,exitY+80);
  vertex(exitX-20,exitY+50);
  vertex(exitX-10,exitY+50);
  vertex(exitX-10,exitY);
  endShape(CLOSE);
}

void mazeOfLearning()
{
  background(50);
  drawMazeWalls(); // draws walls of maze
  drawMazeStation(0,0,mazeStation1Done);
  drawMazeStation(3,2,mazeStation2Done);
  drawMazeStation(6,2,mazeStation3Done);
  drawMazeStation(4,4,mazeStation4Done);
  drawMazeCharacter();
  
  mazeStationTextDelay=120;
  if(!mazeStation1Done&&mazeCharacterX==0&&mazeCharacterY==0) screenID=61; // station 1
  else if(!mazeStation2Done&&mazeCharacterX==3&&mazeCharacterY==2) screenID=62; // station 2
  else if(!mazeStation3Done&&mazeCharacterX==6&&mazeCharacterY==2) screenID=63; // station 3
  else if(!mazeStation4Done&&mazeCharacterX==4&&mazeCharacterY==4) screenID=64; // station 4
  
  if(mazeStation1Done&&mazeStation2Done&& // all stations completed
    mazeStation3Done&&mazeStation4Done)
  {
    drawExit(); // draw exit arrow
    if(mazeCharacterX==4&&mazeCharacterY==3) screenID=65; // mazeCompleted
  }    
}

void drawBattery(int x,int y)
{
  fill(150);
  rect(x-10,y-10,120,20); // terminals of battery
  fill(100);
  rect(x,y-20,100,40,8); // body of battery
  fill(#DECF28); // yellow lightning bolt
  drawLightningBolt(x+10,y+10,0.8);
}

void drawLightBulb(int x,int y,color c)
{
  fill(150); // terminals of light
  rect(x-10,y-10,120,20);
  fill(100);
  rect(x,y-25,100,50,8);
  fill(c);
  ellipse(x+50,y-30,30,70);
  strokeWeight(2);
  stroke(#B77421);
  line(x,y,x+46,y); // these lines are the wires inside the light
  line(x+54,y,x+100,y);
  line(x+46,y,x+42,y-30);
  line(x+54,y,x+56,y-40);
  line(x+42,y-30,x+56,y-40);
  stroke(0);
  strokeWeight(1);
}

void drawSwitch(int x,int y,boolean closed)
{
  if(closed) // switch closed (electricity can flow through)
  {
    strokeWeight(15);
    stroke(125);
    line(x+10,y-40,x+100,y-40);
    stroke(0);
    strokeWeight(1);
  }
  else // switch open (no electricity flow)
  {
    strokeWeight(15);
    stroke(125);
    line(x+10,y-40,x+80,y-80);
    stroke(0);
    strokeWeight(1);
  }
  fill(150);
  rect(x-10,y-10,120,20);
  if(mouseInSwitch(x,y)) fill(130);
  else fill(100);
  rect(x,y-25,100,50,8);
  fill(150);
  rect(x+10,y,15,-50);
  rect(x+75,y,15,-50);
}

boolean mouseInSwitch(int x,int y)
{
  return mouseInBox(x,y-25,100,50); // determines whether mouse
                                    // is hovering over switch
}

void mazeStation1Mouse() // processes mouse input for maze station 1
{
  if(!mazeStation1Done&&mouseInSwitch(520,200)) mazeStation1SwitchClosed=!mazeStation1SwitchClosed;
  // toggle switch
}

void drawWire(int x1,int y1,int x2,int y2,int x3,int y3,color c)
{
  noFill(); // used to draw all the wires
  stroke(c);
  strokeWeight(3);
  beginShape();
  vertex(x1,y1);
  quadraticVertex(x2,y2,x3,y3);
  endShape();
  strokeWeight(1);
  stroke(0);
}

void goodJobBanner()
{
  fill(50); // displays good job for maze
  rect(0,350,800,150);
  fill(#00DD00);
  textFont(game_font,50);
  text("Good Job!",270,440);
}

void mazeStation1() // station 1 of maze
{
  background(#58E0DF); // light blue
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,30); // instructions for level
  text("An electrical switch can control the flow of electricity. "
    +"You can toggle a switch by clicking on it. Toggle the switch "
    +"in the circuit above to turn the light on.",10,360,800,150);
  
  drawWire(420,300,700,300,620,200,#DD0000);
  drawWire(520,200,450,180,380,140,#411BDE);
  drawWire(280,140,200,200,320,300,#AD10C6);
  drawBattery(320,300);
  if(mazeStation1SwitchClosed) drawLightBulb(280,140,#DDDD00);
  else drawLightBulb(280,140,150); // light bulb
  
  drawSwitch(520,200,mazeStation1SwitchClosed);
  
  
  if(mazeStation1SwitchClosed) // level beat as soon as switch closed
  {
    goodJobBanner();
    mazeStation1Done=true; // disables mouse input
    --mazeStationTextDelay; // delays text on good job banner
    if(mazeStationTextDelay<=0)
    {
      screenID/=10; // returns to maze
    }
  }
}

void mazeStation2Mouse() // processes mouse input for maze station 2
{
  if(!mazeStation2Done&&mouseInSwitch(620,200)) mazeStation2SwitchClosed=!mazeStation2SwitchClosed;
  // toggle switch
}

void mazeStation2() // station 2 of maze
{
  background(#58E0DF); // light blue
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,25); // instructions for level
  text("A series circuit is a circuit which has multiple "
    +"electrical loads connected together to form one path. "
    +"A switch in a series circuit will turn off all of the loads "
    +"when switched off. Toggle the switch above to turn off "
    +"both the red light and the green light.",10,360,790,150);
  
  drawWire(420,300,900,300,720,200,#DD0000);
  drawWire(620,200,550,150,500,150,#411BDE);
  drawWire(400,150,300,160,280,140,#AD10C6);
  drawWire(180,140,0,220,320,300,#11A50A);
  drawBattery(320,300); // battery
  if(mazeStation2SwitchClosed) drawLightBulb(400,150,#DD0000);
  else drawLightBulb(400,150,150); // red light
  if(mazeStation2SwitchClosed) drawLightBulb(180,140,#00DD00);
  else drawLightBulb(180,140,150); // green light
  
  drawSwitch(620,200,mazeStation2SwitchClosed);
  
  if(mazeStation2SwitchClosed) // level beat as soon as switch closed
  {
    goodJobBanner();
    mazeStation2Done=true; // disables mouse input
    --mazeStationTextDelay; // delays good job banner
    if(mazeStationTextDelay<=0)
    {
      screenID/=10; // returns to maze
    }
  }
}

void mazeStation3Mouse() // processes mouse input for maze station 3
{
  if(!mazeStation3Done&&mouseInSwitch(100,120)) mazeStation3Switch1Closed=!mazeStation3Switch1Closed;
  // toggle switch 1
  
  else if(!mazeStation3Done&&mouseInSwitch(500,100)) mazeStation3Switch2Closed=!mazeStation3Switch2Closed;
  // toggle switch 2
  
  else if(!mazeStation3Done&&mouseInSwitch(500,220)) mazeStation3Switch3Closed=!mazeStation3Switch3Closed;
  // toggle switch 3
}

void mazeStation3() // station 3 of maze
{
  background(#58E0DF); // light blue
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,25); // instructions for level
  text("A parallel circuit is a circuit which has multiple loads, "
    +"each forming a separate branch for electricity to flow through. "
    +"This allows each load to be switched on and off separately. "
    +"Toggle the switches above to turn on the red light but leave the green "
    +"light off.",10,360,790,150);
  
  boolean greenLightOn=mazeStation3Switch1Closed&&mazeStation3Switch2Closed;
  boolean redLightOn=mazeStation3Switch1Closed&&mazeStation3Switch3Closed;;
    
  drawWire(450,320,-100,200,100,120,#411BDE);
  drawWire(200,120,310,115,350,90,#AD10C6);
  drawWire(450,90,470,95,500,100,#AD10C6);
  drawWire(600,100,950,200,600,220,#AD10C6);
  drawWire(200,120,250,140,340,185,#11A50A);
  drawWire(440,185,440,185,500,220,#11A50A);
  drawWire(600,220,700,250,550,320,#411BDE);
  
  drawBattery(450,320); // battery
  drawSwitch(100,120,mazeStation3Switch1Closed); // switch 1
  if(greenLightOn) drawLightBulb(350,90,#00DD00);
  else drawLightBulb(350,90,150); // green light
  drawSwitch(500,100,mazeStation3Switch2Closed); // switch 2
  if(redLightOn) drawLightBulb(340,185,#DD0000);
  else drawLightBulb(340,185,150); // red light
  drawSwitch(500,220,mazeStation3Switch3Closed); // switch 3
  
  if(redLightOn&&!greenLightOn) // red light on, green light off
  {
    goodJobBanner(); // displays good job
    mazeStation3Done=true; // disables mouse input
    --mazeStationTextDelay;
    if(mazeStationTextDelay<=0)
    {
      screenID/=10; // returns to maze
    }
  }
}

void drawFlames(int x,int y) // draws fire for short circuit
{
  fill(#EA6C1C);
  beginShape();
  vertex(x+30,y+15);
  bezierVertex(x,y-20,x+40,y-50,x+40,y-70); // flame 1
  bezierVertex(x+40,y-50,x+60,y-20,x+50,y+15);
  endShape(CLOSE);
  fill(#F22F0C);
  beginShape();
  vertex(x+45,y+10);
  bezierVertex(x+50,y-20,x+40,y-50,x+80,y-60); // flame 2
  bezierVertex(x+60,y-50,x+100,y-20,x+60,y+10);
  endShape(CLOSE);
  stroke(#FAD723);
  strokeWeight(4);
  for(int loop=0;loop<10;++loop) // draw 10 bubbles every frame
  {
    point(random(x,x+100),random(y-20,y+20)); // bubbles inside fire
  }
}

void mazeStation4Mouse() // processes mouse input for maze station 4
{
  if(mazeStation4Done) return; // return if station completed
  
  if(mouseInBox(670,475,120,20)) mazeStation4Page1=!mazeStation4Page1;
    // flips the page for instructions
    
  else if(mouseInSwitch(450,300)) mazeStation4Switch1Closed=!mazeStation4Switch1Closed;
  // toggle switch 1
  
  else if(mouseInSwitch(320,190)) mazeStation4Switch2Closed=!mazeStation4Switch2Closed;
  // toggle switch 2
  
  else if(mouseInSwitch(100,200)) mazeStation4Switch3Closed=!mazeStation4Switch3Closed;
  // toggle switch 3
}

void mazeStation4() // maze station 4
{
  background(#58E0DF); // light blue background
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,25);
  if(mazeStation4Page1) // page 1 of instructions
  {
    text("Electricity always takes the path of least resistance. "
      +"A short circuit is a special type of parallel circuit where "
      +"the two ends of one or more loads are connected by a wire. "
      +"This directs all of the electricity through the wire, "
      +"causing none of it to go through the loads.",10,360,790,150);
    if(mouseInBox(670,475,120,20)) fill(#DE6E6E);
    else fill(#980505);

    textFont(game_font,20);
    text("(next page)",670,490); // clickable link
  }
  else // page 2 of instructions
  {
    text("Short circuiting a battery is very dangerous "
      +"(only short circuit a portion of a circuit). "
      +"Use a short circuit to turn on the green light above but leave the "
      +"red light off (WITHOUT BLOWING UP THE BATTERY)",10,360,790,150);
    
    if(mouseInBox(670,475,120,20)) fill(#DE6E6E);
    else fill(#980505);

    textFont(game_font,20);
    text("(prev page)",670,490); // clickable link
  }
  
  boolean batteryShortCircuit=mazeStation4Switch3Closed; // short circuit
  boolean greenLightOn=!batteryShortCircuit&&mazeStation4Switch1Closed;
  boolean redLightOn=!batteryShortCircuit
    &&mazeStation4Switch1Closed&&!mazeStation4Switch2Closed;
  
  drawWire(100,305,-170,150,320,70,#11A50A); // wires
  drawWire(100,300,0,250,100,200,#AD10C6);   // for
  drawWire(200,300,300,250,200,200,#AD10C6); // circuit
  drawWire(320,190,200,130,320,70,#AD10C6);
  drawWire(420,190,540,130,420,70,#AD10C6);
  drawWire(420,65,500,100,570,100,#11A50A);
  drawWire(670,100,900,200,550,300,#11A50A);
  drawWire(200,300,300,270,450,300,#11A50A);
  
  drawBattery(100,300); // battery
  if(batteryShortCircuit) drawFlames(100,300); // battery on fire
  
  drawSwitch(450,300,mazeStation4Switch1Closed);
  if(greenLightOn) drawLightBulb(570,100,#00DD00);
  else drawLightBulb(570,100,150); // green light
  if(redLightOn) drawLightBulb(320,70,#DD0000);
  else drawLightBulb(320,70,150); // red light
  drawSwitch(320,190,mazeStation4Switch2Closed);
  drawSwitch(100,200,mazeStation4Switch3Closed);
  
  if(!redLightOn&&greenLightOn) // red light off, green light on
  {
    goodJobBanner(); // displays good job
    mazeStation4Done=true; // disables mouse input
    --mazeStationTextDelay;
    if(mazeStationTextDelay<=0)
    {
      screenID/=10; // returns to maze
    }
  }
}

void mazeCompleted() // maze completed
{
  background(50);
  fill(#13E5C7);
  textFont(game_font,30);
  text("Congratulations! You have completed the Maze of Learning. Now it's time to "
    +"escape from the gang in the Game of Testing ...",50,50,700,400);
    
  if(mouseInBox(500,350,200,80)) fill(#49DCE3);
  else fill(#2FC2C9);
  rect(500,350,200,80); // continue button
  textFont(game_font,40);
  fill(0);
  text("Continue",515,405);
}


void mazeCompletedMouse()
{
  if(mouseInBox(500,350,200,80)) screenID=4; // go back to mainMenu
}

void drawMotionDetector(int x,int y,int beamLength,boolean motionDetectorOn)
{ // draws motion detector
  if(motionDetectorOn) // motion detector connected to power
  {
    strokeWeight(5);
    stroke(#DD0000);
    line(x+60,y,x+60,y+beamLength); // red laser
    strokeWeight(1);
    stroke(0);
  }
  fill(#E4E888);
  rect(x+40,y,40,40,8);
  fill(150);
  rect(x-10,y-10,120,20);
  fill(#83E3BA);
  rect(x,y-25,100,50,8);
  fill(50);
  textFont(game_font,32);
  text("NO-MO",x+6,y+12); // text on motion detector
}

void drawInsulator(int x) // ceramic insulator supporting wire
{
  fill(150);
  rect(x,330,10,70);
  rect(x-5,350,20,50);
  for(int y=350;y<400;y+=10)
  {
    line(x-5,y,x+15,y); // lines on insulator
  }
}

void gameOfTestingMouse()
{
  if(gamePaused) return; // don't let the character toggle
                         // switches if they fail
  if(mouseInSwitch(50,90)) gameSwitch1Closed=!gameSwitch1Closed;
  else if(mouseInSwitch(220,150)) gameSwitch2Closed=!gameSwitch2Closed;
}

void gameOfTestingMovement() // handles keyboard input for game
{
  if(gamePaused) return; // don't let the character move if they fail
  if(gameAPressed) characterX-=5;
  if(gameDPressed) characterX+=5;
  if(gameWPressed&&characterY==260) characterSpeedY=-15;
}

void gameOfTestingInit() // resets the state of the game
{
  gameTextDelay=120;
  characterX=50;
  characterY=260;
  gameSwitch1Closed=true; // switch 1 closed
  gameSwitch2Closed=false; // switch 2 open

  characterSpeedY=0;

  gameAPressed=false; // no keys held down
  gameWPressed=false;
  gameDPressed=false;
  
  gamePaused=false;
}

void gameOfTestingFailMouse() // handles mouse input for fail screen
{
  if(mouseInBox(500,350,200,80))
  {
    gameOfTestingInit();
    screenID/=10; // go back to game
  }
}

void gameOfTestingFail1() // purple light turned off
{
  background(50);
  fill(#13E5C7);
  textFont(game_font,30); // fail message
  text("Oh no! You have turned off the purple light "
    +"and the guards have discovered you! You have "
    +"been thrown back into prison but have still not given up!",50,50,700,400);
    
  if(mouseInBox(500,350,200,80)) fill(#49DCE3); // mouse hovered over button
  else fill(#2FC2C9);
  rect(500,350,200,80);
  textFont(game_font,40);
  fill(0);
  text("Continue",515,405); // continue button (goes back to game)
}

void gameOfTestingFail2() // detected by motion detector laser
{
  background(50);
  fill(#13E5C7);
  textFont(game_font,30); // fail message
  text("Oh no! The motion detector has triggered an alarm "
    +"and the guards have discovered you! You have "
    +"been thrown back into prison but have still not given up!",50,50,700,400);
    
  if(mouseInBox(500,350,200,80)) fill(#49DCE3);
  else fill(#2FC2C9);
  rect(500,350,200,80);
  textFont(game_font,40);
  fill(0);
  text("Continue",515,405); // continue button (goes back to game)
}

void gameOfTestingFail3() // electrocuted
{
  background(50);
  fill(#13E5C7);
  textFont(game_font,25); // fail message
  text("Oh no! You have been electrocuted and seriously injured. "
    +"When one of your legs touched the 500 kilovolt wire and the other one "
    +"touched the ground (zero volts), electricity flowed "
    +"from the wire through your legs and into the ground. After 3 hours of intense "
    +"medical treatment (the gang still wants you alive), "
    +"you have decided to try to escape again! HINT: What keyboard "
    +"controls are you not using?",50,50,700,400);
    
  if(mouseInBox(500,350,200,80)) fill(#49DCE3);
  else fill(#2FC2C9);
  rect(500,350,200,80);
  textFont(game_font,40);
  fill(0);
  text("Continue",515,405); // continue button (goes back to game)
}

void drawGameExit() // exit arrow for game
{
  int exitX=700,exitY=270; // coordinates of arrow
  fill(#00DD00); // green
  beginShape();
  vertex(exitX,exitY+10);
  vertex(exitX+50,exitY+10);
  vertex(exitX+50,exitY+20);
  vertex(exitX+80,exitY);
  vertex(exitX+50,exitY-20);
  vertex(exitX+50,exitY-10);
  vertex(exitX,exitY-10);
  endShape(CLOSE);
}

void gameCompletedMouse()
{
  if(mouseInBox(500,350,200,80))
  {
    gameOfTestingInit();
    screenID=4; // go back to main menu
  }
}

void gameCompleted() // player beat the game
{
  background(50);
  fill(#00FF00);
  textFont(game_font,50); // congratulatory message
  text("YAY! You have escaped from the prison!",50,50,700,400);
    
  if(mouseInBox(500,350,200,80)) fill(#BBF2A9);
  else fill(#9CE385);
  rect(500,350,200,80);
  textFont(game_font,40);
  fill(0);
  text("Continue",515,405); // continue button (goes back to main menu)
}

void gameOfTesting()
{
  background(50);
  fill(#00DD00);
  textFont(game_font,25); // instructions for game
  text("To escape the base, you will need to turn off the motion "
    +"detector without turning off the purple light and then "
    +"cross the 500-kilovolt electrical wire. Good luck!",10,410,790,150);
  
  fill(#744D0F);
  rect(0,330,550,70,0,20,0,0); // only curve top right corner
                               // for the brown earth
  boolean motionDetectorOn=gameSwitch1Closed&&!gameSwitch2Closed;
  boolean lightOn=gameSwitch1Closed;
  
  drawWire(150,90,750,-50,480,100,#0F66F0); // wires for motion
  drawWire(300,200,400,170,320,150,#0F66F0); // detector and
  drawWire(325,155,350,120,375,100,#0F66F0); // purple light
  drawWire(155,90,185,110,215,155,#0F66F0);
  drawWire(45,90,-30,150,45,200,#0F66F0);
  drawWire(150,200,200,200,200,200,#0F66F0);
  
  drawSwitch(50,90,gameSwitch1Closed); // switch 1
  drawSwitch(220,150,gameSwitch2Closed); // switch 2
  if(lightOn) drawLightBulb(50,200,#A428F7);
  else drawLightBulb(50,200,150); // purple light
  drawBattery(200,200);  // battery
  drawMotionDetector(380,100,225,motionDetectorOn); // motion detector
  
  drawInsulator(600); // ceramic insulators that hold up the wire
  drawInsulator(660);
  drawInsulator(720);
  
  drawWire(560,350,560,330,580,330,#CD7F32); // electrocution wire
  drawWire(560,400,560,350,560,350,#CD7F32);
  drawWire(580,330,800,330,800,330,#CD7F32);
  
  gameOfTestingMovement();
  
  strokeWeight(3);
  line(0,400,800,400);
  strokeWeight(1);
  
  if(!lightOn) // purple light off
  {
    gamePaused=true; // disable all player input
    gameFailBanner(); // fail
    --gameTextDelay;
    if(gameTextDelay<=0)
    {
      screenID=71; // moves to fail screen 1
    }
  }
  else if(motionDetectorOn&&(characterX>=420&&characterX<=460))
  { // player detected by motion detector
    gamePaused=true; // disable all player input
    gameFailBanner(); // fail
    --gameTextDelay;
    if(gameTextDelay<=0)
    {
      screenID=72; // moves to fail screen 2
    }
  }
  else if(characterY==260&&(characterX>=545&&characterX<=565))
  { // player electrocuted
    gamePaused=true; // disable all player input
    gameFailBanner(); // fail
    --gameTextDelay;
    if(gameTextDelay<=0)
    {
      screenID=73; // moves to fail screen 3
    }
  }
  else if(characterX>750) // player beat the game
  {
    gamePaused=true; // disable all player input
    gameCompletedBanner(); // game completed
    --gameTextDelay;
    if(gameTextDelay<=0)
    {
      screenID=74; // moves to successful screen
    }
  }
  
  drawGameExit(); // draw exit arrow
  drawCharacter(); // draw character
  if(!gamePaused) // no gravity if game paused
  {
    if(characterX<20) characterX=20; // make sure character can't go off screen
    characterY+=characterSpeedY;
    if(characterY<260) characterSpeedY+=1; // gravitational acceleration
    else
    { // hit ground
      characterSpeedY=0; // no more speed
      characterY=260; // character on ground
    }
  }
}

void gameFailBanner() // fail banner for game
{
  fill(50);
  rect(0,400,800,100);
  fill(#DD0000); // red
  textFont(game_font,50);
  text("ESCAPE FAILED",220,460);
}

void gameCompletedBanner() // successful banner for game
{
  fill(50);
  rect(0,400,800,100);
  fill(#00DD00); // green
  textFont(game_font,50);
  text("ESCAPE SUCCESSFUL",190,460);
}

void goodbye() // goodbye screen
{
  background(50);
  textFont(game_font,40);
  fill(#1AA0D3);
  text("See you next time!\nCreated by Peter Ye",100,100);
  
  strokeWeight(20);
  stroke(#C4BC28);
  line(500,300,500,600); // spine of character
  line(500,380,600,450); // right arm
  line(500,380,400,360); // left arm
  strokeWeight(18);
  line(600,450,600,600);
  line(400,360,400+cos(armAngle)*100,360+sin(armAngle)*100);
  if(armAngle>25*PI/16) armAngleSpeed*=-1;
  else if(armAngle<5*PI/4) armAngleSpeed*=-1;
  armAngle+=armAngleSpeed;
  
  fill(#CBA779);
  stroke(0);
  strokeWeight(1);
  ellipse(500,300,100,100); // head of character
  fill(#EA8911);
  arc(500,300,120,120,PI,2*PI,CHORD); // hat of character
  
  ++exitWaves;
  if(exitWaves>=240) exit(); // exit the entire program
}

void setup() // loads font and sets screen size
{
  size(800,500);
  game_font=loadFont("game_font.vlw");
}

void draw() // determines what screen to display
{
  if(screenID==0) loadingBar();
  else if(screenID==1) introTime();
  else if(screenID==2) introAnimationPart1();
  else if(screenID==3) introAnimationPart2();
  else if(screenID==4) mainMenu();
  else if(screenID==5) instructions();
  else if(screenID==6) mazeOfLearning();
  else if(screenID==61) mazeStation1();
  else if(screenID==62) mazeStation2();
  else if(screenID==63) mazeStation3();
  else if(screenID==64) mazeStation4();
  else if(screenID==65) mazeCompleted();
  else if(screenID==7) gameOfTesting();
  else if(screenID==71) gameOfTestingFail1();
  else if(screenID==72) gameOfTestingFail2();
  else if(screenID==73) gameOfTestingFail3();
  else if(screenID==74) gameCompleted();
  else if(screenID==8) goodbye();
}

void mouseClicked() // determines what mouse processing method to use
{
  if(screenID==4) mainMenuMouse();
  else if(screenID==5) instructionsMouse();
  else if(screenID==61) mazeStation1Mouse();
  else if(screenID==62) mazeStation2Mouse();
  else if(screenID==63) mazeStation3Mouse();
  else if(screenID==64) mazeStation4Mouse();
  else if(screenID==65) mazeCompletedMouse();
  else if(screenID==7) gameOfTestingMouse();
  else if(screenID==71||screenID==72||screenID==73) gameOfTestingFailMouse();
  else if(screenID==74) gameCompletedMouse();
}

void keyPressed()  // determines what keyboard processing method to use
{
  if(screenID==6) mazeOfLearningKey();
  else if(screenID==7)
  {
    if(key=='w') gameWPressed=true; // allows muliple keys to be held at once
    else if(key=='a') gameAPressed=true;
    else if(key=='d') gameDPressed=true;
  }
}

void keyReleased()
{
  if(screenID==7)
  {
    if(key=='w') gameWPressed=false; // allows muliple keys to be held at once
    else if(key=='a') gameAPressed=false;
    else if(key=='d') gameDPressed=false;
  }
}
