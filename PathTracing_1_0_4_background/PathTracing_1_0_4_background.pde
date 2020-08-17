int pixelSize = 20;
float worldScale = 1;
int spp = 5;//number of sampleing
float preScale = 25;
float view_distance = 5000;
int MAXDEPTH = 4;
float RR_prob = 0.66;

PathTraceIntegrator path_tracer = new PathTraceIntegrator();
PVector eye = new PVector(-3, 0, 190);
PVector focal = new PVector(0, 0, 0);
PVector up = new PVector(0, 1, 0);
Camera cam;
PImage bgImg;

void setup(){
  //size(800, 800);
  fullScreen(P3D);
  bgImg = loadImage("Free Panorama in Park.jpg");
  cam = new Camera(eye, focal, view_distance, up, width, height, spp, path_tracer);
  BxDF gold_diff = new Lambertian(new Color(1.0, 0.8, 0.3));
  BxDF ground_diff = new Lambertian(new Color(1, 1, 1));
  BxDF red_emitt = new Lambertian(new Color(3, 0, 0), new Color(3, 0, 0));
  BxDF gray_emitt_plane = new Lambertian(new Color(0.2, 0.5, 0.2), new Color(.3, .3, .3));
  BxDF mirror = new PerfectSpecular(new Color(0.6, 0.6, 1));
  BxDF glossy = new GlossySpecular(new Color(0.7, 1, 0.7), 10);
  
  path_tracer.primitives.add(new Sphere(new PVector(0, 0, 0).mult(worldScale), 18.0*worldScale, gold_diff));
  path_tracer.primitives.add(new Sphere(new PVector(-20, 22, 10).mult(worldScale), 6.25*worldScale, red_emitt));
  path_tracer.primitives.add(new Sphere(new PVector(20, -13, 25).mult(worldScale), 4*worldScale, glossy));
  path_tracer.primitives.add(new Sphere(new PVector(4, -8, 20).mult(worldScale), 8*worldScale, mirror));
  path_tracer.primitives.add(new Plane(new PVector(0, -16, 0).mult(worldScale), new PVector(0, 1, 0), ground_diff));
  //path_tracer.primitives.add(new Plane(new PVector(0, 45, 0).mult(worldScale), new PVector(0, -1, 0), gray_emitt_plane));
  noStroke();
  
}

void keyPressed(){
  if(key == 'r'){
    if(pixelSize == 20){
      pixelSize = 1;
    }
  }
}

void draw(){
  
  cam.render();
  path_tracer.primitives.get(1).origin = new PVector((float)(mouseX-width/2)/30, (float)(height/2 - mouseY)/30, 0);
  if(pixelSize == 1){
    //pixelSize = 20;
    save("sample.png");
  }
  //translate(width/2, height/2);
  //lights();
  //fill(255);
  //for(Primitive primitive : path_tracer.primitives){
  //  pushMatrix();
  //  translate(PVector.mult(new PVector(primitive.origin.x, -primitive.origin.y, primitive.origin.z), preScale));
  //  switch(primitive.type){
  //    case 0:
  //      sphere(primitive.r*preScale);
  //      break;
  //    case 1:
        
  //      break;
  //  }
  //  popMatrix();
  //}
}
