//
//  BaseViewController.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/15.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        swipeBack()
    }
    
    func swipeBack() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    

}
