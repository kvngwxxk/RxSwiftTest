//
//  TestData.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/06/30.
//

import Foundation
import RxSwift
import RxCocoa

class TestData {
    static let shared = TestData()
    var testRelay: PublishRelay<(Bool, String)> = PublishRelay()
    
    func sendEvent() {
        testRelay.accept((true, "Hello"))
    }
}
