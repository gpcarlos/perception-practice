clear all, close all

t = 3; Fs = 8000; Ch = 1;
num_bits = 16; num_samples = 100;
displ = round(num_samples*0.75);

signal = recording(t, Fs, Ch, num_bits);
signal = pre_emphasis(signal, 0.95);

segments = segmentation(signal, num_samples, displ);

segments_word = start_end(segments, 60);

word = inv_segmentation(segments_word, displ);

figure,
subplot(2,1,1),plot(signal), title('Original Signal')
subplot(2,1,2),plot(word), title('Word');

p = audioplayer(word, Fs);
play(p);
