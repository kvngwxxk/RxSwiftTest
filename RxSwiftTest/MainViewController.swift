//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/05/26.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    private let disposeBag = DisposeBag()
    var td = TestData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = "Hello world"
        self.td.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                print("Main: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
            }
            .disposed(by: disposeBag)
    }


}

