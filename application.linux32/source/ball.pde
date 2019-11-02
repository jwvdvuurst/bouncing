class ball {
  private PVector location;
  private PVector direction;
  
  ball() {
    float xb = random(width);
    float yb = random(height);
    
    location = new PVector( xb, yb );
    
    float xd = (random(20) - 10.0) / 5.0;
    float yd = (random(20) - 10.0) / 5.0;
    
    direction = new PVector( xd, yd );
  }
  
  void move() {
    location.x += direction.x;
    location.y += direction.y;
    
    if ((location.x <= 0) || (location.x >= width)) {
      direction.x = -direction.x;
    }
    
    if ((location.y <= 0) || (location.y >= height)) {
      direction.y = -direction.y;
    }
  }
  
  void bounce( wall w ) {
    if ( w.intersects( location ) ) {
      float t = direction.y;
      direction.y = direction.x;
      direction.x = -t;
    }
  }
  
  void draw() {
    stroke(255);
    fill(255);
    
    circle( location.x, location.y, 2 );
  }
}
