
//Configuration
final int[] input = {1};                   //input in center of the initial row
final boolean inputRepeat = false;         //repeats input on the initial row
final int cornerValueLeft = 0;             //value of cell outside of the left bound
final int cornerValueRight = 0;            //value of cell outside of the right bound
final int backgroundC = color(0,0,0);      //color of dead cells (rgb)
final int foregroundC = color(0,220,0);    //color of live cells (rgb)
final boolean save = false;                //save image as png
final short ruleNr = 105;                  //binary representation of the ruleset. Set to < 0 for a random ruleset
//###################

int[] tape;
int history;
int[] rules = new int[8];

void setup(){
    //window size:
    size(1025,512);
    //
    noSmooth();
    background(backgroundC);
    history = 0;
    short ruleBinary = ruleNr;
    if(ruleBinary < 0){
        ruleBinary = (short) random(256);
    }
    //write binary value as ruleset
    int index = 0;
    while(ruleBinary >= 0 && index < 8){
        rules[index++] = ruleBinary & 1;
        ruleBinary >>= 1;
    }
    //set input to tape
    tape = new int[width];
    int inputIndex = 0;
    for(int i = 0; i < width; i++){
        if(inputRepeat){
            tape[i] = (input[i % input.length] == 0 ? 0 : 1);
        }
        else if( (i >= (width/2 - input.length/2)) && (i < (width/2 + (input.length + 1)/2 ))){
            tape[i] = (input[inputIndex++] == 0 ? 0 : 1);
        }
        else{
            tape[i] = 0;
        }
    }
    for(int i = 0; i < width; i++){
        if(tape[i] != 0){
            stroke(foregroundC);
        }else{
            stroke(backgroundC);
        }
        point(i, 0);
    }
}

void draw(){
    if (history < height - 1)
        history++;
    else if(save){
        save("Rule"+ruleNr+".png");
        noLoop();
    }
    loadPixels();
    int[] pixelRow = new int[width];
    //move all pixles down one row
    for(int i = history - 1; i >= 0; i--){
        arrayCopy(pixels, i * width, pixelRow, 0, width);
        for(int j = 0; j < width; j++){
            pixels[((i+1) * width) + j] = pixelRow[j]; 
        }
    }
    updatePixels();
    int left = cornerValueLeft;
    int right;
    //update each pixel according to rules
    for(int i = 0; i < tape.length; i++){
        if(i+1 < tape.length)
            right = tape[i+1];
        else
            right = cornerValueRight;
        int rule = (left << 2) + (tape[i] << 1) + right;
        left = tape[i];
        tape[i] = rules[rule];
    }
  
    for(int i = 0; i < width; i++){
        if(tape[i] != 0){
            stroke(foregroundC);
        }else{
            stroke(backgroundC);
        }
        point(i, 0);
    }
}