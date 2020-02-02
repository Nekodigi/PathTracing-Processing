class Color{
  float r, g, b;
  Color(float _r, float _g, float _b){
    r = _r;
    g = _g;
    b = _b;
  }
  
  color getColor(){
    return color(r, g, b);
  }
  
  Color add(Color c){
    return new Color(r+c.r, g+c.g, b+c.b);
  }
  
  Color sub(Color c){
    return new Color(r-c.r, g-c.g, b-c.b);
  }
  
  Color mult(Color c){
    return new Color(r*c.r, g*c.g, b*c.b);
  }
  
  Color div(Color c){
    return new Color(r/c.r, g/c.g, b/c.b);
  }
  
  Color mult(float x){
    return new Color(r*x, g*x, b*x);
  }
  
  Color div(float x){
    return new Color(r/x, g/x, b/x);
  }
}

//color Cadd(color a, color b){
//  return color(red(a)+red(b), green(a)+green(b), blue(a)+blue(b));
//}

//color Csub(color a, color b){
//  return color(red(a)-red(b), green(a)-green(b), blue(a)-blue(b));
//}

//color Cmult(color a, color b){
//  return color(red(a)*red(b), green(a)*green(b), blue(a)*blue(b));
//}

//color Cmult(color col, float x){
//  return color(red(col)*x, green(col)*x, blue(col)*x);
//}

//color Cdiv(color col, float x){
//  return Cmult(col, 1/x);
//}