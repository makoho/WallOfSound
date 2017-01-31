/**
 * WallOfWords by Marco Hokke - 1000pixels
 * 
 * The sketch reads a file called 'dialogs.txt' from the data folder
 * and randomly draws the words of each sentence on the screen.
 *
 */

int      margin = 100;
float    currentX;
float    currentY;

float    wordSpace = 17;
float    lineHeight = 19;
boolean  blackAndWhite;

PFont    textsFont;
color    sentenceColor;
int      sentenceIndex = 0;
String[] sentences;

void setup() {

  size(1400, 800);
  background(253);

  textsFont = loadFont("LucidaSansUnicode-20.vlw");
  textFont(textsFont, 26);

  blackAndWhite = (random(0, 10) < 5);
  sentences = loadStrings("dialogs.txt");
  frameRate(8);
}

void draw()
{
  if (sentenceIndex == sentences.length)
  {
    save(nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2) + ".png");
    background(253);
    sentenceIndex=0;
  } else
  {
    drawSentence(sentences[sentenceIndex]); 
    sentenceIndex++;
  }
}

void keyPressed()
{
  if (key=='r' || key=='R')
    save(nf(hour(), 2) + nf(minute(), 2) + nf(second(), 2) + ".png");
}

void MoveCurrentX()
{
  MoveCurrentX(wordSpace);
}

void MoveCurrentX(float amount)
{
  currentX += amount;
  if (currentX > width - margin - random(-10, 10))
  {
    float offSet = currentX -  (width - margin);
    currentX = margin + (int)random(-10, 10) + offSet;
    MoveCurrentY();
  }
}

void MoveCurrentY()
{
  MoveCurrentY(lineHeight + random(-5, 5));
}

void MoveCurrentY(float amount)
{
  currentY += amount;
  if (currentY > height - margin)
    currentY = margin + random(-5, 5);
}

void drawSentence(String sentence)
{
  // pick a sentence color
  if (blackAndWhite)
  {
    sentenceColor = color(10);
  } else
  {
    int colorIndex = floor(random(0, 7));
    if (colorIndex==0) sentenceColor = color(125, 0, 0);
    if (colorIndex==1) sentenceColor = color(125, 125, 0);
    if (colorIndex==2) sentenceColor = color(125, 0, 125);
    if (colorIndex==3) sentenceColor = color(0, 125, 0);
    if (colorIndex==4) sentenceColor = color(0, 125, 125);
    if (colorIndex==5) sentenceColor = color(0, 0, 125);
    if (colorIndex==6) sentenceColor = color(0, 0, 0);
  }

  // split the sentence into words and draw each word
  String[] words = splitTokens(sentence);
  for (int i=0; i<words.length; i++)
  {
    String word = words[i];
    drawWord(word);
  }
}

void drawWord(String word)
{
  // Create a new random position for this word
  currentX = random(margin, width - margin);
  currentY = random(margin, height - margin);
  for (int i=0; i<word.length(); i++)
  {  
    char d = word.charAt(i);
    drawCharacter(d);
  }
  MoveCurrentX();
  MoveCurrentX(random(0, 50));
}

void drawCharacter(char character)
{
  int charColor = characterColor(character);
  if (charColor == 80)
    textFont(textsFont, 22);

  if (charColor == 150)
    textFont(textsFont, 22);

  if (charColor == 210)
    textFont(textsFont, 22);

  fill(sentenceColor, 255-charColor);
  text(character, currentX, currentY + random(-1, 1));
  MoveCurrentX(13 + random(-1, 1));
}

int characterColor(char character)
{
  if (
    character=='a' || character=='A' ||
    character=='t' || character=='T' ||
    character=='s' || character=='S' ||
    character=='p' || character=='P' ||
    character=='k' || character=='K'
    )      
    return 50;

  if (
    character=='g' || character=='G' ||
    character=='e' || character=='E' ||
    character=='i' || character=='I' ||
    character=='o' || character=='O' ||
    character=='u' || character=='U' ||
    character=='f' || character=='F' ||
    character=='r' || character=='R' ||
    character=='b' || character=='B' ||
    character=='m' || character=='M' ||
    character=='n' || character=='N' ||
    character=='l' || character=='L'
    )
    return 190;

  return 220;
}