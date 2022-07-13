//
//  File.swift
//  showReel_2022
//
//  Created by dt on 30/06/2022.
//

import Foundation
import AVFoundation
import Combine
import UIKit

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        let player = AVPlayer()
        @Published var playlist = PlayList()
        @Published var currentStatus = PlayerStatus.notLoaded
        private var itemObservation: AnyCancellable?
        
        init(){
            loadNext()
        }
        
        func loadNext(){
            do{
                let av = try playlist.deliverAsset()
                playlist.arrangeArray()
                player.replaceCurrentItem(with: AVPlayerItem(asset:av))
                NSCursor.unhide()
                let _ = Timer.scheduledTimer(withTimeInterval: 2, repeats:false) { timer in
                    self.playItem()
                }
            }catch ArrayError.noItem{
                print("no item in array")
            }catch{
                print("unknown error")
            }
        }
        
        func playItem(){
            player.play()
            itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
                if(newStatus == .paused){
                    self.currentStatus = .paused
                    self.itemObservation?.cancel()
                    self.loadNext()
                }
                if(newStatus == .playing){
                    self.currentStatus = .playing
                }
            }
        }
    }
}

enum PlayerStatus{
    case playing, paused, loading, notLoaded
}




