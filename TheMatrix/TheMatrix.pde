ArrayList<Stream> streams = new ArrayList<Stream>();
int symbolSize = 24;
 
PFont font;
 PFont fontJP;
void setup() {
  size(1200, 900);
  frameRate(20);
  font = loadFont("DroidSans-24.vlw");
  fontJP = loadFont("DroidSansJapanese-24.vlw");
  background(0);
  
  for(int i = 0; i < width /symbolSize; i++) {
    Stream stream = new Stream(i * symbolSize, round(random(0, height)));
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
  int speed;
  int switchInterval = round(random(10,50));
  boolean highlight = false;
  
  public Symbol(int x, int y, int speed, boolean highlight) {
    this.x = x;
    this.y = y;
    this.value = randomSymbol();
    this.speed = speed;
    this.highlight = highlight;
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
  
  public void render() {
    if (highlight) fill(180,255,180);
    else fill(0, 255, 70, 150);
    textSize(symbolSize);
    if (this.value <= '9')    textFont(font);
    else textFont(fontJP);
    text(this.value, this.x, this.y);
    if (frameCount % switchInterval == 0)
      this.value = randomSymbol();
    rain();
  }
  
  public void rain() {
    if (y >= height) y = 0;
    this.y += speed;
  }
}

public class Stream {
  int speed = round(random(5,22));
  int nbSymbols = round(random(5, 35));
  ArrayList<Symbol> symbols = new ArrayList<Symbol>();

  
  
  public Stream(int x, int y) {
    boolean first = (round(random(0, 2)) == 0);
    for(int i = 0; i< nbSymbols; i++) {
      symbols.add(new Symbol(x, y - i * symbolSize, speed, first));
      first = false;
    }
  }
  
  public void render() {
    for(Symbol symbol: symbols) symbol.render();
  }
}