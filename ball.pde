class ball {
  private PVector location;
  private PVector direction;
  private boolean bounced;
  private int numberBounces = 10;

  private static final float epsilon = 10;

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

  PVector getDirection() {
    return direction;
  }

  void setDirection( PVector d ) {
    direction = d;
  }

  void setFlag() {
    bounced = true;
  }

  void resetFlag() {
    bounced = false;
  }

  boolean getFlag() {
    return bounced;
  }

  boolean finished() {
    return (numberBounces == 0);
  }

  void bounce( wall w ) {
    if ( w.intersects( location ) ) {
      float t = direction.y;
      direction.y = direction.x;
      direction.x = -t;
    }
  }

  boolean intersects( PVector l ) {
    float dx = location.x - l.x;
    float dy = location.y - l.y;

    float d = sqrt( dx*dx + dy*dy );
    if (d < epsilon) {
      return true;
    }

    return false;
  }

  void bounce( ball b ) {
    if ( this == b) {
      return;
    }

    if ( getFlag() && b.getFlag() ) {
      return;
    }

    if ( finished() ) {
      return;
    }

    setFlag();
    b.setFlag();

    if ( b.intersects( location ) ) {      
      PVector db = b.getDirection();
      float dx = (db.x + direction.x) / 2;
      float dy = (db.y + direction.y) / 2;

      direction.x = dx;
      direction.y = dy;
      db.x = -dx;
      db.y = -dy;

      b.setDirection(db);

      numberBounces--;
    }
  }


  void draw() {
    stroke(255);
    fill(255);

    if ( ! finished() ) {
      circle( location.x, location.y, 2 );
    }
  }
}
