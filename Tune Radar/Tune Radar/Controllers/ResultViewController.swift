//
//  ResultViewController.swift
//  Tune Radar
//
//  Created by Dylan Kuster on 5/12/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class ResultViewController: UITableViewController
{
    
    var songList : [Song]?
    
    var previousIndexPath : IndexPath?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Lush"))
        tableView.rowHeight = 100
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.reusableCellID)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return songList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.reusableCellID, for: indexPath) as! TrackTableViewCell
        if let song = songList?[indexPath.row]
        {
            cell.backgroundColor = .clear
            cell.songTitle.text = song.title
            cell.delegate = self
            cell.indexPath = indexPath
            cell.songArtist.text = song.artist.name
            let albumArtURL = URL(string : song.album.cover_big)
            cell.albumCover.downloadImage(from: albumArtURL!)
            cell.trackPreviewLink = song.preview
        }
        return cell
    }
    
}

extension ResultViewController : TrackTableViewCellDelegate
{
    func selectCell(indexPath : IndexPath)
    {
        if let previousIP = previousIndexPath
        {
            if previousIP != indexPath
            {
                if let previousCell = tableView.cellForRow(at: previousIP) as? TrackTableViewCell
                {
                    previousCell.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
                    previousCell.player.stop()
                }
            }
        }
        previousIndexPath = indexPath
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }
}

extension UIImageView
{
   func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
   {
      URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
   }
    
   func downloadImage(from url: URL)
   {
      getData(from: url)
      {
         data, response, error in
         guard let data = data, error == nil
         else
         {
            return
         }
        
         DispatchQueue.main.async()
         {
            self.image = UIImage(data: data)
         }
      }
   }
}
