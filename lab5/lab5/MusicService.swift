//
//  MusicService.swift
//  lab5
//
//  Created by Sultan Daurenbek on 4/28/20.
//  Copyright © 2020 Sultan Daurenbek. All rights reserved.
//

import Foundation
 
class MusicService {
    // MARK: - Variables
    static let shared = MusicService()

   // MARK: - Methods
    func searchForMusic(findsongText: String, completion: @escaping (MusicSearchResponse?, Error?) -> ()) {
           let url = URL(string: "https://itunes.apple.com/search?term=\(findsongText)&entity=song")!
           
           URLSession.shared.dataTask(with: url) { data, _, error in
               if let data = data {
                   do {
                       let decoder = JSONDecoder()
                       let response = try decoder.decode(MusicSearchResponse.self, from: data)
                       
                       DispatchQueue.main.async {
                           completion(response, nil)
                       }
                   } catch {
                       DispatchQueue.main.async {
                           completion(nil, error)
                       }
                   }
               } else if let error = error {
                   DispatchQueue.main.async {
                       completion(nil, error)
                   }
               }
           }.resume()
       }
       
    func download(track: Track, url: URL, completion: @escaping (URL?, Error?) -> ()) {
        URLSession.shared.downloadTask(with: track.previewUrl) { tempURL, _, error in
            if let tempURL = tempURL {
                do {
                    let url = self.getFileUrl(for: track, url: url)
                    try FileManager.default.moveItem(at: tempURL, to: url)
                    DispatchQueue.main.async {
                        completion(url, nil)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func getFileUrl(for track: Track, url: URL) -> URL {

            let url = url.appendingPathComponent(track.previewUrl.lastPathComponent)
            
            return url
     }
    

    
    // MARK: - Response
class MusicSearchResponse: Codable {
       var tracks: [Track]
       
       enum CodingKeys: String, CodingKey {
           case tracks = "results"
       }
   }
   
}
