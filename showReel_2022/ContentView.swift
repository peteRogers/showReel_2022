//
//  ContentView.swift
//  showReel_2022
//
//  Created by dt on 30/06/2022.
//

import SwiftUI





struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        Text("\($viewModel.playlist.vids.count)")
        List(viewModel.playlist.vids){ j in
           
            
                    VStack(alignment: .leading) {
                        
                        Text(j.name)
                            .font(.title)
                            .fontWeight(.heavy)
                            .foregroundColor(Color.gray)
                            
                        HStack{
                            Text("\(j.name)")
                                .font(.title3)
                                .foregroundColor(Color.red)
                                
                            Spacer()
                            Text("\(j.name)")
                                .font(.title3)
                        }
                    }
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
