/* Peter Ye
January 3, 2020
ICS20 ISP
Megavolt's Escape
I used processing.org as a reference while completing this project.
*/

int loadingBarLength=0;
final int loadingBarMaxLength=400;
PFont game_font;
int screenID=6;

int introTimeDisplay=0;
int helicopterX=0,helicopterY=200;
float helicopterBladeAngle=0;
float gangX1=300,gangY1=200;
float gangX2=300,gangY2=200;
float characterX=310,characterY=370;
int mazeCharacterX=1,mazeCharacterY=0;
float bagAngle=0;

int mazeStationTextDelay=0;
int exitWaves=0;

int[][] mazeVerticalWalls={
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

int[][] mazeHorizontalWalls={
{1,1,1,1,1,1,1,1},
{0,0,1,1,1,1,1,0},
{0,0,0,1,1,1,1,0},
{0,0,0,0,0,0,0,0},
{0,0,0,0,1,0,0,0},
{1,1,1,1,1,1,1,1}
};

boolean mazeStation1Done=false;
boolean mazeStation2Done=false;
boolean mazeStation3Done=false;
boolean mazeStation4Done=false;

boolean mazeStation1SwitchClosed=false;
boolean mazeStation2SwitchClosed=false;

boolean mouseInBox(int x,int y,int boxLength,int boxHeight) // returns whether mouse is in a given rectangular box
{
  return mouseX>=x&&mouseX<=x+boxLength&&mouseY>=y&&mouseY<=y+boxHeight;
}

void loadingBar()
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
  ellipse(helicopterX,helicopterY,200,100);
  ellipse(helicopterX-200,helicopterY-20,30,80);
  fill(#20C9B9);
  rect(helicopterX-50,helicopterY-20,100,40);
  strokeWeight(20);
  stroke(#D3C011);
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

void drawBag()
{
  fill(#0C3981);
  strokeWeight(1);
  quad(gangX2-20,gangY2+15,
    gangX2-20+cos(bagAngle)*40,gangY2+15-sin(bagAngle)*40,
    gangX2-20+cos(bagAngle+atan(6/4))*sqrt(5200),gangY2+15-sin(bagAngle+atan(6/4))*sqrt(5200),
    gangX2-20+cos(bagAngle+PI/2)*60,gangY2+15-sin(bagAngle+PI/2)*60);
}

void drawStick()
{
  fill(#814C0C);
  strokeWeight(1);
  rect(gangX1+20,gangY1+5,30,8);
}

void introAnimationPart1()
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

void introAnimationPart2()
{
  background(150);
  fill(#B45DB3);
  rect(0,400,800,100);
  drawBuildingLeft();
  drawGang(gangX1,gangY1);
  drawGang(gangX2,gangY2);
  drawCharacter();
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
  text("Instructions",240,110);
  textFont(game_font,40);
  text("Maze of Learning",230,200);
  text("Game of Testing",230,300);
  textFont(game_font,60);
  text("Exit",330,410);
}

void mainMenuMouse()
{
  if(mouseInBox(200,50,400,80)) ++screenID; // instructions
  else if(mouseInBox(200,150,400,80)) screenID+=2; // maze of learning
  else if(mouseInBox(200,250,400,80)) screenID+=3; // game of testing
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

void drawMazeWalls()
{
  strokeWeight(10);
  stroke(#8B4EE3);
  for(int i=0;i<mazeVerticalWalls.length;++i)
  {
    for(int j=0;j<mazeVerticalWalls[i].length;++j)
    {
      if(mazeVerticalWalls[i][j]==1) line(i*100,j*100,i*100,j*100+100); // vertical walls
    }
  }
  for(int i=0;i<mazeHorizontalWalls.length;++i)
  {
    for(int j=0;j<mazeHorizontalWalls[i].length;++j)
    {
      if(mazeHorizontalWalls[i][j]==1) line(j*100,i*100,j*100+100,i*100); // horizontal walls
    }
  }
}

void drawMazeCharacter()
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
  beginShape();
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
  ellipse(tempStationX,tempStationY,80,40);
  
  if(done) fill(#00DD00); // green bolt if done
  else fill(#DD0000); // red otherwise
  
  drawLightningBolt(tempStationX-30,tempStationY+10,0.55);
}

void mazeOfLearning()
{
  background(50);
  drawMazeWalls();
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
}

void drawBattery(int x,int y)
{
  fill(150);
  rect(x-10,y-10,120,20);
  fill(100);
  rect(x,y-20,100,40,8);
  fill(#DECF28);
  drawLightningBolt(x+10,y+10,0.8);
}

void drawLightBulb(int x,int y,color c)
{
  fill(150);
  rect(x-10,y-10,120,20);
  fill(100);
  rect(x,y-25,100,50,8);
  fill(c);
  ellipse(x+50,y-30,30,70);
  strokeWeight(2);
  stroke(#B77421);
  line(x,y,x+46,y);
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
  fill(100);
  rect(x,y-25,100,50,8);
  fill(150);
  rect(x+10,y,15,-50);
  rect(x+75,y,15,-50);
  
  //fill(#DECF28);
  //drawLightningBolt(x+10,y+10,0.8);
}

boolean mouseInSwitch(int x,int y)
{
  return mouseInBox(x,y-25,100,50);
}

void mazeStation1Mouse()
{
  if(!mazeStation1Done&&mouseInSwitch(520,200)) mazeStation1SwitchClosed=!mazeStation1SwitchClosed;
  // toggle switch
}

void drawWire(int x1,int y1,int x2,int y2,int x3,int y3,color c)
{
  noFill();
  stroke(c);
  strokeWeight(3);
  beginShape();
  vertex(x1,y1);
  quadraticVertex(x2,y2,x3,y3);
  endShape();
  strokeWeight(1);
  stroke(0);
}

void mazeStation1()
{
  background(#58E0DF);
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,30);
  text("An electrical switch can control the flow of electricity. "
    +"You can toggle a switch by clicking on it. Toggle the switch "
    +"in the circuit above to turn the light on.",10,360,800,150);
  
  drawWire(420,300,700,300,620,200,#DD0000);
  drawWire(520,200,450,180,380,140,#411BDE);
  drawWire(280,140,200,200,320,300,#AD10C6);
  drawBattery(320,300);
  if(mazeStation1SwitchClosed) drawLightBulb(280,140,#DDDD00);
  else drawLightBulb(280,140,150);
  
  drawSwitch(520,200,mazeStation1SwitchClosed);
  
  
  if(mazeStation1SwitchClosed)
  {
    mazeStation1Done=true;
    --mazeStationTextDelay;
    if(mazeStationTextDelay<=0)
    {
      screenID/=10;
    }
  }
}

void mazeStation2()
{
  background(#58E0DF);
  fill(50);
  strokeWeight(3);
  line(0,350,800,350);
  strokeWeight(1);
  textFont(game_font,25);
  text("A series circuit is a circuit which has multiple "
    +"electrical loads connected together to form one path. "
    +"A switch in a series circuit will turn off all of the loads "
    +"when switched off. Toggle the switch above to turn off "
    +"both the red light and the green light.",10,360,790,150);
  
  drawWire(420,300,700,300,620,200,#DD0000);
  drawWire(520,200,450,180,380,140,#411BDE);
  drawWire(280,140,200,200,320,300,#AD10C6);
  drawBattery(320,300);
  if(mazeStation2SwitchClosed) drawLightBulb(280,140,#DDDD00);
  else drawLightBulb(280,140,150);
  
  drawSwitch(620,200,mazeStation2SwitchClosed);
  
  
  if(mazeStation2SwitchClosed)
  {
    mazeStation2Done=true;
    --mazeStationTextDelay;
    if(mazeStationTextDelay<=0)
    {
      screenID/=10;
    }
  }
}

void mazeStation3()
{
  background(50);
  text("Station 3",50,50);
  --mazeStationTextDelay;
  if(mazeStationTextDelay<=0)
  {
    screenID/=10;
    mazeStation3Done=true;
    //++mazeCharacterY;
  }
}

void mazeStation4()
{
  background(50);
  text("Station 4",50,50);
  --mazeStationTextDelay;
  if(mazeStationTextDelay<=0)
  {
    screenID/=10;
    mazeStation4Done=true;
    //++mazeCharacterX;
  }
}

void gameOfTesting() {}

void goodbye()
{
  background(50);
  textFont(game_font,60);
  fill(#1AA0D3);
  text("See you next time!\nCreated by Peter Ye",100,200);
  ++exitWaves;
  if(exitWaves>=120) exit(); // exit the entire program
}

void setup()
{
  size(800,500);
  game_font=loadFont("game_font.vlw");
}

void draw()
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
  else if(screenID==7) gameOfTesting();
  else if(screenID==8) goodbye();
}

void mouseClicked()
{
  if(screenID==4) mainMenuMouse();
  else if(screenID==5) instructionsMouse();
  else if(screenID==61) mazeStation1Mouse();
}

void keyPressed()
{
  if(screenID==6) mazeOfLearningKey();
}