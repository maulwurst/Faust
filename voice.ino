#include <Audio.h>
#include "osc.h"


osc osc;
AudioOutputI2S out;
AudioControlSGTL5000 audioShield;
AudioConnection patchCord0(osc,0,out,0);
AudioConnection patchCord1(osc,0,out,1);


void OnNoteOn(byte channel, byte note, byte velocity){
     osc.setParamValue("Gate",1);
     osc.setParamValue("key_2_hz", note);
     Serial.print(note);

}
void OnNoteOff(byte channel, byte note, byte velocity) {
       osc.setParamValue("Gate",0);

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
