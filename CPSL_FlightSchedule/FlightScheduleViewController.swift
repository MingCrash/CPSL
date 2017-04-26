//
//  FlightSchedule.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/17.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit

let resultKey:String  = "ResultData"


class FlightScheduleViewController: UIViewController {
    let searchHistoryView = SearchHistoryTableViewController()
    var dataArray: [FlightResultInfo]? = [FlightResultInfo]()
    
    @IBAction func SegmentSelector(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            flightResultScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }else{
            flightResultScrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: false)
        }
    }
    
    @IBOutlet var searchFS: UITextField!
    @IBAction func cancelBtnAction(_ sender: UIButton) {
        cancelBtnOutlet.isHidden = true
        searchHistoryView.view.removeFromSuperview()
        searchFS.resignFirstResponder()
    }
    @IBOutlet var cancelBtnOutlet: UIButton!
    @IBOutlet var flightResult_Arrival: UITableView!
    @IBOutlet var flightResult_Departure: UITableView!
    @IBOutlet var flightResultScrollView: UIScrollView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        searchFS.delegate = self
    
        flightResult_Departure.delegate = self
        flightResult_Departure.dataSource = self
        flightResult_Arrival.delegate = self
        flightResult_Arrival.dataSource = self
        
        setDefualtData()
    }
    
    private func setDefualtData() {
        let userDefaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        for i in 1..<11 {
            let currentTime = Date()
            let element = FlightResultInfo()
            element.time = dateFormatter.string(from: currentTime)
            element.flightNum = "CX\(i)"
            element.flightInfo = "CGK(CengKareng)HAN"
            element.endTime = dateFormatter.string(from: currentTime)
            dataArray?.append(element)
        }
        //将数组转化成为NSData
//        let data = NSKeyedArchiver.archivedData(withRootObject: dataArray!)
        
        userDefaults.set(dataArray, forKey: resultKey)
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton()
        backButton.setTitle("FLIGHT SCHEDULE", for: .normal)
        backButton.setTitleColor(UIColor.white, for: .normal)
        backButton.sizeToFit()
        backButton.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        navigationItem.titleView = backButton
        
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshHander))
        navigationItem.rightBarButtonItem = refresh
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = ThemeColor
    }
    
    @objc func btnClicked() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func refreshHander() {
        print("refresh")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        
    }
    
}

extension FlightScheduleViewController: UITextFieldDelegate{
    //textField has become the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cancelBtnOutlet.isHidden = false
        searchHistoryView.view.frame = CGRect(x: 0, y: 114.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-114.0)
        view.addSubview(searchHistoryView.view)
    }
}

extension FlightScheduleViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: FlightResultTableViewCell? = nil
        
        if tableView.isEqual(flightResult_Arrival) {
            cell = tableView.dequeueReusableCell(withIdentifier: "FlightArrivalResultResuseID") as? FlightResultTableViewCell
            if cell == nil{
                cell = FlightResultTableViewCell(style: .default, reuseIdentifier: "FlightArrivalResultResuseID")
            }
            cell?.time.text = dataArray?[indexPath.row].time
            cell?.flightNum.text = dataArray?[indexPath.row].flightNum
            cell?.flightInfo.text = dataArray?[indexPath.row].flightInfo
            cell?.endTime.text = dataArray?[indexPath.row].endTime
            return cell!
        }else if tableView.isEqual(flightResult_Departure){
            cell = tableView.dequeueReusableCell(withIdentifier: "FlightDepartureResultResuseID") as? FlightResultTableViewCell
            if cell == nil{
                cell = FlightResultTableViewCell(style: .default, reuseIdentifier: "FlightDepartureResultResuseID")
            }
            cell?.time.text = dataArray?[indexPath.row].time
            cell?.flightNum.text = dataArray?[indexPath.row].flightNum
            cell?.flightInfo.text = dataArray?[indexPath.row].flightInfo
            cell?.endTime.text = dataArray?[indexPath.row].endTime
            return cell!
        }
        
        if indexPath.row%2 == 0 {
            cell?.contentView.backgroundColor = UIColor(red: 248/256.0, green: 248/256.0, blue: 248/256.0, alpha: 1.0)
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataArray?.count)!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let inAppWebView = InAppWebViewController()
        navigationController?.pushViewController(inAppWebView, animated: true)
    }
}
