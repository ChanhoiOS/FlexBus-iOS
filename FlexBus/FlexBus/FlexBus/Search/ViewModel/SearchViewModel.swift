//
//  SearchViewModel.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/14.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol SearchViewModelType {
    associatedtype Input
    associatedtype Output
}

class SearchViewModel: SearchViewModelType {
    
    var input: Input
    var output: Output
    var searchText: String = String()
    
    var disposeBag = DisposeBag()
    
    struct Input {
        var busNum = BehaviorSubject<String>(value:"")
    }
    
    struct Output {
        var route = PublishSubject<BusRouteModel>()
    }
    
    init() {
        input = Input(busNum: BehaviorSubject<String>(value: ""))
        output = Output(route: PublishSubject<BusRouteModel>())
        
        input.busNum
            .bind(onNext: {[weak self] text in
                self?.searchText = text
                guard text != "" else { return }
                self?.getBusRouteRequest()
            })
            .disposed(by: disposeBag)
    }
    
    func getBusRouteRequest() {
        let decodeServiceKey = Constants.busRouteKey.decodeUrl()
        
        var param = [String: Any]()
        param["serviceKey"] = decodeServiceKey
        param["strSrch"] = searchText
        param["resultType"] = "json"
        
        ApiManager.getBusRoute(url: Apis.busRoute, param: param)
            .subscribe(onNext: { [weak self] response in
                switch response {
                case .success(let data):
                    self?.output.route.onNext(data)
                case .failure(let error):
                    print("error: ",error)
                }
            }, onError: { error in
                print("error: ",error)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    
}
