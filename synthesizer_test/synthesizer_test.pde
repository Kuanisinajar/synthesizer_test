import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;


Minim minim;
AudioOutput out;
Oscil oscil;
Oscil fm;
MoogFilter filter;
ADSR adsr;

// text input
TextInput fmFreqInput;
TextInput fmAmpInput;

void setup() {
  size(640, 400);
  // Declare Minim object and output
  minim = new Minim(this);
  out = minim.getLineOut();

  // Oscillator settings
  oscil = new Oscil( 440, 0.5, Waves.SINE );

  // ADSR settings
  adsr = new ADSR( 0.5, 0.01, 0.05, 0.5, 0.5 );
  //oscil.patch( adsr );
  //adsr.patch(out);

  // FM settings
  fm = new Oscil( 10, 2, Waves.SINE);
  fm.offset.setLastValue( 440 );
  fm.patch( oscil.frequency );

  // Filter settings
  filter = new MoogFilter(14400, 0.5);

  // Patch
  oscil.patch(adsr);
  adsr.patch(out);
  //turn off the filter;
  //filter.patch(out);

  // Text Input
  fmFreqInput = new TextInput("F of FM", width/2, height/2);
  fmAmpInput = new TextInput("Amp of FM", width/2, height/2 + 60);

  adsr.noteOn();
}


void draw() {
  background(0);
  stroke(255);
  line(width/2, 0, width/2, height);
  line(0, height/2, width, height/2);


  // Draw Input 
  fmFreqInput.drawInput();
  fmAmpInput.drawInput();
}

void mousePressed() {
   adsr.noteOn();
  
  fmFreqInput.detectFocus();
  fmAmpInput.detectFocus();
}

void mouseReleased() {
   adsr.noteOff();

}

//void mouseMoved()
//{
//  float modulateAmount = map( mouseY, 0, height, 220, 1 );
//  float modulateFrequency = map( mouseX, 0, width, 0.1, 100 );

//  fm.setFrequency( modulateFrequency );
//  fm.setAmplitude( modulateAmount );
//}

void keyPressed() {
  fmFreqInput.receiving();
  fmAmpInput.receiving();

  if (key==ENTER||key==RETURN) {
    fm.setFrequency(fmFreqInput.value);
    fm.setAmplitude(fmAmpInput.value);
  }
}
