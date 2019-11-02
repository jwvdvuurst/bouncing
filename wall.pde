class wall {
  private PVector start;
  private PVector end;
  private color c;

  private static final float epsilon = 2;

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
    float spx = start.x - p.x;
    float spy = start.y - p.y;
    float pex = p.x - end.x;
    float pey = p.y - end.y;
    float sex = start.x - end.x;
    float sey = start.y - end.y;
    
    float sp = sqrt( spx*spx + spy*spy );
    float pe = sqrt( pex*pex + pey*pey );
    float se = sqrt( sex*sex + sey*sey );
    
    float d = sp+pe - se;
    
    if ( d < epsilon ) {
      return true;
    } else {
      return false;
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
