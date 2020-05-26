//
//  SongFetcher.swift
//  Tune Radar
//
//  Created by Dylan Kuster on 5/12/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

protocol SongFetcherDelegate
{
    func receiveResults(tuneModel : TuneModel)
}

struct SongFetcher
{
    var delegate : SongFetcherDelegate?
    private let requestURL = "https://api.deezer.com/chart"
    
    func findRandomSong()
    {
        if let url = URL(string: requestURL)
        {
            let urlSession = URLSession(configuration: .default)
            let task = urlSession.dataTask(with: url)
            { (data, response, error) in
                if let safeData = data
                {
                    if let tuneModel = self.parseJSON(with: safeData)
                    {
                        self.delegate?.receiveResults(tuneModel: tuneModel)
                    }
                }
            }
            task.resume()
        }
    }
    
    private func parseJSON(with data : Data) -> TuneModel?
    {
        let decoder = JSONDecoder()
        
        do
        {
           return try decoder.decode(TuneModel.self, from: data)
        }
        
        catch let error
        {
            print(error)
            return nil
        }
    }
}
