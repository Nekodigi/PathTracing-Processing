PVector orient_normal(PVector normal, PVector dir){
  if (PVector.dot(normal, dir) < 0.0){
    return PVector.mult(normal, -1);
  }else{
    return normal;
  }
}

PVector reflect_dir_out(PVector normal, PVector outgoing){
  float ndotwo = PVector.dot(normal, outgoing);
  return PVector.mult(outgoing, -1).add(PVector.mult(normal, 2*ndotwo));
}