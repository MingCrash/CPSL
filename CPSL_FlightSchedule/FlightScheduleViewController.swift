//
//  FlightSchedule.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/17.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import Foundation
import UIKit

class FlightScheduleViewController: UIViewController {
    let searchHistoryView = SearchHistoryTableViewController()
    var isDisplayArrivalresult = true
    @IBAction func SegmentSelector(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            isDisplayArrivalresult = true
            flightResult_Arrival.reloadData()
            flightResultScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        }else{
            isDisplayArrivalresult = false
            flightResult_Departure.reloadData()
            flightResultScrollView.setContentOffset(CGPoint(x: SCREEN_WIDTH, y: 0), animated: true)
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
        flightResult_Arrival.delegate = self
        flightResult_Arrival.dataSource = self
        flightResult_Departure.delegate = self
        flightResult_Departure.dataSource = self
    }
    
    private func setupNavigationBar() {
        let backButton = UIButton()
        backButton.setTitle("FLIGHT SCHEDULE", for: .normal)
        backButton.setTitleColor(UIColor.black, for: .normal)
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
        
        if isDisplayArrivalresult{
            tableView.isEqual(flightResult_Arrival)
        }else{
            tableView.isEqual(flightResult_Departure)
        }
        
        var cell: FlightResultTableViewCell? = nil
        
        cell = tableView.dequeueReusableCell(withIdentifier: "FlightArrivalResultResuseID") as? FlightResultTableViewCell
        if cell == nil{
            cell = FlightResultTableViewCell(style: .default, reuseIdentifier: "FlightArrivalResultResuseID")
        }
        
        
        if indexPath.row%2 == 0 {
            cell?.contentView.backgroundColor = UIColor(red: 248/256.0, green: 248/256.0, blue: 248/256.0, alpha: 1.0)
        }
        
//        cell?.time.text = "Row \(indexPath.row)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isDisplayArrivalresult{
            tableView.isEqual(flightResult_Arrival)
        }else{
            tableView.isEqual(flightResult_Departure)
        }

        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isDisplayArrivalresult{
            tableView.isEqual(flightResult_Arrival)
        }else{
            tableView.isEqual(flightResult_Departure)
        }

        return 1
    }
}
