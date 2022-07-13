//
//  ContentView.swift
//  showReel_2022
//
//  Created by dt on 30/06/2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    @State private var animate = false
    
    var body: some View {
        if(viewModel.currentStatus == .playing){
            PlayerView(player: viewModel.player).transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.5)),
                                                                        removal: .opacity.animation(.easeInOut(duration: 0.1))))
        }else{
            ZStack{
                Rectangle().fill(.black)
                VStack{
                    Text("\(viewModel.playlist.vids[0].title)" as String)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 100)
                        .padding(.bottom, 20)
                Text("\(viewModel.playlist.vids[0].name)" as String)
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 100)
                }
            }.transition(.asymmetric(insertion: .opacity.animation(.easeInOut(duration: 0.1)),
                                     removal: .opacity.animation(.easeInOut(duration: 1))))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
