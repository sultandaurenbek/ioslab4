//
//  DownloadMusicTableViewCell.swift
//  lab5
//
//  Created by Sultan Daurenbek on 4/28/20.
//  Copyright © 2020 Sultan Daurenbek. All rights reserved.
//

import UIKit

class DownloadMusicTableViewCell: UITableViewCell {


    @IBOutlet weak var titleofsong: UILabel!
    @IBOutlet weak var downloadbtn: UIButton!
    
    var track: Track! {
          didSet {
              self.titleofsong.text = track.trackName
          }
    
}

 
var folderURL: URL?

   @IBAction func didPressDownload(_ sender: Any) {
          MusicService.shared.download(track: track, url: folderURL ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] )
            { url, error in
            if let url = url {
                self.downloadbtn.isHidden = true
            } else if let error = error {
                print(error)
            }
              }
          }
        
    }


