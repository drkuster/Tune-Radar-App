//
//  TuneModel.swift
//  Tune Radar
//
//  Created by Dylan Kuster on 5/12/20.
//  Copyright © 2020 Dylan Kuster. All rights reserved.
//

import Foundation

struct TuneModel : Decodable
{
    let tracks : Track
}

struct Track : Decodable
{
    let data : [Song]
}

struct Song : Decodable
{
    let title : String
    let link : String
    let artist : Artist
    let album : Album
    let preview : String
}

struct Artist : Decodable
{
    let name : String
}

struct Album : Decodable
{
    let cover_big : String
}

