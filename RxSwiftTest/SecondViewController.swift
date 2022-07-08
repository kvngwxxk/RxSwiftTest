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
    
    // Button 생성
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
        self.navigationItem.title = "Second"
        
        // testStack에 append
        testViewModel.testStack.append(1)
        
        // testRelay Event bind
        self.testViewModel.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                print("Second - testStack.popLast() : \(self.testViewModel.testStack.popLast() ?? -1)")
                print("Second - current stack : \(self.testViewModel.testStack)")
                print("Second: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
                print("============================================")
            }
            .disposed(by: disposeBag)
    }
    
    @objc func buttonTap() {
        print("push (Second -> Third)")
        self.navigationController?.pushViewController(ThirdViewController(), animated: true)
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
