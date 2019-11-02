import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class bouncing extends PApplet {


ArrayList<wall> walls;
ball b;

public void setup() {
  
  background(128);
  
  walls = new ArrayList<wall>();
  
  for( int i = 0; i<5; i++ ) {
      wall w = new wall();
  
      walls.add(w);
  }
  
  b = new ball();
 
}

public void draw() {
  clear();
  for( wall wd : walls ) {
    wd.draw();
  }

  b.draw();
  
  b.move();
  
  for( wall wd : walls ) {
    b.bounce(wd);
    wd.move();
  }
  
}

class ball {
  private PVector location;
  private PVector direction;
  
  ball() {
    float xb = random(width);
    float yb = random(height);
    
    location = new PVector( xb, yb );
    
    float xd = (random(20) - 10.0f) / 5.0f;
    float yd = (random(20) - 10.0f) / 5.0f;
    
    direction = new PVector( xd, yd );
  }
  
  public void move() {
    location.x += direction.x;
    location.y += direction.y;
    
    if ((location.x <= 0) || (location.x >= width)) {
      direction.x = -direction.x;
    }
    
    if ((location.y <= 0) || (location.y >= height)) {
      direction.y = -direction.y;
    }
  }
  
  public void bounce( wall w ) {
    if ( w.intersects( location ) ) {
      float t = direction.y;
      direction.y = direction.x;
      direction.x = -t;
    }
  }
  
  public void draw() {
    stroke(255);
    fill(255);
    
    circle( location.x, location.y, 2 );
  }
}
class wall {
  private PVector start;
  private PVector end;
  private int c;

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

  public PVector getStart() {
    return start;
  }

  public PVector getEnd() {
    return end;
  }

  public int getColor() {
    return c;
  }

  public boolean intersects( PVector p ) {
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

  public void move() {
    float a = random(50);
    float b = random(50);
    float d = random(20) - 10.0f;

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

  public void draw() {
    stroke(c);
    line( start.x, start.y, end.x, end.y );
  }
}

  public void settings() {  size(800,800); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#000000", "--stop-color=#cccccc", "bouncing" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
