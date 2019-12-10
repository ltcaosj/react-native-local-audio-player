//
//  LKLocalAudioPlayer.swift
//  LKLocalAudioPlayer
//
//  Created by Long Cao on 11/3/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import UIKit
import AVFoundation

@objc(LKLocalAudioPlayer)
class LKLocalAudioPlayer: RCTEventEmitter, AVAudioPlayerDelegate {

  var avPlayer : AVAudioPlayer?
  
  override static func requiresMainQueueSetup() -> Bool {
    return false
  }
  
  // we need to override this method and
  // return an array of event names that we can listen to
  override func supportedEvents() -> [String]! {
    return ["onSoundFinishedPlaying"]
  }
  
  @objc
  func supportAudioInSilentMode(){
    do {
      if #available(iOS 10.0, *) {
        try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try AVAudioSession.sharedInstance().setActive(true)
      } else {
        AVAudioSession.sharedInstance().perform(NSSelectorFromString("setCategory:error:"), with: AVAudioSession.Category.playback)
      }
    } catch _ as NSError {
    }
  }
  
  @objc
  func stopAudio(){
    self.avPlayer?.stop()
  }

  @objc
  func pauseAudio(){
    self.avPlayer?.pause()
  }

  @objc
  func resumeAudio(){
   self.avPlayer?.play()
  }
  
  @objc func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    sendEvent(withName: "onSoundFinishedPlaying", body: [])
  }
  
  func setupAudioPlayerWithFile(filePath:String) -> AVAudioPlayer?  {
    //
    let url = NSURL.fileURL(withPath: filePath)
    //
    let _avPlayer : AVAudioPlayer
    do{
      _avPlayer = try AVAudioPlayer(contentsOf: url)
      _avPlayer.delegate = self
      _avPlayer.prepareToPlay()
      return _avPlayer
    }
    catch{
      return nil
    }
  }
  
  @objc
  func playSound(_ filePath : String, callback: RCTResponseSenderBlock) {
    self.stopAudio()
    //
    self.avPlayer = setupAudioPlayerWithFile(filePath: filePath)
    if(self.avPlayer != nil){
      let played = self.avPlayer!.play()
      callback([played])
    }
    else{
      callback([false])
    }
  }
  
}

