abstract class BxDF{
  Color emission = new Color(0, 0, 0);
  Color albedo = new Color(0, 0, 0);
  
  BxDF(Color _albedo){
     this.albedo = _albedo;
  }
  
  BxDF(Color _albedo, Color _emission){
     this.albedo = _albedo;
     this.emission = _emission;
  }
  
  abstract Color f(PVector incoming, PVector outgoing, PVector normal);
  abstract Ray sample_f(PVector normal, PVector outgoing);
}

class Lambertian extends BxDF{
  
  Lambertian(Color _albedo){super(_albedo);}
  Lambertian(Color _albedo, Color _emission){super(_albedo, _emission);}
  
  Color f(PVector incoming, PVector outgoing, PVector normal){
    return albedo.div(PI);
  }
  
  Ray sample_f(PVector normal, PVector outgoing){
    PVector wi = orientedHemiDir(random(1), random(1), normal, 0.0);
    float pdf = PVector.dot(normal, wi)/PI;
    Ray ray = new Ray();
    ray.d = wi;
    ray.distance = pdf;
    return ray;
  }
}

class PerfectSpecular extends BxDF{
  
  PerfectSpecular(Color _albedo){super(_albedo);}
  PerfectSpecular(Color _albedo, Color _emission){super(_albedo, _emission);}
  
  Color f(PVector incoming, PVector outgoing, PVector normal){
    return albedo;
  }
  
  Ray sample_f(PVector normal, PVector outgoing){
    PVector wi = reflect_dir_out(normal, outgoing);
    float pdf = PVector.dot(normal, wi);
    Ray ray = new Ray();
    ray.d = wi;
    ray.distance = pdf;
    return ray;
  }
}

class GlossySpecular extends BxDF{
  float exp;
  
  GlossySpecular(Color _albedo, float _exp){
    super(_albedo); 
    exp = _exp;
  }
  GlossySpecular(Color _albedo, Color _emission, float _exp){
    super(_albedo, _emission);
    exp = _exp;
  }
  
  Color f(PVector incoming, PVector outgoing, PVector normal){
    PVector reflect_dir = reflect_dir_out(normal, incoming);
    float rdotwo = PVector.dot(reflect_dir, outgoing);
    if (rdotwo  > 0.0){
      return albedo.mult(pow(rdotwo, exp));
    }
    return new Color(0, 0, 0);
  }
  
  Ray sample_f(PVector normal, PVector outgoing){//like oriented hemi sampling
    PVector reflect_dir = reflect_dir_out(normal, outgoing);
    PVector w = reflect_dir;
    PVector v = new PVector(EPSILON, 1, EPSILON).cross(w);
    PVector u = new PVector(); PVector.cross(v, w, u);
    PVector p = sampleHemiSphere(random(1), random(1), exp);
    PVector wi = PVector.mult(u, p.x).add(PVector.mult(v, p.y)).add(PVector.mult(w, p.z));
    if (PVector.dot(normal, wi) < 0.0){
      wi = PVector.mult(u, p.x).add(PVector.mult(v, -p.y)).add(PVector.mult(w, p.z));
    }
    float phong_lobe = pow(PVector.dot(reflect_dir, wi), exp);
    float pdf = PVector.dot(normal, wi) * phong_lobe;
    Ray ray = new Ray();
    ray.d = wi;
    ray.distance = pdf;
    return ray;
  }
}