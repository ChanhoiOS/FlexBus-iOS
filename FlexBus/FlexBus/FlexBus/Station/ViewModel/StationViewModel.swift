//
//  StationViewModel.swift
//  FlexBus
//
//  Created by 이찬호 on 2022/07/22.
//

import Foundation
import RxSwift
import RxCocoa

protocol StationViewModelType {
    associatedtype Input
    associatedtype Output
}

class StationViewModel: StationViewModelType {
    
    var input: Input
    var output: Output
    var disposeBag = DisposeBag()
    
    struct Input {
        var stationId = PublishSubject<String>()
    }
    
    struct Output {
        var stationInfo = PublishSubject<StationModel>()
    }
    
    init() {
        input = Input(stationId: PublishSubject<String>())
        output = Output(stationInfo: PublishSubject<StationModel>())
        
        input.stationId
            .bind(onNext: { [weak self] stId in
                self?.getStationRequest(stId)
            })
            .disposed(by: disposeBag)
    }
    
    func getStationRequest(_ stId: String) {
        let serviceKey = Constants.busStationKey

        var param = [String: Any]()
        param["serviceKey"] = serviceKey
        param["stId"] = stId
        param["resultType"] = "json"

        ApiManager.getStationInfo(url: Apis.stationInfo, param: param)
            .subscribe(onNext: { [weak self] response in
                switch response {
                case .success(let data):
                    print("data: ",data)
                case .failure(let error):
                    print("error: ",error)
                }
            }, onError: { error in
                print("error: ",error)
            })
            .disposed(by: disposeBag)
    }
    
    
}
