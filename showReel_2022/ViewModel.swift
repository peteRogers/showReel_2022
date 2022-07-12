//
//  File.swift
//  showReel_2022
//
//  Created by dt on 30/06/2022.
//

import Foundation
import AVFoundation
import Combine

extension ContentView {
    
    @MainActor class ViewModel: ObservableObject {
        let player = AVPlayer()
        @Published var playlist = PlayList()
        @Published var currentStatus = PlayerStatus.notLoaded
        private var itemObservation: AnyCancellable?
        
        init(){
            loadNext()
          //  playItem()
            
//            itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
//                if(newStatus == .paused){
//                    print("item paused")
//                    self.currentStatus = .paused
//                }
//                if(newStatus == .playing){
//                    self.currentStatus = .playing
//                    print("item playing")
//                }
//
//
//            }

           
           
        }
        
        func loadNext(){
            if let av = self.playlist.vids[0].item{
               
                player.replaceCurrentItem(with: AVPlayerItem(asset:av))
                let _ = Timer.scheduledTimer(withTimeInterval: 10, repeats:false) { timer in
                    print("Timer fired!")
                    self.playItem()
                }
                
            }
        }
        
        func playItem(){
           
            player.play()
            itemObservation = player.publisher(for: \.timeControlStatus).sink { newStatus in
                print(newStatus.rawValue)
                
                if(newStatus == .paused){
                    print("item paused")
                    self.currentStatus = .paused
                   
                    self.itemObservation?.cancel()
                    self.loadNext()
                }
                if(newStatus == .playing){
                    self.currentStatus = .playing
                    print("item playing")
                   
                }
                
               
            }
            
          
            
        }
    }
}

enum PlayerStatus{
    
    case playing, paused, loading, notLoaded
}




