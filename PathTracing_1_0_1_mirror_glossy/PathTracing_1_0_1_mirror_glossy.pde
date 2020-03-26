int MAXDEPTH = 4;

float RR_prob = 0.66;

void setup(){
  size(400, 400);
  PathTraceIntegrator path_tracer = new PathTraceIntegrator();
  BxDF gold_diff = new Lambertian(new Color(1.0, 0.8, 0.3));
  BxDF ground_diff = new Lambertian(new Color(1, 1, 1));
  BxDF red_emitt = new Lambertian(new Color(3, 0, 0), new Color(3, 0, 0));
  BxDF gray_emitt_plane = new Lambertian(new Color(0.2, 0.5, 0.2), new Color(0.2, 0.2, 0.2));
  BxDF mirror = new PerfectSpecular(new Color(0.6, 0.6, 1));
  BxDF glossy = new GlossySpecular(new Color(0.7, 1, 0.7), 10);
  
  Primitive sphere1 = new Sphere(new PVector(0, 0, 0), 18.0, gold_diff);
  path_tracer.primitives.add(sphere1);
  Primitive sphere2 = new Sphere(new PVector(-20, 22, 10), 6.25, red_emitt);
  path_tracer.primitives.add(sphere2);
  Primitive sphere3 = new Sphere(new PVector(20, -13, 25), 4, mirror);
  path_tracer.primitives.add(sphere3);
  Primitive sphere4 = new Sphere(new PVector(4, -8, 20), 8, glossy);
  path_tracer.primitives.add(sphere4);
  Primitive plane1 = new Plane(new PVector(0, -16, 0), new PVector(0, 1, 0), ground_diff);
  path_tracer.primitives.add(plane1);
  Primitive plane2 = new Plane(new PVector(0, 45, 0), new PVector(0, -1, 0), gray_emitt_plane);
  path_tracer.primitives.add(plane2);
  
  PVector eye = new PVector(-3, 0, 190);
  PVector focal = new PVector(0, 0, 0);
  float view_distance = 1000;
  PVector up = new PVector(0, 1, 0);
  int wid = 400;
  int hei = 400;
  int spp = 128;
  Camera cam = new Camera(eye, focal, view_distance, up, wid, hei, spp);
  noStroke();
  cam.render(path_tracer);
  save("C:/Users/uekaz/Documents/JupyterNotebook/sample.png");
}

void draw(){
  
}