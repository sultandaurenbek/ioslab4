//
//  ViewController.swift
//  lab5
//
//  Created by Sultan Daurenbek on 4/28/20.
//  Copyright © 2020 Sultan Daurenbek. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ViewController: UIViewController {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?

    var songURL: URL! {
        didSet {
            playerItem = .init(url: songURL)
        }
    }
    
    
    
    @IBOutlet weak var collectionVIew: UICollectionView!
    
    
     var url = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        var fileURLs: [URL] = try! FileManager.default.contentsOfDirectory(at: try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0], includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
                   longPress.minimumPressDuration = 0.5
                   longPress.delaysTouchesBegan = true
                   self.collectionVIew.addGestureRecognizer(longPress)
            
          
        }
    

        
        override func viewWillAppear(_ animated: Bool) {
            playerItem = nil

            reloadFiles(url: self.url)
            
            let createFolderBtn = UIBarButtonItem(title: "Create Folder",  style: .plain, target: self, action: #selector(createFolder))
            let downloadMusicBtn = UIBarButtonItem(title: "Download Music",   style: .plain, target: self, action: #selector(downloadMusic))

            navigationItem.rightBarButtonItems = [createFolderBtn, downloadMusicBtn]
                
        }
        
        @objc func createFolder() {

            let alert = UIAlertController(title: "Enter Folder Name", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
            alert.addTextField { (textField) in
                textField.text = "NewFolder"
            }
            alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { action in
                let textField = alert.textFields![0]
                let dataPath = self.url.appendingPathComponent(textField.text ?? "NewFolder")
                do {
                    try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: false, attributes: nil)
                    self.reloadFiles(url: self.url)
                } catch {
                    print(error.localizedDescription)
                }
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
        
        @objc func downloadMusic() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let downloadMusicVC = storyboard.instantiateViewController(identifier: "DownloadMusicViewController") as DownloadMusicViewController
            downloadMusicVC.url = self.url
           navigationController?.pushViewController(downloadMusicVC, animated: true)
        }
    
        @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
             if gesture.state != .ended {
                 return
             }
             let point = gesture.location(in: self.collectionVIew)
             if let indexPath = self.collectionVIew.indexPathForItem(at: point) {
                 do {
                     try FileManager.default.removeItem(at: fileURLs[indexPath.row])
                     self.reloadFiles(url: self.url)
                 } catch {
                     print(error.localizedDescription)
                 }
             }
         }
         
      
        
        private func reloadFiles(url: URL) {
            do {
                self.fileURLs = try! FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                collectionVIew.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            collectionVIew.reloadData()

        }
    }

    extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return fileURLs.count
        }
        
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
               
                 if fileURLs[indexPath.row].pathExtension == "mp3" || fileURLs[indexPath.row].pathExtension == "m4a"{
                   let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
                  cell.musicname.text = fileURLs[indexPath.row].lastPathComponent
                     return cell
               }
                     
                 else{
               
           let   cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! ItemsCollectionViewCell
               cell.itemname.text = fileURLs[indexPath.row].lastPathComponent
                  return cell
               }
             
           }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = UIScreen.main.bounds.width / 3
            return CGSize(width: width, height: width)
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if fileURLs[indexPath.row].pathExtension == "mp3" || fileURLs[indexPath.row].pathExtension == "m4a"{
                songURL = fileURLs[indexPath.row]
                let playerViewController = AVPlayerViewController()
                present(playerViewController, animated: true, completion: nil)
                self.player = AVPlayer(playerItem:playerItem)
                playerViewController.player = player
                player?.play()
                player?.volume = 2.0
                          
                
                           }
                       
            
            else {
                let directoryVC = storyboard.instantiateViewController(identifier: "MainController") as ViewController
                directoryVC.url = fileURLs[indexPath.row]
                reloadFiles(url: self.url)
                navigationController?.pushViewController(directoryVC, animated: true)
            }
            
        }
        
        override func viewWillDisappear(_ animated: Bool) {
              
              playerItem = nil
          }
        
      
    }
        
    






