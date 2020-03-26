class PathTraceIntegrator{
  ArrayList<Primitive> primitives = new ArrayList<Primitive>();
  
  PathTraceIntegrator(){}
  
  Color trace_ray(Ray ray, float depth){
    Color result = new Color(0, 0, 0);
    float t = Float.POSITIVE_INFINITY;
    Primitive hit_obj = null;
    PVector hit_point = null;
    PVector normal = null;
    
    if (depth > MAXDEPTH){
      return result;
    }
    
    for(Primitive primitive : primitives){
      Ray hit_data = primitive.intersect(ray);
      if(hit_data != null){
        if (hit_data.distance < t){
          t = hit_data.distance;
          hit_point = hit_data.o;
          normal = hit_data.d;
          hit_obj = primitive;
        }
      }
    }
    
    if(hit_obj == null){
      return new Color(0, 0, 0);
    }else{
      PVector wo = PVector.mult(ray.d, -1);
      //normal = orient_normal(normal, wo);
      Ray shading_data = hit_obj.bxdf.sample_f(normal, wo, ray.n);
      PVector wi = shading_data.d;
      float pdf = shading_data.distance;
      if (pdf <= 0.0){
        pdf = 1;
      }
      Color f = hit_obj.bxdf.f(wi, wo, normal);
      Ray incoming_ray = new Ray(PVector.mult(wi, EPSILON*10).add(hit_point), wi);
      
      float RR_prob = 0.66;
      if (depth > 2){
        if(random(1) < RR_prob){
          return result;
        }
      }
      
      result = result.add(f.mult(trace_ray(incoming_ray, depth + 1)).mult(PVector.dot(wi, normal)).div(pdf));
      result = result.add(hit_obj.bxdf.emission);
      result = result.div(RR_prob);
    }
    return result;
  }
}