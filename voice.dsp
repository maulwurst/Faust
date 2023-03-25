import("stdfaust.lib");
declare options "[midi:on]";

key_2_hz = ba.midikey2hz(f);

amp = button("Gate");
f = hslider("freq", 69, 0, 128, 1);
s = nentry("[06]Waveform Select [style: knob]",0,0,2,1);
oscillator = os.polyblep_saw(key_2_hz),
             os.polyblep_square(key_2_hz),
             os.polyblep_triangle(key_2_hz) : 
             select3(s);

process =  oscillator*amp;
