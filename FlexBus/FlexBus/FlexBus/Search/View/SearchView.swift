//
//  SearchView.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/13.
//

import UIKit
import RxSwift
import RxCocoa

class SearchView: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var busSearchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var searchViewModel = SearchViewModel()
    var searchData: BusRouteModel?
    var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        manageTextField()
        registerCell()
        initRx()
    }
    
    func initView() {
        backBtn.setTitle("", for: .normal)
    }
    
    func initRx() {
        backBtn.rx.tap
            .bind(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        searchViewModel.output.route
            .subscribe(onNext: {[weak self] data in
                self?.searchData = data
                self?.tableView.reloadData()
            },
            onError: {[weak self] error in
                print("error: ",error)
            })
            .disposed(by: disposeBag)
    }
    
    func manageTextField() {
        busSearchBar.rx.text
            .orEmpty
            .skip(1)
            .bind(to: self.searchViewModel.input.busNum)
            .disposed(by: disposeBag)
    }
    
    func registerCell() {
        let nibName = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "SearchTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension SearchView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchData?.msgBody.itemList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for:  indexPath) as! SearchTableViewCell
        cell.busNum.text = searchData?.msgBody.itemList[indexPath.row].busRouteNm
        
        let firstStation = searchData?.msgBody.itemList[indexPath.row].stStationNm
        let endStation = searchData?.msgBody.itemList[indexPath.row].edStationNm
        
        cell.firstStation.text = firstStation ?? ""
        cell.lastStation.text = endStation ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "BusInfo", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BusInfoView") as! BusInfoView
        vc.firstStation = searchData?.msgBody.itemList[indexPath.row].stStationNm
        vc.endStation = searchData?.msgBody.itemList[indexPath.row].edStationNm
        vc.busId = searchData?.msgBody.itemList[indexPath.row].busRouteID ?? ""
        vc.busNumber = searchData?.msgBody.itemList[indexPath.row].busRouteNm ?? ""
        vc.lineText = searchData?.msgBody.itemList[indexPath.row].routeType ?? ""
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

