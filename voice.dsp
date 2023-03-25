import("stdfaust.lib");
// Pitch stuff
key_2_hz = ba.midikey2hz(pitch_shift);
midi_pitch = f;
tune = hslider("tune", 0, -24, 24, 1);
finetune = hslider("finetune", 0, -1, 1, 0.01);
octave = hslider("octave",0,-24,24,12);
pitch_shift = midi_pitch + octave + tune + finetune;



// Oscillator
osc_g(i) = hgroup("OSC %i",oscillator);

f = hslider("freq", 69, 0, 128, 1);
s = nentry("[06]Waveform Select [style: knob]",0,0,2,1);
oscillator = os.polyblep_saw(key_2_hz),
             os.polyblep_square(key_2_hz),
             os.polyblep_triangle(key_2_hz) : 
             select3(s);
mixer = hslider("Mix",0.5,0,1,0.001);

make_osc = par(i,2,osc_g(i));

//Amp
amp_g(i) = hgroup("Amp %i",amp);


amp_attack = vslider("[01]Attack [style: knob]",0,0,10,0.1);
amp_decay = vslider("[02]Decay [style: knob]",1,0,2,0.1);
amp_sustain = vslider("[03]Sustain [style: knob]",0.2,0,1,0.1);
amp_release = vslider("[04]Release [style: knob]",5,0,10,0.1);

envelope_amp = en.adsr(amp_attack,amp_decay,amp_sustain,amp_release,gate);

amp = envelope_amp;

make_amp = par(i,2,amp_g(i));


//Gate
gate = button("[07]Gate");

//Filter

filter_g(i) = hgroup("Filter %i", vcf);
filter_model = ve.moog_vcf_2bn(res,vcf_f);
vcf = filter_model*amp;
vcf_f = vslider("[1] Frequency [style: knob]",300,40,20000,1);
res = vslider("[2] Corner Resonance [style: knob]",0.7, 0, 1, 0.01);

//Voice
voice = par(i,1,(osc_g(i))*amp_g(i)):> par(i,1,filter_g(i)):> _ ;

//process = oscillator*mixer*amp:vcf*amp;
process = voice;
