//
//  Market.swift
//  ShopKeeperSim
//
//  Created by Conner Yoon on 12/3/24.
//

import Foundation
class Customer {
    var money : Int = 10
    var possessions : [Good] = []
}
class Game {
    var player : Customer = Customer()
    
}


protocol Purchasable {
    var name : String {get}
    var cost : Int {get set}
    var info : String {get}
}




