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
      float phi = atan2(sqrt(ray.d.x*ray.d.x+ray.d.z*ray.d.z), ray.d.y);
      float theta = atan2(ray.d.z, ray.d.x);
      int i = (int)map(theta, -PI, PI, 0, bgImg.width-1);
      int j = (int)map(abs(phi), 0, PI, 0, bgImg.height-1);
      i = i%bgImg.width;
      j = j%bgImg.height;
      return new Color(bgImg.pixels[i+j*bgImg.width]).div(255);//go out
    }else{
      PVector wo = PVector.mult(ray.d, -1);
      normal = orient_normal(normal, wo);
      Ray shading_data = hit_obj.bxdf.sample_f(normal, wo);
      PVector wi = shading_data.d;
      float pdf = shading_data.distance;
      if (pdf <= 0.0){
        pdf = 1;
      }
      Color f = hit_obj.bxdf.f(wi, wo, normal);
      Ray incoming_ray = new Ray(hit_point, wi);
      
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
