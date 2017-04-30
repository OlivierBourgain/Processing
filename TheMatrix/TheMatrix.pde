ArrayList<Stream> streams = new ArrayList<Stream>();
int symbolSize = 24;
 
PFont font;
 PFont fontJP;
void setup() {
  size(1200, 900);
  frameRate(30);
  font = loadFont("DroidSans-24.vlw");
  fontJP = loadFont("DroidSansJapanese-24.vlw");
  background(0);
  
  for(int i = 0; i < width /symbolSize; i++) {
    Stream stream = new Stream(i * symbolSize);
    streams.add(stream);
  }

}

void draw() {
  background(0, 150);
  for(Stream stream: streams) stream.render();
}

public class Symbol {
  int x;
  int y;
  char value;
  int switchInterval = round(random(10,50));
  
  public Symbol(int x, int y) {
    this.x = x;
    this.y = y;
    this.value = randomSymbol();
  }
  
  public char randomSymbol() {
      int charType = round(random(0, 5));
      if (charType > 1) {
        // set it to Katakana
           return (char) ( 0x30A0 + round(random(0, 96)));
      } else {
        // set it to numeric
           return (char) ( '0' + round(random(0, 9)));
      }
  }
  
  public void render(boolean highlight) {
    if (highlight) fill(180,255,180);
    else fill(0, 255, 70, 150);
    textSize(symbolSize);
    if (this.value <= '9')    textFont(font);
    else textFont(fontJP);
    
    pushMatrix();
    scale(-1, 1); // Invert the X scale to display the char backward
    text(this.value, -this.x, this.y);
    popMatrix();
    
    if (frameCount % switchInterval == 0)
      this.value = randomSymbol();
  }
}

public class Stream {
  int nbSymbols = round(random(5, 20));
  int tail = nbSymbols - 1; // last char displayed
  ArrayList<Symbol> symbols = new ArrayList<Symbol>();

  public Stream(int x) {
    for(int i = 0; i < height / symbolSize; i++) {
      symbols.add(new Symbol(x, i * symbolSize));
    }
    this.tail = round(random(0, height / symbolSize));
  }
  
  public void render() {
  
    for(int i = 0 ; i <= nbSymbols; i++) {
      int idx = (tail + i) % symbols.size();
      if (i == nbSymbols) symbols.get(idx).render(true);
      symbols.get(idx).render(false);
    }
    tail++;
    if (tail < 0) tail = symbols.size() - 1;
  }
}