//
//  PlayerView.swift
//  showReel_2022
//
//  Created by Peter Rogers on 01/07/2022.
//

import Foundation
import UIKit
import AVFoundation
import SwiftUI


class PlayerUIView: UIView{
    private let playerLayer = AVPlayerLayer()
    private var player: AVPlayer?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(player: AVPlayer) {
            self.player = player
            super.init(frame: .zero)
            self.backgroundColor = .black
            // player.isMuted = true // just in case
            playerLayer.player = player
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)
            player.actionAtItemEnd = .pause
        
//            NotificationCenter.default.addObserver(self,
//                                                   selector: #selector(self.playerItemDidReachEnd(notification:)),
//                                                   name: .AVPlayerItemDidPlayToEndTime,
//                                                   object: self.player?.currentItem)
            
           
            
            
            
        }
    
}

struct PlayerView: UIViewRepresentable {
   
    var player:AVPlayer?
    
   
    
    
    init(player:AVPlayer ) {
        self.player = player
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<PlayerView>) {
       // let v:PlayerUIView = uiView as! PlayerUIView
       
    }
    

    func makeUIView(context: Context) -> UIView {
        return PlayerUIView(player:player!)
    }
}

