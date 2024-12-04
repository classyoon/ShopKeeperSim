//
//  ShopKeeperView.swift
//  ShopKeeperSim
//
//  Created by Conner Yoon on 12/3/24.
//

import SwiftUI
class Customer : ObservableObject{
    @Published var money : Int = 10
    @Published var possessions : [Good] = []
    func scrap(name: String){
        for good in possessions.indices {
            if name == possessions[good].name {
                possessions.remove(at: good)
                break
            }
        }
    }
}
struct ShopKeeperView: View {
    @ObservedObject var vm : StoreWorker = StoreWorker()
    @ObservedObject var person : Customer = Customer()
    var body: some View {
        ScrollView {
            Text("StoreWorker recieved Money \(vm.money)")
            Text("Person has Money \(person.money)")
            ForEach(vm.stock){ ware in
                Text(ware.name)
                if ware.cost <= person.money {
                    Button("Buy"){
                        person.possessions.append(vm.sell(name: ware.name))
                        person.money += vm.purchase(ware.name)
                        
                    }
                }
            }
            Text("Possessions").font(.title)
            ForEach(person.possessions){ ware in
                Text(ware.name)
                    Button("Scrap"){
                        person.money += vm.purchase(isReturn: true, ware.name)
                        person.scrap(name: ware.name)
                    }
            }
        }.onAppear{
            vm.money = person.money
        }
    }
}
class StoreWorker : ObservableObject{
    var shopkeeper : ShopKeeper
    @Published var stock : [Good]
    @Published var money : Int
    init(shopkeeper: ShopKeeper = ShopKeeper(), available: [Good]=[], givenMoney : Int = 10) {
        self.shopkeeper = shopkeeper
        self.stock = available
        self.money = givenMoney
        updateWares()
    }
    func sell(name : String)->Good{
        for good in stock {
            if name == good.name {
                money-=good.cost
                return good
            }
        }
        return Good("Error")
    }
    func purchase(isReturn : Bool = true, _ name : String)->Int{
        for good in stock {
            if name == good.name {
                if isReturn {
                    money+=good.cost
                }else{
                    money-=good.cost
                }
                return good.cost
               
            }
        }
        return 0
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

