//
//  PlayList.swift
//  showReel_2022
//
//  Created by dt on 05/07/2022.
//

import Foundation
import AVFoundation
import SwiftUI

@MainActor class PlayList: ObservableObject{
    
    @Published var vids = [VidInfo]()
    
    init(){
       print("foopfoof")
      
        do{
            let json = try loadData(name: "vids")
            for j in json{
               
                print(j.title)
                    //let item = loadVideo(filename: vi.filename)
//                   let c = getVideoAsset(filename: j.filename) { itemAsset in
//                        print(j.title)
//                    let vidInfo = VidInfo(title: j.title, filename: j.filename, name: j.name, item: itemAsset, time: itemAsset.duration)
//                    //print(vidInfo.time)
//                    self.vids.append(vidInfo)
//
//                    }
                
                let v = getVideoAsset(filename: j.filename)
                let vidInfo = VidInfo(title: j.title, filename: j.filename, name: j.name, item: v, time: v.duration)
                self.vids.append(vidInfo)
                }
        
        
        }catch JSONError.jsonError{
            print("no json")
        }catch JSONError.fileLoadError{
            print("no json")
        }catch{
            print("unexpected error")
        }
    }
    
    func loadData(name:String) throws -> [JSONIN]{
        guard let url =  Bundle.main.url(forResource: name, withExtension: "json")
        else{
            
            throw JSONError.fileLoadError
        }
       guard let jsonData = try? Data(contentsOf: url)
        else{
           throw JSONError.jsonError
       }
        guard let decodedData:[JSONIN] = try? JSONDecoder().decode([JSONIN].self,
                                                   from: jsonData)
        else{
            throw JSONError.jsonError
        }
        
        return decodedData
        
    }
    
    private func getVideoAsset(filename: String)->AVAsset{
        let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil)
        let asset = AVAsset(url: fileUrl!)
        return asset
        
    }
    
   
    
    private func getVideoAsset(filename: String, completion:  @escaping (AVAsset) -> ()){
        
        let fileUrl = Bundle.main.url(forResource: filename, withExtension: nil)
        let asset = AVAsset(url: fileUrl!)
        let keys = ["duration"]
        asset.loadValuesAsynchronously(forKeys: keys){
            var error: NSError? = nil
            let status = asset.statusOfValue(forKey: "duration", error: &error)
            switch status{
            case .loaded:
                print("loaded")
                completion(asset)
                break
            default:
                print("whaaat")
                break
            }
        }

    }
}

struct JSONIN: Codable {
    let title: String
    let filename: String
    let name: String
}

struct VidInfo:Identifiable {
    var title: String
    var filename: String
    var name: String
    var item:AVAsset?
    var time: CMTime?
    var id = UUID()
    
   
}

enum JSONError: Error, Equatable {
     case fileLoadError
     case jsonError
 }

