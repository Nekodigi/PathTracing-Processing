class Ray{
  PVector o, d;
  float distance;
  
  Ray(){}
  
  Ray(PVector o, PVector d){
    this.o = o;
    this.d = d;
  }
  
  PVector get_hitpoint(float t){
    return PVector.mult(d, t).add(o);
  }
  
  //void show(){
  //  line(o, PVector.add(o, PVector.mult(d, 1000)));
  //  sphere(o, 10);
  //  sphere(PVector.add(o, PVector.mult(d, 1000)), 10);
  //}
}