import ddf.minim.*;
import ddf.minim.analysis.*;
import processing.serial.*;
Minim minim;
AudioInput song;
AudioOutput out;
BeatDetect beat;
BeatListener bl;
PFont font;
PImage bg;
color oscillatorColor = color(0, 0, 0);

String PATH = "/home/george/sketchbook/music";
String script = PATH + "/send-command.sh";
String songFile = "/home/george/Downloads/gangnam.mp3"; //The Doors- Light My Fire.mp3";

int count = 0;

void setup()
{
  //size of the player
  size(367, 550, P3D);
  //this is very important when sending high volume of OSC commands, trust me, I learned the hard way.  I began 
  //with a frame rate of about 60 and experienced painful delays as the amount of commands at 60fps was 
  //inundating the server. 
  frameRate(25);
  String oscillatorColor = "";
  //background image and font
  //bg = loadImage("../data/bgPic.jpg");
  //font = loadFont("../data/Consolas-48.vlw");

  //instantiate minim object
  minim = new Minim(this); 
  out = minim.getLineOut(); 
  //song = minim.loadFile(songFile);
  song = minim.getLineIn(Minim.STEREO, 512);
    
  //create beat detection object
  beat = new BeatDetect(song.bufferSize(), song.sampleRate());
  beat.setSensitivity(100);  
  // make a new beat listener, so that we won't miss any buffers for the analysis
  bl = new BeatListener(beat, song);

  sendCmd("group1on");
  //song.play();

}

void draw()
{
  background(255,255,255);
  //image(bg, 0, 0);
  fill(255, 0, 0);
  //stop/pause button
  noStroke();
  rect(30, 500, 20, 20);
  //textFont(font, 15);
  fill(100, 255, 0);
  //Print Artist/SongName to top of window
  //text(song.getMetaData().author() + " - " + song.getMetaData().title(), 40, 40);

  


  //check the type of beat that is detected and send OSC message with a value of 1, 2, or 3
  if ( beat.isKick() ) {
    println("kick");
    count++;
    if(count % 3 == 0){
      setCol("col_red");
    }
    else if(count % 3 == 1){
      setCol("col_green"); 
    }
    else{
      setCol("col_baby_blue"); 
    }
  } else if ( beat.isSnare() ) {
    println("snare");
    setCol("col_yellow");
  } else if ( beat.isHat() ) {
    println("hat");
    setCol("group1white");
  } else {
    setCol("col_orange");
  }
  
  // SEND MESSAGE HERE
  
  //draw oscillator.  Color of oscillator will turn R, G, B, depending on beat detected
  for (int i = 0; i < out.bufferSize () - 1; i++) {
    stroke(oscillatorColor);
    //line(i, 310 + song.mix.get(i)*250, i+1, 310 + song.mix.get(i+1)*250);
  }
} 

void sendCmd(String cmd){
  String[] params = { script, cmd };
  open(params);
}

void setCol(String col){
  String[] params = { script, col };
  open(params);
  //params = new String[] { "./send-command.sh", "brightest" };
  //open(params); 
}
  
//Control play/pause button 
void mousePressed() {   
  //if (mouseX>30 && mouseX<50) {
    //co-ordinates for button area
    //if (mouseY>500 && mouseY<520) {
      //if (song.isPlaying()) {  //button function, ie play/pause
      //  song.pause();
      //} else {
      //  song.play();
      //}
    //}
  //}
}

//stop the song that is playing
void stop()
{
  // always close Minim audio classes when you are finished with them
  song.close();
  // always stop Minim before exiting
  minim.stop();
  // this closes the sketch
  super.stop();
}

