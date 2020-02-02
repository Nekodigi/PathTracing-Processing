PVector orient_normal(PVector normal, PVector dir){
  if (PVector.dot(normal, dir) < 0.0){
    return PVector.mult(normal, -1);
  }else{
    return normal;
  }
}