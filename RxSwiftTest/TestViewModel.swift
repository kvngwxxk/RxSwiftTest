//
//  TestViewModel.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/07/07.
//

import Foundation
import RxSwift
import RxCocoa

class TestViewModel {
    private let disposeBag = DisposeBag()
    public static let shared = TestViewModel()
    
    var testData = TestData()
    var testRelay: PublishRelay<(Bool, String)> = PublishRelay()
    var testStack = [Int]()
    
    func sendEvent() {
        testData.sendEvent().subscribe(onNext: { [weak self] bool, str in
            guard let self = self else { return }
            self.testRelay.accept((true, "Hello"))
        }).disposed(by: disposeBag)
    }
}
