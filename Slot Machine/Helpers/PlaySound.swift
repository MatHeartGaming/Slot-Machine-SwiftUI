//
//  PlaySound.swift
//  Slot Machine
//
//  Created by Matteo Buompastore on 10/08/23.
//

import AVFoundation

var audioPlayer : AVAudioPlayer?

func playSound(sound : String, type : String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch (let err) {
            print("ERROR: Could not play the sound file: \(sound).\(type). Err: \(err.localizedDescription)")
        }
    }
}
