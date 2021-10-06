import java.util.Map;
import java.util.*;


public float size = 1000, norm_size = 300;


public Vector anchor;
HashMap<Float, List_> hash_table;

class List_{
  
  public ArrayList<Vector> bucket = new ArrayList<Vector>();
  
  public List_(){
    this.bucket = bucket;
  }
  
  public void add(Vector v){
    this.bucket.add(v);
  }
}

class Vector{
  
  public float x;
  public float y;
  public float len;
  
  public Vector(float x, float y){
    this.x = x;
    this.y = y;
    this.len = sqrt(x*x + y*y);
  }
  
  public float dot(Vector v){
    return (this.x * v.x) + (this.y * v.y);
  }
  
  public float angle(Vector v){
    return (this.dot(v)) / (this.len * v.len);
  }
  
  public void normalize(float scale){
    this.len = sqrt(this.x*this.x + this.y*this.y);
    if(this.len < 1.1 && this.len > 0.9){
    }else{
      this.x = scale * (this.x / this.len);
      this.y = scale * (this.y / this.len);
      
    }
  }
}

void hashed(Vector v, Vector anchor){
  float ang = floor(v.angle(anchor) * size);
  
  try{
     hash_table.get(ang).add(v);
  
  }catch (Exception e){
     List_ bucket = new List_();
     bucket.add(v);
     
     hash_table.put(ang, bucket);
  }
  
}

void setup(){
  size(1200, 800);
  
  hash_table = new HashMap<Float,List_>();
  anchor = new Vector(random(2)-1, random(2)-1);
  
  for(int i = 0; i < 1000; i++){
    Vector v = new Vector(random(2)-1, random(2)-1);
    hashed(v, anchor);
  }
}

void draw(){
  background(0);
  
  stroke(255);
  strokeWeight(5);
  
  anchor.normalize(320);
  line(width/2, height/2, (width/2) + anchor.x, (height/2) + anchor.y);
  
  float threshold = map(mouseY, 50, height-50, -999, 999);
  double count = 0, total = 0;
  
  
  strokeWeight(2);
  for(Map.Entry<Float, List_> item : hash_table.entrySet()){
    
    float key_ = item.getKey();
    
    if(key_ > threshold){
      count++;
      float c = map((float)(item.getKey()), (float)-size, (float)size, (float)0, (float)255);
      stroke(255 - c, c, c);
    
      item.getValue().bucket.get(0).normalize(300);
      float x = item.getValue().bucket.get(0).x;
      float y = item.getValue().bucket.get(0).y;
     
      x = (width/2) + x;
      y = (height/2) + y;
      
      line(width/2, height/2, x, y);
    }
    total++;
  }
  
  textSize(24);
  String s = "Current Index Threshold: " + (int)(Math.max(Math.min(Math.floor(threshold), 1000), -1000));
  fill(255, 255, 255);
  text(s, 15, 15, 700, 400);
  
  textSize(24);
  s = "Percent Above Threshold: " + (int)(Math.round( (count / total) * 100 )) + "%";
  fill(255, 255, 255);
  text(s, 15, 45, 700, 400);
  
  textSize(24);
  s = "Teal: [999, 998, 997, ...";
  fill(0, 255, 255);
  text(s, 15, 75, 700, 400);
  
  s = "Gray: ...2, 1, 0, -1, -2...";
  fill(150, 150, 150);
  text(s, 15, 105, 700, 500);
  
  s = "Red: ...-998, -999]";
  fill(255, 0, 0);
  text(s, 15, 135, 700, 500);
  
  s = "Press 'a' to Reset";
  fill(255, 255, 255);
  text(s, 15, 165, 700, 500);
  
}

void keyPressed() {
  System.out.println(key);
  if(key == 'a'){
    setup();
  }
}
