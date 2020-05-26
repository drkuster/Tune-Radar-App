//
//  TrackTableViewCell.swift
//  Tune Radar
//
//  Created by Dylan Kuster on 5/12/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit
import AVFoundation

protocol TrackTableViewCellDelegate
{
    func selectCell(indexPath : IndexPath)
}

class TrackTableViewCell: UITableViewCell, AVAudioPlayerDelegate
{
    
    var trackPreviewLink : String?
    var player : AVAudioPlayer!
    var delegate : TrackTableViewCellDelegate?
    var indexPath : IndexPath?

    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var songArtist: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func playButtonPressed(_ sender: Any)
    {
        if self.playButton.backgroundImage(for: .normal) == UIImage(systemName: "pause.fill")
        {
            self.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            player.stop()
        }
        
        else
        {
            self.playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            if let index = indexPath
            {
                if let del = delegate
                {
                    del.selectCell(indexPath: index)
                }
            }
            
            if let link = trackPreviewLink
            {
                let url = URL(string: link)
                downloadFileFromURL(url : url!)
            }
        }
    }
    
    func downloadFileFromURL(url : URL)
    {
        var downloadTask : URLSessionDownloadTask
        downloadTask = URLSession.shared.downloadTask(with: url)
        { (URL, response, error) in
            self.play(url : URL!)
        }
        downloadTask.resume()
    }
    
    func play(url : URL)
    {
        do
        {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            self.player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            player.volume = 1.0
            player.delegate = self
            player.play()
        }
        
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
        
        catch
        {
            print("AVAudioPlayer init failed")
        }

    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        self.playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
}
