PVector sampleHemiSphere(float u1, float u2, float exp){
  float z = pow(1.0 - u1, 1.0 / (exp + 1.0));
  float phi = TWO_PI * u2;
  float theta = sqrt(max(0.0, 1.0 - z*z));
  PVector p = new PVector(theta*cos(phi), theta*sin(phi), z);
  return p;
}

PVector orientedHemiDir(float u1, float u2, PVector normal, float exp){
  PVector p = sampleHemiSphere(u1, u2, exp);
  PVector w = normal.copy();
  PVector v = new PVector(EPSILON, 1.0, EPSILON).cross(w);
  v = v.normalize();
  PVector u = new PVector();
  PVector.cross(v, w, u);
  PVector hemi_dir = u.mult(p.x).add(v.mult(p.y)).add(w.mult(p.z));
  return hemi_dir.normalize();
}
