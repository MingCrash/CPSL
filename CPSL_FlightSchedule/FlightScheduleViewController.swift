//
//  FlightSchedule.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/17.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit
import CoreData


let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
let entityName: String  = "FlightResultInfo"
let searchText_KeyPath: String = "SearchTextKeyPath"

class FlightScheduleViewController: UIViewController {
    let searchHistoryView = SearchHistoryTableViewController()
    let searchResultView = SearchResultViewController()
    var dataArray: [FlightResultInfo]? = nil
    var contentLenght: Int? = nil
    
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
        searchResultView.view.removeFromSuperview()
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
        searchResultView.view.frame = CGRect(x: 0, y: 114.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-114.0)
        searchHistoryView.view.frame = CGRect(x: 0, y: 114.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-114.0)
        
        searchResultView.searchResultsUpdater = self
        flightResult_Departure.delegate = self
        flightResult_Departure.dataSource = self
        flightResult_Departure.separatorStyle = .none
        flightResult_Arrival.delegate = self
        flightResult_Arrival.dataSource = self
        flightResult_Arrival.separatorStyle = .none
        
        setDefaultData()
        let fetchRequet = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequet.returnsObjectsAsFaults = false
        do {
            dataArray = try context.fetch(fetchRequet) as? [FlightResultInfo]
        } catch  {
            fatalError("CoreData 抓取数据失败！！")
        }
    }

    
    func setDefaultData() {
        for i in 0..<6 {
            let element = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! FlightResultInfo

            element.time = Date() as NSDate
            element.endtime = Date() as NSDate
            element.flightNum = "CX60\(i)"
            element.flightInfo = "AirPlane CX60\(i) to Cantonese"
            do {
                try context.save()
            } catch  {
                fatalError("CoreData 保存失败！！")
            }
        }
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
        
    override func didReceiveMemoryWarning() {
    }
}

extension FlightScheduleViewController: UITextFieldDelegate{
    //textField has become the first responder
    func textFieldDidBeginEditing(_ textField: UITextField) {
        cancelBtnOutlet.isHidden = false
        view.addSubview(searchHistoryView.view)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //get the lenght of the current content
        contentLenght = (textField.text?.characters.count)! + string.characters.count - range.length
        searchResultView.currentSearchString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchResultView.updateSearchResults()
        if contentLenght != 0{
            cancelBtnOutlet.isHidden = false
            searchHistoryView.view.removeFromSuperview()
            view.addSubview(searchResultView.view)
        }else{
            searchResultView.view.removeFromSuperview()
            view.addSubview(searchHistoryView.view)
        }
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchResultView.view.removeFromSuperview()
        view.addSubview(searchHistoryView.view)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

extension FlightScheduleViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let formmtter = DateFormatter()
        formmtter.dateFormat = "HH:mm"
        
        var cell: FlightResultTableViewCell? = nil
        
        if tableView.isEqual(flightResult_Arrival) {
            cell = tableView.dequeueReusableCell(withIdentifier: "FlightArrivalResultResuseID") as? FlightResultTableViewCell
            if cell == nil{
                cell = FlightResultTableViewCell(style: .default, reuseIdentifier: "FlightArrivalResultResuseID")
            }else{
                //将从重用队列里面拿出来的cell的内容清空
                cell?.time.text = nil
                cell?.endTime.text = nil
                cell?.flightNum.text = nil
                cell?.flightInfo.text = nil
            }
            cell?.time.text = formmtter.string(from: dataArray![indexPath.row].time! as Date)
            cell?.endTime.text = formmtter.string(from: dataArray![indexPath.row].endtime! as Date)
            cell?.flightNum.text = dataArray![indexPath.row].flightNum
            cell?.flightInfo.text = dataArray![indexPath.row].flightInfo
            return cell!
        }else if tableView.isEqual(flightResult_Departure){
            cell = tableView.dequeueReusableCell(withIdentifier: "FlightDepartureResultResuseID") as? FlightResultTableViewCell
            if cell == nil{
                cell = FlightResultTableViewCell(style: .default, reuseIdentifier: "FlightDepartureResultResuseID")
            }
            cell?.time.text = formmtter.string(from: dataArray![indexPath.row].time! as Date)
            cell?.endTime.text = formmtter.string(from: dataArray![indexPath.row].endtime! as Date)
            cell?.flightNum.text = dataArray![indexPath.row].flightNum
            cell?.flightInfo.text = dataArray![indexPath.row].flightInfo
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

extension FlightScheduleViewController: SearchViewControllerResultUpdatingDelegate{
    func updateSearchResultsForSearchController(){
        if contentLenght == 0 {
            searchResultView.filterDataAarry = nil
        }else{
            searchResultView.filterDataAarry = dataArray?.filter {
                ($0.flightNum?.contains(searchResultView.currentSearchString!))!
            }
        }
        searchResultView.tableView.reloadData()
    }
}
