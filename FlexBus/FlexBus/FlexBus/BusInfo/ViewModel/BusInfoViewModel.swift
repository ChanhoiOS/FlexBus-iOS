//
//  BusInfoViewModel.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/19.
//
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol BusInfoViewModelType {
    associatedtype Input
    associatedtype Output
}

class BusInfoViewModel: BusInfoViewModelType {
    
    var input: Input
    var output: Output
    var disposeBag = DisposeBag()
    
    struct Input {
        var busRouteId = PublishSubject<String>()
    }
    
    struct Output {
        var station = PublishSubject<BusAllStationModel>()
    }
    
    init() {
        input = Input(busRouteId: PublishSubject<String>())
        output = Output(station: PublishSubject<BusAllStationModel>())

        input.busRouteId
            .bind(onNext: {[weak self] id in
                self?.getBusRouteRequest(id)
            })
            .disposed(by: disposeBag)
    }

    func getBusRouteRequest(_ busId: String) {
        let serviceKey = Constants.busStationKey

        var param = [String: Any]()
        param["serviceKey"] = serviceKey
        param["busRouteId"] = busId
        param["resultType"] = "json"

        ApiManager.getBusStation(url: Apis.busStation, param: param)
            .subscribe(onNext: { [weak self] response in
                switch response {
                case .success(let data):
                    self?.output.station.onNext(data)
                case .failure(let error):
                    print("error: ",error)
                }
            }, onError: { error in
                print("error: ",error)
            })
            .disposed(by: disposeBag)
    }
}

