//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Merritte on 10/22/16.
//  Copyright © 2016 Merritte. All rights reserved.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRecorder()
        
    }
    
    func setupRecorder() {
        do {
            // Create and Audio Session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Create URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioUrl = NSURL.fileURL(withPathComponents: pathComponents)!
            print("###################")
            print(audioUrl)
            print("###################")
            
            
            // Create settings for audio recorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            // Create AudioRecorder Object
            
            audioRecorder = try AVAudioRecorder(url: audioUrl, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func recordTapped(_ sender: AnyObject) {
        
        if audioRecorder!.isRecording {
            //Stop the recording
            audioRecorder?.stop()
            
            //Change button title to record
            recordButton.setTitle("Record", for: .normal)
            
        } else {
            //Start Recording
            audioRecorder?.record()
            
            // Change button title to stop
            recordButton.setTitle("Stop", for: .normal)
        }
        
    }
    
    @IBAction func playTapped(_ sender: AnyObject) {
        
    }
    
    @IBAction func addTapped(_ sender: AnyObject) {
        
    }
    
}
