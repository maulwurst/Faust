import("stdfaust.lib");
import("osc.lib");
declare options "[midi:on]";

freq = hslider("freq",100,1,20000,1);
selector = hslider("wave",0,0,2,1);

osc_g(i,x) = vgroup("OSC %2nn", x)
with{
 nn = i+1;
};
voice1 = par(i,2,osc_g(i,voice(freq,selector)*voice_amp));

envelope = en.adsr(voice_attack,voice_decay,voice_sustain,voice_release,gate);
voice_attack = hslider("attack",0,0,10,0.1);
voice_decay = hslider("decay",0.01,0.01,10,0.01);
voice_sustain = hslider("sustain",0,0,1,0.1);
voice_release = hslider("release",0,0,10,0.1);
voice_volume = hslider("volume",0,0,1,0.01);
voice_amp = envelope * voice_volume;
gate = button("[07]gate");

filter_freq = hslider("filter",0,0,1,0.01);
q = hslider("q",0,0,15,0.01);
voice2 = voice1:>_*voice_amp;
process = voice2:ve.korg35LPF(filter_freq,q);