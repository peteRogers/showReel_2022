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
        @Published var txt = "foofo"
        @Published var playingItem:AVPlayer?
        @Published var playlist = PlayList()
        
        
        init(){
           // txt = "\($playlist.vids.count)"
         
        }

    }
    
    
    
    
   
}



