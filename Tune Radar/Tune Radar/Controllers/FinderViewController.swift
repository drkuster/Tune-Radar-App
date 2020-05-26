//
//  ViewController.swift
//  Tune Radar
//
//  Created by Dylan Kuster on 5/12/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import UIKit

class FinderViewController : UIViewController
{
    
    private var songFetcher = SongFetcher()
    private var songList : [Song]?
    @IBOutlet weak var topTracksButton: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        songFetcher.delegate = self
        topTracksButton.layer.cornerRadius = 33
    }
    
    @IBAction func viewTopTracksButtonPressed(_ sender: UIButton)
    {
        songFetcher.findRandomSong()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == K.resultsSegue
        {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.songList = self.songList
        }
    }

}

extension FinderViewController : SongFetcherDelegate
{
    
    func receiveResults(tuneModel: TuneModel)
    {
        songList = tuneModel.tracks.data
        DispatchQueue.main.async
        {
            self.performSegue(withIdentifier: K.resultsSegue, sender: self)
        }
    }
    
}

