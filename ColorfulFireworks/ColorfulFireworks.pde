//firework base program
//https://nekodigi.hatenablog.com/entry/2020/02/22/%E3%80%90Processing%E3%80%91%E8%8A%B1%E7%81%AB%E3%82%92%E4%BD%9C%E3%82%8B

import http.requests.*;

float grav = 0.01;
float len = 50;
float sw = 10;
ArrayList<Firework> fireworks = new ArrayList<Firework>();;

void setup(){
  fullScreen(P3D);
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(ADD);
  size(500, 500);
  
}

void requestData() {
  GetRequest get = new GetRequest("https://test.nekodigi.com/LedStatus/get.php"); 
  get.send();
  String res = get.getContent();
  if(res == null)return;
  if(!res.equals("")){
    PostRequest post = new PostRequest("https://test.nekodigi.com/LedStatus/update.php");
    post.addData("status", "");
    post.send();
  }
  switch(res){
    case "red":
      fireworks.add(new Firework(20, new PVector(width/2, height), new PVector(random(-4, 4), random(-10, -6))));
      fill(255, 0, 0);
      break;
    case "green":
      fireworks.add(new Firework(120, new PVector(width/2, height), new PVector(random(-4, 4), random(-10, -6))));
      fill(0, 255, 0);
      break;
    case "blue":
      fireworks.add(new Firework(240, new PVector(width/2, height), new PVector(random(-4, 4), random(-10, -6))));
      break;
    case "rainbow":
      for(int i=0; i<10; i++){
        fireworks.add(new Firework(random(360), new PVector(width/2, height), new PVector(random(-4, 4), random(-10, -6))));
      }
      //colorMode(HSB);
      //fill(frameCount*10%255, 255, 255);
      //colorMode(RGB);
      break; 
      
     
    default:
      //fill(255, 255, 255);
      break;
      
  }
}

void draw(){
  background(0);
  noFill();
  
  if (frameCount % 5 == 0) {
    thread("requestData");
  }
  






  for(int i = fireworks.size()-1; i >= 0; i--){
    Firework firework = fireworks.get(i);
    firework.update();
    firework.show();
    if(!firework.isAlive())fireworks.remove(i);
  }
}

class Firework{
  Spark spark;
  Trail trail = new Trail();
  float hue;
  
  Firework(float hue, PVector pos, PVector v){
    trail.pos = pos;
    trail.v = v;
    this.hue = hue;
    trail.sat = random(50, 80);
    trail.hue = hue;
  }
  
  void update(){
    if(trail != null){
      trail.update();
      if(trail.energy<0){
        spark = new Spark(trail.pos, hue);
        trail = null;
      }
    }
  }
  
  void show(){
    if(trail != null){
      trail.show();
    }
    if(spark != null){
      spark.update_show();
    }
  }
  
  boolean isAlive(){
    return (trail != null) || (spark != null);
  }
}

class Spark{
  ArrayList<Trail> trails = new ArrayList<Trail>();
  PVector center;
  
  Spark(PVector center, float hue){
    this.center = center;
    for(int i = 0; i < 100; i++){
      Trail trail = new Trail();
      trail.hue = hue+random(-20, 20);//randomize hue
      trail.sat = random(20, 100);
      trail.pos = center.copy();
      float theta = random(PI);
      float phi = random(TWO_PI);
      float r = 2;
      trail.v = new PVector(r*sin(theta)*cos(phi), r*sin(theta)*sin(phi), r*cos(theta));
      trails.add(trail);
    }
  }
  
  void update_show(){
    for(int i = trails.size()-1; i >= 0 ; i--){
      Trail trail = trails.get(i);
      trail.update();
      trail.add();
      trail.show();
      if(trail.energy < 0){
        trails.remove(i);
      }
    }
  }
}

class Trail{
  PVector pos = new PVector();
  PVector v = new PVector();
  ArrayList<PVector> ps = new ArrayList<PVector>();
  float energy=255;
  float hue;
  float sat;
  
  void update(){
    energy -= random(3);
    if(energy > 50){
      pos.add(v);
      v.add(new PVector(0, grav));
    }
    add();
  }
  
  void add(){
    add(pos.copy());
  }
  
  void add(PVector p){
    ps.add(p);
    if(ps.size()>len){
      ps.remove(0);
    }
  }
  
  void show(){
    float n = ps.size();
    PVector prevP = null;
    stroke(hue, sat, 100, energy);
    for(int i = 0; i < n; i++){
      strokeWeight(float(i)/n*sw);
      PVector p = ps.get(i);
      if(prevP != null && prevP.x != 0 && prevP.y != 0){
        line(p.x, p.y, p.z, prevP.x, prevP.y, prevP.z);
      }
      prevP = p;
    }
    endShape();
  }
}
