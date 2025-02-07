//
//  Item.swift
//  ShopKeeperSim
//
//  Created by Conner Yoon on 12/3/24.
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
