
ArrayList<wall> walls;
ArrayList<ball> balls;

int numberWalls = 0;
int numberBalls = 2500;

void setup() {
  fullScreen();
  //  size(800,800);
  background(0);

  walls = new ArrayList<wall>();
  balls = new ArrayList<ball>();

  for ( int i = 0; i<numberWalls; i++ ) {
    wall w = new wall();

    walls.add(w);
  }

  for ( int i = 0; i<numberBalls; i++ ) {
    ball b = new ball();

    balls.add(b);
  }
}

void draw() {
  clear();
  for ( wall wd : walls ) {
    wd.draw();
  }
  
  int active=0;
  for (ball b : balls ) {
    if ( ! b.finished() ) {
      active++;
    }
  }
  
  fill(128);
  textSize(64);
  text( active, width / 2, height / 2 );

  for ( ball b : balls ) {
    b.resetFlag();
    b.draw();

    b.move();

    for ( wall wd : walls ) {
      b.bounce(wd);
      wd.move();
    }
    
    for( ball other : balls ) {
      b.bounce(other);
    }
  }
}
