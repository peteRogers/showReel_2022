//
//  File.swift
//  showReel_2022
//
//  Created by dt on 30/06/2022.
//

import Foundation
import AVFoundation
import SwiftUI
extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        @Published var playingItem = AVPlayer()
        @Published var playlist = PlayList()
        
        init(){
            if let av = playlist.vids[0].item{
                playingItem.replaceCurrentItem(with: AVPlayerItem(asset:av))
                playItem()
            }
        }
        
        func playItem(){
            playingItem.play()
            
        }
    }
}



