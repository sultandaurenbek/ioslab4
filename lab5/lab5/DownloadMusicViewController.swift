//
//  DownloadMusicViewController.swift
//  lab5
//
//  Created by Sultan Daurenbek on 4/28/20.
//  Copyright © 2020 Sultan Daurenbek. All rights reserved.
//

import UIKit

class DownloadMusicViewController: UIViewController {
    // MARK: - Variables
    @IBOutlet weak var findmusicbar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var tracks: [Track] = []
    var url: URL?
    var findsongText: String = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    getSongs(findsongText: findsongText)

    }
    
    // Do any additional setup after loading the view.
          
    @objc func getSongs(findsongText: String) {

          MusicService.shared.searchForMusic(findsongText: findsongText) { [weak self] result, error in
              guard let self = self else { return }
              
              if let tracks = result?.tracks {
                  self.tracks = tracks
                  self.tableView.reloadData()
              } else if let error = error {
                  print(error)
              }
          }
      }
}

extension DownloadMusicViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tracks.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DownloadMusicTableViewCell", for: indexPath) as! DownloadMusicTableViewCell
            cell.track = self.tracks[indexPath.row]
            cell.folderURL = self.url
            return cell
    }
    
}
    extension DownloadMusicViewController:UISearchBarDelegate{
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
        {
        self.findmusicbar.endEditing(true)
        }
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            findsongText = findmusicbar.text ?? ""
            tracks = []
            getSongs(findsongText: findsongText)
        }

    }
   

    

    

 


