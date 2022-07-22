//
//  ApiManager.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/13.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class ApiManager {
    //MARK: BusRoute
    static func getBusRoute(url: String, param: [String: Any]) -> Observable<Result<BusRouteModel, Error>> {
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return Observable.create { observer -> Disposable in
            
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: header)
                .responseDecodable(of: BusRouteModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
        }
    }
    
    //MARK: BusStation
    static func getBusStation(url: String, param: [String: Any]) -> Observable<Result<BusAllStationModel, Error>> {
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return Observable.create { observer -> Disposable in
            
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: header)
                .responseDecodable(of: BusAllStationModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        observer.onError(error)   
                    }
                }
                return Disposables.create()
        }
    }
    
    
    //MARK: StationInfo
    static func getStationInfo(url: String, param: [String: Any]) -> Observable<Result<StationModel, Error>> {
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        return Observable.create { observer -> Disposable in
            
            AF.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: header)
                .responseDecodable(of: StationModel.self) { response in
                    switch response.result {
                    case .success(let data):
                        observer.onNext(.success(data))
                    case .failure(let error):
                        observer.onError(error)
                    }
                }
                return Disposables.create()
        }
    }
}
