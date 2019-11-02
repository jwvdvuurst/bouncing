
ArrayList<wall> walls;
ball b;

void setup() {
  size(800,800);
  background(128);
  
  walls = new ArrayList<wall>();
  
  for( int i = 0; i<5; i++ ) {
      wall w = new wall();
  
      walls.add(w);
  }
  
  b = new ball();
 
}

void draw() {
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
