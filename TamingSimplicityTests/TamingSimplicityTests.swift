//
//  TamingSimplicityTests.swift
//  TamingSimplicityTests
//
//  Created by Ahmad medo on 15/09/2023.
//

import XCTest
@testable import TamingSimplicity

fileprivate final class TamingSimplicityTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func test_Decide_Coupon_Rank()  {
        
        // given
        let subscriber = Subscriber(email: "email", recordCount: 20)
        
        //when
        let rank = subscriber.getRank()
        
        // then
        XCTAssertEqual(rank, "best")
        
    }

    func test_Select_Coupon_ByRank()  {
        
        // given
        let badCoupon = Coupon(code: "Heart", rank: "bad")
        let goodCoupon = Coupon(code: "Heart", rank: "good")
        let bestCoupon = Coupon(code: "Heart", rank: "best")

        let coupons = [badCoupon, goodCoupon, bestCoupon]

        //when
        let returnedCoupons = RankCalculator.selectCouponByRank(coupons: coupons, rank: "bad")
        
        // then
        XCTAssertEqual(returnedCoupons.count, 1)
        
    }
    
    func test_Email_For_OneSubscriber()  {
        
        // given
        let goodCoupon = Coupon(code: "Heart", rank: "good")
        let bestCoupon = Coupon(code: "Heart", rank: "best")
        
        let subscriber = Subscriber(email: "medo", recordCount: 8)

        //when
        let message = EmailSender.sendEmail(subscriber: subscriber, best: bestCoupon, good: goodCoupon)
        
        // then
        XCTAssertEqual(message.coupon.getRank(), "good")
        
    }
    
    
}

fileprivate struct Message{
    var coupon: Coupon
    var from, to, subject, body: String
    
    init(coupon: Coupon, from: String, to: String, subject: String, body: String) {
        self.coupon = coupon
        self.from = from
        self.to = to
        self.subject = subject
        self.body = body
    }
    
}

fileprivate struct EmailSender{
    
    
    static func sendEmail(subscriber: Subscriber, best: Coupon, good: Coupon)->Message{
        
        
        if subscriber.getRank() == "best"{
            
            return Message(coupon: best, from: "me", to: subscriber.email, subject: "blabla", body: "also bla bla")

        }else{
            return Message(coupon: good, from: "me", to: subscriber.email, subject: "blabla", body: "also bla bla")
        }
    }
    
}


fileprivate class RankCalculator{
    
    static func selectCouponByRank(coupons: [Coupon], rank: String)->[Coupon]{
        var foundCoupons: [Coupon] = []
        
        for coupon in coupons {
            if coupon.getRank() == rank{
                foundCoupons.append(coupon)
            }
        }
        
        return foundCoupons
    }
}

fileprivate struct Coupon{
     var code: String
     private var rank: String
    
    init(code: String, rank: String) {
        self.code = code
        self.rank = rank
    }
    
    func getRank()->String{rank}
    
}

fileprivate struct Subscriber{
    var email: String
    private var recordCount: Int
    
    init(email: String, recordCount: Int) {
        self.email = email
        self.recordCount = recordCount
    }
    
    
    func getRank()->String{
        
        if recordCount >= 10{
            return "best"
        }else{
            return "good"
        }
        
    }
}
