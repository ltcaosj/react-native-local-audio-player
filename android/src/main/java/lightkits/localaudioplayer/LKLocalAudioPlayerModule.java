package lightkits.localaudioplayer;

import android.media.MediaPlayer;

import androidx.annotation.Nullable;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.io.IOException;

public class LKLocalAudioPlayerModule extends ReactContextBaseJavaModule {

    private MediaPlayer mediaPlayer;

    private final ReactApplicationContext reactContext;

    public LKLocalAudioPlayerModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    private void sendEvent(ReactContext reactContext,
                           String eventName,
                           @Nullable WritableMap params) {
        reactContext
                .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
                .emit(eventName, params);
    }

    @Override
    public String getName() {
        return "LKLocalAudioPlayer";
    }

    @ReactMethod
    public void stopAudio() {
        if(mediaPlayer != null){
            mediaPlayer.stop();
        }
    }

    @ReactMethod
    public void pauseAudio() {
        if(mediaPlayer != null){
            mediaPlayer.pause();
        }
    }

    @ReactMethod
    public void resumeAudio() {
        if(mediaPlayer != null){
            mediaPlayer.start();
        }
    }
    @ReactMethod
    public void playSound(String url, final Callback onCompleted) {
        this.stopAudio();
        //
        mediaPlayer = new MediaPlayer();
        try {
            mediaPlayer.setDataSource(url);
            mediaPlayer.prepare();
            mediaPlayer.start();
            onCompleted.invoke();
            //
            mediaPlayer.setOnCompletionListener(new MediaPlayer.OnCompletionListener() {
                @Override
                public void onCompletion(MediaPlayer mediaPlayer) {
                    WritableMap payload = Arguments.createMap();
                    //
                    sendEvent(getReactApplicationContext(), "onSoundFinishedPlaying", payload);
                }
            });

        } catch (IOException e) {

        }
    }
}
