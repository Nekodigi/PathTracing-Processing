class Camera extends Thread{
  PVector eye;
  PVector focal;
  float view_dist;
  PVector up;
  int wid, hei;
  int spp;
  PVector u, v, w;
  PathTraceIntegrator integrator;
  
  Camera(PVector eye, PVector focal, float view_dist, PVector up, int wid, int hei, int spp, PathTraceIntegrator integrator){
    this.eye = eye;
    this.focal = focal;
    this.view_dist = view_dist;
    this.up = up;
    this.wid = wid;
    this.hei = hei;
    this.spp = spp;
    this.integrator = integrator;
    compute_uvw();
  }
  
  void render(){
    Ray ray = new Ray();
    ray.o = eye;
    for (float x = 0; x < wid; x+=pixelSize){
      for (float y = 0; y < hei; y+=pixelSize){
        Color pixel = new Color(0, 0, 0);
        for(int s = 0; s < spp; s++){
          float sp_x = (x+random(1)) - wid/2;
          float sp_y = (y+random(1)) - hei/2;
          ray.d = get_direction(sp_x, sp_y);
          pixel = pixel.add(integrator.trace_ray(ray, 1));
        }
        pixel = pixel.div(spp);
        fill(pixel.mult(255).getColor());
        rect(x*1, hei-y*1-1, pixelSize, pixelSize);
      }
      println(x/wid*100+"%");
    }
  }
  
  PVector get_direction(float x, float y){
    return PVector.mult(u, x).add(PVector.mult(v, y)).sub(PVector.mult(w, view_dist)).normalize();
  }
  
  void compute_uvw(){
    w = PVector.sub(eye, focal).normalize();
    u = new PVector();PVector.cross(up, w, u);u.normalize();
    v = new PVector(); PVector.cross(w, u, v);v.normalize();
    //check for singularity. if condition met, camera orientation are hardcoded
    //camera Looking straight down
    if (eye.x == focal.x && eye.z == focal.z && focal.y < eye.y){
      u = new PVector(0, 0, 1);
      v = new PVector(1, 0, 0);
      w = new PVector(0, 1, 0);
    }
    if (eye.x == focal.x && eye.z == focal.z && focal.y > eye.y){
      u = new PVector(1, 0, 0);
      v = new PVector(0, 0, 1);
      w = new PVector(0, -1, 0);
    }
  }
}