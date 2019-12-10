#import <Foundation/Foundation.h>

#import "React/RCTBridgeModule.h"
#import "React/RCTEventEmitter.h"

@interface RCT_EXTERN_MODULE(LKLocalAudioPlayer, RCTEventEmitter)

RCT_EXTERN_METHOD(
                  playSound:(NSString *)filePath
                  callback: (RCTResponseSenderBlock)callback
                  )
RCT_EXTERN_METHOD(
                  supportAudioInSilentMode
                  )
RCT_EXTERN_METHOD(
                  stopAudio
                  )
RCT_EXTERN_METHOD(
pauseAudio
)
RCT_EXTERN_METHOD(
resumeAudio
)
@end


