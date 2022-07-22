//
//  BusInfoView.swift
//  BestBus
//
//  Created by 이찬호 on 2022/07/15.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BusInfoView: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var line: UILabel!
    @IBOutlet weak var busNum: UILabel!
    
    var busInfoViewModel = BusInfoViewModel()
    var busStationData: BusAllStationModel?
    var disposeBag = DisposeBag()
    var firstStation: String?
    var endStation: String?
    var busId = ""
    var lineText = ""
    var busNumber = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        registerCell()
        registerHeader()
        initRx()
    }
    
    func initView() {
        backBtn.setTitle("", for: .normal)
        line.text = lineText
        if busNumber == "3" {
            busNum.text = "간선"
        }
        
    }
    
    func registerCell() {
        let nibName = UINib(nibName: "BusLineCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "BusLineCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerHeader() {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        header.backgroundColor = .white
        
        let image = UIImage(systemName: "arrow.left.and.right")
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        header.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.centerX.equalTo(header)
        }
        
        let firstLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 80, height: 40))
        firstLabel.text = firstStation
        firstLabel.textAlignment = .center
        header.addSubview(firstLabel)
        
        firstLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.right.equalTo(imageView).offset(-50)
            make.height.equalTo(20)
        }
        
        let endLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 80, height: 40))
        endLabel.text = endStation
        endLabel.textAlignment = .center
        header.addSubview(endLabel)
        
        endLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView)
            make.left.equalTo(imageView).offset(50)
            make.height.equalTo(20)
        }
        tableView.tableHeaderView = header
    }
    
    func initRx() {
        backBtn.rx.tap
            .bind(onNext: {[weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
        
        busInfoViewModel.input.busRouteId.onNext(busId)
        
        busInfoViewModel.output.station
            .subscribe(onNext: { [weak self] response in
                self?.busStationData = response
                self?.tableView.reloadData()
            }, onError: { error in
                print("error: ",error)
            })
            .disposed(by: disposeBag)
    }
}

extension BusInfoView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
       
        headerView.backgroundColor = .white
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: headerView.frame.width / 2, height: 80))
        headerView.addSubview(leftView)
        leftView.backgroundColor = .white
        leftView.layer.borderColor = UIColor.black.cgColor
        leftView.layer.borderWidth = 1
        
        leftView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(headerView.frame.width / 2 - 16)
        }
        
        let rightView = UIView(frame: CGRect(x: headerView.frame.width / 2, y: 0, width: headerView.frame.width / 2, height: 80))
        headerView.addSubview(rightView)
        rightView.backgroundColor = .white
        rightView.layer.borderColor = UIColor.black.cgColor
        rightView.layer.borderWidth = 1
        
        rightView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.left.equalTo(leftView.snp.right).offset(0)
            make.width.equalTo(headerView.frame.width / 2 - 16)
        }
        
        let firstStaionLabel = UILabel()
        firstStaionLabel.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        firstStaionLabel.text = firstStation
        firstStaionLabel.font = .systemFont(ofSize: 16)
        firstStaionLabel.textColor = .black
            
        leftView.addSubview(firstStaionLabel)
        
        firstStaionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
        
        let endStationLabel = UILabel()
        endStationLabel.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        endStationLabel.text = endStation
        endStationLabel.font = .systemFont(ofSize: 16)
        endStationLabel.textColor = .black
            
        rightView.addSubview(endStationLabel)
        
        endStationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
            
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return firstStation
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return busStationData?.msgBody.itemList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BusLineCell", for:  indexPath) as! BusLineCell
        let stationNm = busStationData?.msgBody.itemList[indexPath.row]["stNm"]
        let stationNum = busStationData?.msgBody.itemList[indexPath.row]["arsId"]
        let busLoc = busStationData?.msgBody.itemList[indexPath.row]["arrmsg1"]
        cell.stationName.text = stationNm ?? ""
        cell.stationNum.text = stationNum ?? ""
        
        if busLoc == "곧 도착" {
            cell.busImage.isHidden = false
        } else {
            cell.busImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Station", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "StationView") as! StationView
        print("stID: ",busStationData?.msgBody.itemList[indexPath.row])
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
