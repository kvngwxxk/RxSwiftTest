//
//  LastViewController.swift
//  RxSwiftTest
//
//  Created by Kangwook Lee on 2022/07/05.
//

import UIKit
import RxSwift
import RxCocoa

class LastViewController: UIViewController {
    static var time = CFAbsoluteTimeGetCurrent()
    let testViewModel = TestViewModel.shared
    private let disposeBag = DisposeBag()
    let button: UIButton = {
        let btn = UIButton()
        btn.setTitle("Button", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        btn.configuration = .plain()
        return btn
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Button Autolayout
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.view.backgroundColor = .white
        self.navigationItem.title = "Last"
        
        // testStack에 append
        testViewModel.testStack.append(3)
        
        // testRelay Event bind
        self.testViewModel.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                NotificationCenter.default.post(name: Notification.Name("Third"), object: nil)
                self.navigationController?.popViewController(animated: true)
                print("Last - testStack.popLast() : \(self.testViewModel.testStack.popLast() ?? -1)")
                print("Last - current stack : \(self.testViewModel.testStack)")
                print("Last: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
                print("============================================")
            }
            .disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        LastViewController.time = CFAbsoluteTimeGetCurrent()
    }
    
    @objc func buttonTap() {
        print("============================================")
        print("send value, current stack : \(self.testViewModel.testStack)")
        print("============================================")
        self.testViewModel.sendEvent()
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
