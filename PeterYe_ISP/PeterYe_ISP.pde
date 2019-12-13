int loadingBarLength=0;
final int loadingBarMaxLength=400;
PFont game_font;
int screenID;

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
  background(100);
  fill(#ED9D1D);
  ellipse(300,300,400,300);
}

void setup()
{
  size(800,500);
  game_font=loadFont("game_font.vlw");
  screenID=0;
}

void draw()
{
  if(screenID==0) loadingBar();
  else if(screenID==1) introAnimation();
}