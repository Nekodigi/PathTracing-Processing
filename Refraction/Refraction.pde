float na = 1.4;
float nb = 1;
float theta = 0;

void setup(){
  size(500, 500);
  
}

void draw(){
  background(255);
  translate(width/2, height/2);
  strokeWeight(1);
  line(-width/2, 0, width/2, 0);
  line(0, -height/2, 0, height/2);
  strokeWeight(5);
  float sinM = nb/na;
  float r = width/2;
  line(0, 0, -sin(theta)*r, -cos(theta)*r);
  if(sinM < sin(theta)){
    line(0, 0, sin(theta)*r, -cos(theta)*r);
  }else{
    float sb = sin(theta)*na/nb;
    line(0, 0, sb*r, sqrt(1-sb*sb)*r);
  }
  //theta += 0.01;
  //theta = theta % HALF_PI;
  theta = radians(45);
}