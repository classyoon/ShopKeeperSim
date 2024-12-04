//
//  ShopKeeperView.swift
//  ShopKeeperSim
//
//  Created by Conner Yoon on 12/3/24.
//

import SwiftUI

struct ShopKeeperView: View {
    var vm : StoreWorker = StoreWorker()
    var body: some View {
        ScrollView {
            ForEach(vm.stock){ ware in
                Text(ware.name)
            }
        }
    }
}
class StoreWorker {
    var shopkeeper : ShopKeeper
    @Published var stock : [Good]
    @Published var money : Int
    init(shopkeeper: ShopKeeper = ShopKeeper(), available: [Good]=[], givenMoney : Int = 10) {
        self.shopkeeper = shopkeeper
        self.stock = available
        self.money = givenMoney
        updateWares()
    }
    func updateWares(){
        stock = shopkeeper.provideAvailableGoods(money)
    }
}
class ShopKeeper {
    var store = [Good("Shoes", 10), Good("Food", 5), Good("Premium", 5)]
    
    func provideAvailableGoods(_ customerCash : Int)->[Good]{
        var shownItems : [Good] = []
        for good in store {
            if good.requirements.count == 0 {
                shownItems.append(good)
            }else{
                
            }
        }
        return shownItems
    }
}
struct Good : Identifiable {
    var id = UUID()
    var name = ""
    var cost = 0
    var requirements : [String] = []
    init(_ name: String = "", _ cost: Int = 0) {
        self.name = name
        self.cost = cost
    }
}
#Preview {
    ShopKeeperView()
}

