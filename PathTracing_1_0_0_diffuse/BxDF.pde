abstract class BxDF{
  Color emission = new Color(0, 0, 0);
  
  abstract Color f();
  abstract Ray sample_f(PVector normal);
}

class Lambertian extends BxDF{
  Color diffuse = new Color(0, 0, 0);
  
  Lambertian(Color _diffuse){
    this.diffuse = _diffuse;
  }
  
  Lambertian(Color diffuse, Color _emission){
    this(diffuse);
    this.emission = _emission;
  }
  
  Color f(){
    return diffuse.div(PI);
  }
  
  Ray sample_f(PVector normal){
    PVector wi = orientedHemiDir(random(1), random(1), normal, 0.0);
    float pdf = PVector.dot(normal, wi)/PI;
    Ray ray = new Ray();
    ray.d = wi;
    ray.distance = pdf;
    return ray;
  }
}