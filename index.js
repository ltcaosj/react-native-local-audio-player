import {NativeModules, NativeEventEmitter} from 'react-native';
import {Mp3Player} from './Mp3Player';

const {LKLocalAudioPlayer} = NativeModules;

const onSoundFinishedPlaying = callback => {
  const ev = new NativeEventEmitter(LKLocalAudioPlayer);
  ev.addListener('onSoundFinishedPlaying', () => {
    callback();
  });
};

export {LKLocalAudioPlayer, Mp3Player, onSoundFinishedPlaying};
