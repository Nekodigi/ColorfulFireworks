import http.requests.*;
//https://test.nekodigi.com/LedStatus/index.php


void setup(){
  size(500, 500);
  //fullScreen();
}

void draw(){
  //GetRequest get = new GetRequest("http://127.0.0.1/LedStatus/LedGet.php"); 
  GetRequest get = new GetRequest("https://test.nekodigi.com/LedStatus/get.php"); 
  get.send();
  String res = get.getContent();
  println(res);
  switch(res){
    case "red":
      fill(255, 0, 0);
      break;
    case "green":
      fill(0, 255, 0);
      break;
    case "blue":
      fill(0, 0, 255);
      break;
    case "rainbow":
      colorMode(HSB);
      fill(frameCount*10%255, 255, 255);
      colorMode(RGB);
      break; 
      
     
    default:
      //fill(255, 255, 255);
      break;
      
  }
  
  rect(0, 0, width, height);
}
