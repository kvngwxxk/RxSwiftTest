//
//  ThirdViewController.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/06/30.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var td = TestData.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(moveBack(_:)), name: Notification.Name("Third"), object: nil)
        print("noti 등록")
        self.view.backgroundColor = .white
        self.td.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                print("Third: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
            }
            .disposed(by: disposeBag)
    }
    
    @objc func moveBack(_ notification: Notification) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("Noti pop")
            self.navigationController?.popViewController(animated: true)
        }
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
