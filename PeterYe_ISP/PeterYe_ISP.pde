int loadingBarLength=0;
final int loadingBarMaxLength=400;
PFont game_font;
int screenID=2;

int introTimeDisplay=0;
int helicopterX=0,helicopterY=200;
float gangX1=300,gangY1=200;
float gangX2=300,gangY2=200;
float characterX=310,characterY=370;
float bagAngle=0;

void loadingBar()
{
  background(50);
  noStroke();
  
  int loadPercentage=loadingBarLength*100/loadingBarMaxLength;
  fill(#4CF3FA);
  textFont(game_font,60);
  text("Megavolt's Escape",150,150);
  fill(#7CA718);
  textFont(game_font,30);
  text("Loading "+loadPercentage+"%",300,300);
  
  fill(255);
  rect(395-loadingBarMaxLength/2,195,loadingBarMaxLength+10,60);
  fill(#3DC622);
  
  
  rect(400-loadingBarMaxLength/2,200,loadingBarLength,50);
  ++loadingBarLength;
  if(loadingBarLength>loadingBarMaxLength) ++screenID;
}

void introTime()
{
  background(50);
  textFont(game_font,50);
  fill(#EDE83E);
  text("One Week Ago ...",180,200);
  ++introTimeDisplay;
  if(introTimeDisplay>=180) ++screenID;
}

void drawHelicopter()
{
  stroke(80);
  strokeWeight(20);
  line(helicopterX,helicopterY-50,helicopterX,helicopterY-100);
  stroke(#DBCA2A);
  line(helicopterX-150,helicopterY-100,helicopterX+150,helicopterY-100);
  stroke(#D3C011);
  line(helicopterX-100,helicopterY-50,helicopterX+100,helicopterY-150);
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
  fill(80);
  ellipse(helicopterX,helicopterY-100,20,20);
  fill(#20C9B9);
  rect(helicopterX-50,helicopterY-20,100,40);
}

void drawGang(float gangX,float gangY)
{
  fill(0);
  strokeWeight(1);
  ellipse(gangX,gangY,30,30);
  strokeWeight(8);
  line(gangX,gangY,gangX,gangY+50);
  line(gangX,gangY+30,gangX-20,gangY+10);
  line(gangX,gangY+30,gangX+20,gangY+10);
  line(gangX,gangY+50,gangX-20,gangY+70);
  line(gangX,gangY+50,gangX+20,gangY+70);
}

void drawCharacter()
{
  strokeWeight(8);
  line(characterX,characterY,characterX,characterY+50);
  line(characterX,characterY+30,characterX-20,characterY+10);
  line(characterX,characterY+30,characterX+20,characterY+10);
  line(characterX,characterY+50,characterX-20,characterY+70);
  line(characterX,characterY+50,characterX+20,characterY+70);
  fill(#CBA779);
  strokeWeight(1);
  ellipse(characterX,characterY,30,30);
  fill(#EA8911);
  arc(characterX,characterY,40,40,PI,2*PI,CHORD);
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
  if(helicopterX<300) ++helicopterX;
  else
  {
    drawGang(gangX1,gangY1);
    drawGang(gangX2,gangY2);
    drawStick();
    drawBag();
    if(gangY1<=370)
    {
      gangX1-=1;
      gangX2+=0.5;
      ++gangY1;
      ++gangY2;
    }
    else
    {
      if(bagAngle<PI/2) bagAngle+=0.01;
      else
      {
        gangX1+=1.2;
        ++gangX2;
        ++characterX;
        if(gangX1>850)
        {
          ++screenID;
          gangX1-=800;
          characterX-=800;
          gangX2-=800;
        }
      }
    }
  }
}

void drawBuildingLeft()
{
  fill(#9EB45D);
  rect(400,450,300,-400);
  fill(50);
  rect(630,450,70,-150);
  fill(#159BCE);
  rect(450,250,100,70);
  strokeWeight(10);
  
  
}

void drawBuildingRight()
{
  fill(#9EB45D);
  rect(700,450,200,-400);
  stroke(#9EB45D);
  line(700,50,700,450);
  stroke(0);
}

void drawBanner()
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
  ++gangX1;
  ++gangX2;
  ++characterX;
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
}
