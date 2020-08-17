abstract class Primitive{
  protected BxDF bxdf;
  PVector origin;
  PVector normal;
  float r;
  int type;
  
  abstract Ray intersect(Ray ray);
}

class Sphere extends Primitive{
  
  Sphere(PVector origin, float r, BxDF bxdf){
    type = 0;
    this.origin = origin;
    this.r = r;
    this.bxdf = bxdf;
  }
  
  Ray intersect(Ray ray){
    PVector ray_dir = ray.d.copy();//.normalize();
    PVector temp = PVector.sub(ray.o, origin);
    float B = PVector.dot(ray_dir, temp);
    float C = PVector.dot(temp, temp)-r*r;
    float disc = B*B - C;
    Ray result = new Ray();
    
    if(disc < 0){
      return null;
    }
    
    float sqrt_disc = sqrt(disc);
    float tmin = (-B - sqrt_disc);
    if(tmin >= EPSILON){
      result.distance = tmin;
      result.o = ray.get_hitpoint(tmin);//hit point
      result.d = PVector.sub(result.o, origin).div(r);//normal
      return result;
    }
    
    float tmax = (-B + sqrt_disc);
    if(tmax >= EPSILON){
      result.distance = tmax;
      result.o = ray.get_hitpoint(tmax);//hit point
      result.d = PVector.sub(result.o, origin).div(r);//normal
      return result;
    }
    
    return null;
  }
  
  //void show(){
  //  sphere(origin ,r);
  //}
}

class Plane extends Primitive{
  
  Plane(PVector origin, PVector normal, BxDF bxdf){
    type = 1;
    this.origin = origin;
    this.normal = normal;
    this.bxdf = bxdf;
  }
  
  Ray intersect(Ray ray){
    PVector ray_dir = ray.d.copy();//.normalize();
    float denominator = PVector.dot(ray_dir, normal);
    Ray result = new Ray();
    if (denominator == 0.0){//division by zero
      return null;
    }
    float t = PVector.dot(normal, PVector.sub(origin, ray.o))/denominator;
    if(t >= EPSILON){
      result.distance = t;
      result.o = ray.get_hitpoint(t);
      result.d = normal;
      return result;
    }
    return null;
  }
  
  //void show(){
  //  PVector w = normal.copy().normalize();
  //  PVector v = new PVector(EPSILON, 1.0, EPSILON).cross(w);
  //  v = v.normalize();
  //  PVector u = new PVector();
  //  PVector.cross(v, w, u);
  //  stroke(0, 0, 255);
  //  line(new PVector(0, 0, 0), PVector.mult(w, 500));
  //  stroke(0, 255, 0);
  //  line(new PVector(0, 0, 0), PVector.mult(v, 500));
  //  stroke(255, 0, 0);
  //  line(new PVector(0, 0, 0), PVector.mult(u, 500));
  //}
}