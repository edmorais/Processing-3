int steps = 60; // numero de traços do triangulo
int step = 0;
int fase = 0; // cada 4 triangulos = 1 fase
int corn = 0; // numero da cor actual

float xo = 0; 
float yo = 0; // 'origem' da fase actual
float x, y;

color cor[] = {
  color(0, 96, 255), 
  color(192, 64, 0), 
  color(0, 160, 64), 
  color(128, 0, 192)
}; // lista de cores

void setup() {
  size(800, 600);
  background(255);
  noFill();
  stroke(cor[corn]);
  smooth();
}

void draw() {
  if (step < steps) {
    // a desenhar triangulo:
    if (fase%2 == 0) {
      // fase par / triangulos nos cantos:

      x = map(step, 0, steps, width/2, xo);
      y = map(step, 0, steps, yo, height/2);
      if (corn == 0) { 
        line(xo, y, x, y);

        // desenhamos varias vezes o triangulo exterior por cima, 
        // idealmente teríamos um if e só o desenharíamos uma vez:

        triangle(xo, yo, xo, height/2, width/2, yo);
      }
      if (corn == 1) {
        line(width-xo, y, width-x, y);

        triangle(width-xo, yo, width-xo, height/2, width/2, yo);
      }
      if (corn == 2) {
        line(width-xo, height-y, width-x, height-y);

        triangle(width-xo, height-yo, width-xo, height/2, width/2, height-yo);
      }
      if (corn == 3) {
        line(xo, height-y, x, height-y);

        triangle(xo, height-yo, xo, height/2, width/2, height-yo);
      }
    } else {
      // fase impar: triangulos no meio:

      if (corn%2 == 0) {
        // cor par / linhas verticais:
        x = map(step, 0, steps, width/4+xo/2, xo);
        y = map(step, 0, steps, height/4+yo/2, height/2);
      } else {
        // linhas horizontais:
        x = map(step, 0, steps, width/4+xo/2, width/2);
        y = map(step, 0, steps, height/4+yo/2, yo);
      }
      if (corn == 0) { 
        line(x, y, x, height-y);

        triangle(xo, height/2, width/4+xo/2, height/4+yo/2, width/4+xo/2, height-(height/4+yo/2));
      }
      if (corn == 1) { 
        line(width-x, y, x, y);

        triangle(width/2, yo, width/4+xo/2, height/4+yo/2, width-(width/4+xo/2), height/4+yo/2);
      }
      if (corn == 2) { 
        line(width-x, y, width-x, height-y);

        triangle(width-xo, height/2, width-(width/4+xo/2), height/4+yo/2, width-(width/4+xo/2), height-(height/4+yo/2));
      }
      if (corn == 3) { 
        line(width-x, height-y, x, height-y);

        triangle(width/2, height-yo, width/4+xo/2, height-(height/4+yo/2), width-(width/4+xo/2), height-(height/4+yo/2));
      }
    }
    step++; // avança para a proxima linha
  } else {
    step = 0; // volta à linha 0
    corn++; // avança para a cor seguinte

    if (corn > 3) {
      corn = 0; // volta à cor 0
      fase++; // avança para a fase seguinte
      steps = round(steps*0.7); // diminui o numero de linhas a usar no preenchimento

      if (fase%2 == 0) {
        // se numa fase 'par' (cantos) avança o 'cursor'
        // (canto sup. esq. do 1º triangulo):
        xo = width/4+xo/2;
        yo = height/4+yo/2;
        cor = expand(cor);
        cor[4] = cor[0];
        cor = subset(cor, 1);
      }


      // termina:
      if (abs(xo-width/2) < 10) noLoop();
    }
    stroke(cor[corn]);
  }
}