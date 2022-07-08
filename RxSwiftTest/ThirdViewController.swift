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
    let testViewModel = TestViewModel.shared
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
        
        // Notification 등록
        NotificationCenter.default.addObserver(self, selector: #selector(moveBack(_:)), name: Notification.Name("Third"), object: nil)
        print("noti 등록")
        
        self.view.backgroundColor = .white
        self.navigationItem.title = "Third"
        
        // testStack에 append
        testViewModel.testStack.append(2)
        
        // testRelay Event bind
        self.testViewModel.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                
                print("Third - testStack.popLast() : \(self.testViewModel.testStack.popLast())")
                print("Third - current stack : \(self.testViewModel.testStack)")
                print("Third: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
            }
            .disposed(by: disposeBag)
    }
    
    @objc func buttonTap() {
        print("push (Third -> Last)")
        self.navigationController?.pushViewController(LastViewController(), animated: true)
    }
    
    // Notification 이벤트
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
