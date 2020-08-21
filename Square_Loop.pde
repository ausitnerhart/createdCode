
size (900, 900);
int sizeOfSquare = 40;
int numOfSquares = 0;
while (numOfSquares <= width/sizeOfSquare) {
  rect(width-(width-sizeOfSquare*numOfSquares)
        , height-(height-sizeOfSquare*numOfSquares)
        , sizeOfSquare, sizeOfSquare);
  numOfSquares = numOfSquares + 1;
}
