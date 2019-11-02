class wall {
  private PVector start;
  private PVector end;
  private color c;

  wall() {
    float xs = random(width);
    float ys = random(height);
    start = new PVector(xs, ys, 0);
    float xe = random(width);
    float ye = random(height);

    while ( (xs == xe) && (ys == ye) ) {
      xe = random(width);
      ye = random(height);
    }
    end = new PVector(xe, ye, 0);

    int r = round( random(255) );
    int g = round( random(255) );
    int b = round( random(255) );

    c = color( r, g, b );
  }

  PVector getStart() {
    return start;
  }

  PVector getEnd() {
    return end;
  }

  int getColor() {
    return c;
  }

  boolean intersects( PVector p ) {
    if ( ( p == start ) || (p == end) ) {
      return true;
    } else {
      float dxc = p.x - start.x;
      float dyc = p.y - start.y;

      float dxl = start.x - end.x;
      float dyl = start.y - end.y;

      float cross = dxc * dyl - dyc * dxl;

      if ( cross == 0 ) {
        return true;
      } else {
        if ( abs(dxl) >= abs(dyl) ) {
          if ( dxl > 0 ) {
            return start.x <= p.x && p.x <= end.x;
          } else {
            return end.x <= p.x && p.x <= start.x;
          }
        } else {
          if ( dyl > 0 ) {
            return start.y <= p.y && p.y <= end.y;
          } else {
            return end.y <= p.y && p.y <= start.y;
          }
        }
      }
    }
  }

  void move() {
    float a = random(50);
    float b = random(50);
    float d = random(20) - 10.0;

    if ( a <= 25 ) {
      //move start
      if ( b <= 25 ) {
        //change x
        start.x += d;
        
        if (start.x < 0) {
          start.x = -start.x;
        }
        
        if (start.x > width) {
          start.x = width - (start.x - width);
        }
        
      } else {
        //change y
        if (start.y < 0) {
          start.y = -start.y;
        }
        
        if (start.y > height) {
          start.y = height - (start.y - height);
        }
      }
    } else {
      //move end
      if ( b <= 25 ) {
        //change x
        end.x += d;
        
        if (end.x < 0) {
          end.x = -end.x;
        }
        
        if (end.x > width) {
          end.x = width - (end.x - width);
        }
        
      } else {
        //change y
        end.y += d;
        
        if (end.y < 0) {
          end.y = -end.y;
        }
        
        if (end.y > height) {
          end.y = height - (end.y - height);
        }
      }
    }
  }

  void draw() {
    stroke(c);
    line( start.x, start.y, end.x, end.y );
  }
}
