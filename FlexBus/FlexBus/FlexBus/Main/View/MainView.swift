//
//  ViewController.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/13.
//

import UIKit
import RxSwift
import RxCocoa

class MainView: UIViewController {
    
    @IBOutlet weak var busSearchBar: UITextField!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        manageTextField()
    }
    
    func initRx() {
        
    }
    
    func manageTextField() {
        busSearchBar.rx.controlEvent(.touchDown)
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.moveSearch()
            })
            .disposed(by: disposeBag)
    }
    
    func moveSearch() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchView") as! SearchView
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

