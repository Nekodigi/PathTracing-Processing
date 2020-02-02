float scale = 1000;
float angle = 0;
ArrayList<PVector> ps = new ArrayList<PVector>();

void setup(){
  fullScreen(P3D);
  //size(500, 500, P3D);
  strokeWeight(20);
}

void draw(){
  background(255);
  translate(width/2, height/2);
  rotateX(angle);
  rotateY(angle);
  rotateZ(angle);
  PVector normal = new PVector(1, 0, 0).normalize();
  ps.add(orientedHemiDir(random(1), random(1), normal, 0).mult(scale));
  stroke(0);
  for(PVector p : ps){
    point(p);
  }
  angle+=0.01;
}