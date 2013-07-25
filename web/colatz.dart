import 'dart:html';
import 'dart:math';

final CanvasRenderingContext2D context =
  (query("#canvas") as CanvasElement).context2D;
final ButtonElement drawButton = (query("#draw") as ButtonElement);
final InputElement textBox = (query("#number") as InputElement);

void main() {
  context.scale(4, 4);
  
  drawButton.onClick.listen((e) {
    var number = int.parse(textBox.value, onError: (_) => 0);
    draw(number);
  });
}

bool testBit(int number, int bit) => (number & (1 << bit)) != 0;

void draw(int n) {
  drawLine(n);
  
  while(n != 1) {
    if (n.isOdd) {
      n = 3 * n + 1;
    }
    else {
      n >>= 1;
    }
    
    drawLine(n);
  }
}

void drawLine(int number) {
  context
    ..save()
    ..fillStyle = 'blue';
  
  for(var j=0; j < 64; j++) {
    if (testBit(number, j)) {
      context.fillRect(63 - j, 0, 1, 1);
    }
  }
  
  context
    ..restore()
    ..translate(0, 1);
}

