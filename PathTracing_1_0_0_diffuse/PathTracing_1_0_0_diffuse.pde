int MAXDEPTH = 4;

float RR_prob = 0.66;

void setup(){
  size(200, 200);
  PathTraceIntegrator path_tracer = new PathTraceIntegrator();
  BxDF gold_diff = new Lambertian(new Color(1.0, 0.8, 0.3));
  BxDF ground_diff = new Lambertian(new Color(0.15, 0.5, 0.15));
  BxDF red_emitt = new Lambertian(new Color(3, 0, 0), new Color(3, 0, 0));
  BxDF gray_emitt_plane = new Lambertian(new Color(0.2, 0.5, 0.2), new Color(0.2, 0.2, 0.2));
  
  Primitive sphere1 = new Sphere(new PVector(0, 0, 0), 9.0, gold_diff);
  path_tracer.primitives.add(sphere1);
  Primitive sphere2 = new Sphere(new PVector(-10, 11, 5), 3, red_emitt);
  path_tracer.primitives.add(sphere2);
  Primitive plane1 = new Plane(new PVector(0, -8, 0), new PVector(0, 1, 0), ground_diff);
  path_tracer.primitives.add(plane1);
  Primitive plane2 = new Plane(new PVector(0, 20, 0), new PVector(0, -1, 0), gray_emitt_plane);
  path_tracer.primitives.add(plane2);
  
  PVector eye = new PVector(-3, 0, 190);
  PVector focal = new PVector(0, 0, 0);
  float view_distance = 1000;
  PVector up = new PVector(0, 1, 0);
  int wid = 200;
  int hei = 200;
  int spp = 128;
  Camera cam = new Camera(eye, focal, view_distance, up, wid, hei, spp);
  noStroke();
  cam.render(path_tracer);
  save("C:/Users/uekaz/Documents/JupyterNotebook/sample.");
}

void draw(){
  
}