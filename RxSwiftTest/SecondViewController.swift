//
//  SecondViewController.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/06/30.
//

import UIKit
import RxSwift
import RxCocoa

class SecondViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    let testViewModel = TestViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.testViewModel.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                print("Second: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
            }
            .disposed(by: disposeBag)
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
