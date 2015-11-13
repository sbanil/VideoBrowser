//
//  DetailViewController.swift
//  VideoBrowser
//
//  Created by Sanghubattla, Anil on 10/18/15.
//  Copyright © 2015 teamcakes. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit


class DetailViewController: UIViewController, PlayerDelegate {
    
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    var player: Player!
    
    @IBOutlet weak var playerView: UIView!
    
    var detailItem: VideoModel?
    
    typealias KVOContext = UInt8
    var MyObservationContext = KVOContext()
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.videoName
            }
            

            if let videoUrl = NSURL(string:detail.videoLocationUrl!)
            {
                print("Loading Video URL: " + detail.videoLocationUrl!)
                self.player = Player()
                self.player.delegate = self
                self.player.setUrl(videoUrl)
                self.addChildViewController(self.player)
                self.player.view.frame = self.playerView.bounds
                self.playerView.addSubview(self.player.view)
                self.playerView.addSubview(self.player.view)
                self.player.didMoveToParentViewController(self)
                self.player.playFromBeginning()
                self.player.fillMode  = AVLayerVideoGravityResizeAspectFill
                super.view.layoutSubviews()

            }
            
        
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: PlayerDelegate
    
    func playerReady(player: Player) {
        
        print("Player is ready to play: Max Duration: " + String(player.maximumDuration))
    }
    
    func playerPlaybackStateDidChange(player: Player) {
         print("Playback State changed: " + player.playbackState.description)
    }
    
    func playerBufferingStateDidChange(player: Player) {
        
         print("Playback Buffering State changed : " + player.bufferingState.description)
    }
    
    func playerPlaybackWillStartFromBeginning(player: Player) {
        
                print("Playback Started from Begining")
    }
    
    func playerPlaybackDidEnd(player: Player) {
        
        print("Playback Ended")
    }


}

