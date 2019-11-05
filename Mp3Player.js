import {NativeModules} from 'react-native';

const {LKLocalAudioPlayer} = NativeModules;

const Mp3Player = {
  play(mp3Uri, result) {
    LKLocalAudioPlayer.playSound(mp3Uri, result);
  },
  stop() {
    LKLocalAudioPlayer.stopAudio();
  },
};

export {Mp3Player};
