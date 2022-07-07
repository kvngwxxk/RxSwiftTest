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
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.view.backgroundColor = .white
        self.navigationItem.title = "Main"
        self.testViewModel.testRelay
            .bind { [weak self] value, msg in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
                print("Main: \(value), \(msg), pop, \(CFAbsoluteTimeGetCurrent()-LastViewController.time)")
            }
            .disposed(by: disposeBag)
    }
    
    @objc func buttonTap() {
        print("push (Main -> Second)")
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }

}

