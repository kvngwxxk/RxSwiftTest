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
    let bool = true
    let str = "Hello"
    
    func sendEvent() -> Observable<(Bool, String)> {
        return .create { observer in
            let temp = (self.bool, self.str)
            observer.on(.next(temp))
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
