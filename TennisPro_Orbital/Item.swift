//
//  Item.swift
//  TennisPro_Orbital
//
//  Created by Yuexi Song on 24/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
