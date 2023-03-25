#include <Audio.h>
#include "voice.h"


voice voice;
AudioOutputI2S out;
AudioControlSGTL5000 audioShield;
AudioConnection patchCord0(voice,0,out,0);
AudioConnection patchCord1(voice,0,out,1);


void OnNoteOn(byte channel, byte note, byte velocity){
     voice.setParamValue("Gate",1);

}
void OnNoteOff(byte channel, byte note, byte velocity) {
       voice.setParamValue("Gate",0);

}

void setup() {
  AudioMemory(200);
  audioShield.enable();
  audioShield.volume(0.2);
  usbMIDI.setHandleNoteOff(OnNoteOff);
  usbMIDI.setHandleNoteOn(OnNoteOn) ;
  
}

void loop() {
  usbMIDI.read();
  }
