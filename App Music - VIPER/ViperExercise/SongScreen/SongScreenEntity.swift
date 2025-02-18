//
//  SongScreenEntity.swift
//  ViperExercise
//
//  Created by Emiliano Gil  on 14/11/24.
//

import Foundation
import UIKit

struct SongScreen {
    var nameSong: [[String]] // Depende del id del album y cancion
    
    var imageAlbum: [String] // Depemde del id del album
    var timeSeconds: [[TimeInterval]]
    var timeText: [[String]]
}
