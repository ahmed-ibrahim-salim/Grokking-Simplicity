//
//  Ch4FromActionsToCalc.swift
//  TamingSimplicityTests
//
//  Created by Ahmad medo on 17/09/2023.
//

import XCTest

fileprivate final class Ch4FromActionsToCalc: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_add_item_to_cart(){
        // (1

        let item = ShoppingItemStruct(name: "meg", price: 2.0)
        
        
        let newItem = setPrice(item: item, new_price: 4.0)
        
        
        XCTAssertEqual(item.price, 2.0)
        XCTAssertEqual(newItem.price, 4.0)
        
    }

}

fileprivate class ShoppingItemClass{
    var name: String
    
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
fileprivate struct ShoppingItemStruct{
    var name: String
    
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}

fileprivate var shopping_cart: [ShoppingItemStruct] = [];
//fileprivate var shopping_cart_total = 0.0

fileprivate func add_item_to_cart(cart: [ShoppingItemStruct],
                                  _ name: String,
                                  _ price: Double) {
    
    let item = make_cart_Item(name, price)
    
    shopping_cart = addItem(cart, item)
    
    let cartTotal = calc_total(shopping_cart)
    
    set_cart_total_dom(cartTotal)
    
    update_shipping_icons(shopping_cart)
    
    update_tax_dom(cartTotal)
    
}
// item
fileprivate func make_cart_Item( _ name: String,
                                 _ price: Double)->ShoppingItemStruct{
    return ShoppingItemStruct(name: name,
                        price: price)
}
// cart
fileprivate func addItem(_ cart: [ShoppingItemStruct],
                         _ item: ShoppingItemStruct)->[ShoppingItemStruct]{
    
    return add_element_last(cart, item)
}

// Array utility
fileprivate func add_element_last<T>(_ array: [T],
                                     _ elem: T)->[T]{
    var innerArray = array
    
    innerArray.append(elem)
    
    return innerArray
}


fileprivate func set_cart_total_dom(_ cartTotal: Double){}

//(2
fileprivate func get_buy_buttons_dom()->[Button]{
    
    return []
}

fileprivate struct Button{
    var item: ShoppingItemStruct
    
    func show_free_shipping_icon(){}
    func hide_free_shipping_icon(){}
}

// dom
fileprivate func showOrHideFreeShippingIcon(_ show: Bool,
                                        _ button: Button){
    if show{
        button.show_free_shipping_icon();
    }else{
        button.hide_free_shipping_icon();

    }
}

// business, dom, button

fileprivate func update_shipping_icons(_ cart: [ShoppingItemStruct]) {
    
    for button in get_buy_buttons_dom() {
                        
        let cartHasFreeShipping = getFreeShipping(cart, button.item)
        
        showOrHideFreeShippingIcon(cartHasFreeShipping, button)
    }
}

fileprivate func getFreeShipping(_ cart: [ShoppingItemStruct],
                                 _ item: ShoppingItemStruct)->Bool{
    
    var new_cart = addItem(cart, item)

    return calc_total(new_cart) >= 20
    
}

// business, cart, item
fileprivate func calc_total(_ cart: [ShoppingItemStruct])-> Double{
    var shopping_cart_total = 0.0;
    
    for (i, _) in cart.enumerated() {
        var item = cart[i];
        shopping_cart_total += item.price;
        
    }
    
    return shopping_cart_total

}

//(3

fileprivate func update_tax_dom(_ cartTotal: Double) {
    set_tax_dom(calc_tax(cartTotal))

}

fileprivate func set_tax_dom(_ tax: Double){
    
}

fileprivate func calc_tax(_ price: Double)->Double {
    price * 0.10
}

// Removing itemßß
fileprivate func removeItem(_ idx: Int?,
                            _ cart: [ShoppingItemStruct])-> [ShoppingItemStruct]{
    var new_cart = cart
    
    if let idx = idx{ new_cart.remove(at: idx) }
    
    return new_cart
    
}

fileprivate func remove_item_by_name(_ cart: [ShoppingItemStruct],
                                     _ name: String)-> [ShoppingItemStruct] {
    var idx: Int? = nil
    
    for (i, item) in cart.enumerated() {
        if item.name == name{
            idx = i
        }
    }
    
    return removeItem(idx, cart)

}

fileprivate func delete_handler(_ name: String) {
    
    shopping_cart =  remove_item_by_name(shopping_cart, name);
    
    let total = calc_total(shopping_cart);
    set_cart_total_dom(total);
    update_shipping_icons(shopping_cart);
    update_tax_dom(total);
    
}

fileprivate func setPriceByName(_ cart: [ShoppingItemStruct],
                                _ name: String,
                                _ price: Double){
    
    var innerCart = cart
    
    for item in innerCart {
        if item.name == name {
            item.price = price
        }
    }
}
