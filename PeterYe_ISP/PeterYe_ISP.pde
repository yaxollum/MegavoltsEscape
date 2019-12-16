int loadingBarLength=0;
final int loadingBarMaxLength=400;
PFont game_font;
int screenID=1;

int helicopterX=0,helicopterY=200;

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

void introAnimation()
{
  background(150);
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
  fill(80);
  ellipse(helicopterX,helicopterY-100,20,20);
  fill(#20C9B9);
  rect(helicopterX-50,helicopterY-20,100,40);
  if(helicopterX<300) ++helicopterX;
  
}

void setup()
{
  size(800,500);
  game_font=loadFont("game_font.vlw");
}

void draw()
{
  if(screenID==0) loadingBar();
  else if(screenID==1) introAnimation();
}
