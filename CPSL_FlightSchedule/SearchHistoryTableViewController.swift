//
//  SearchHistoryTableViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/18.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

@objc protocol responseToMainPageBySelectingHistory{
    func response(by SelectingHistory: String)
}

class SearchHistoryTableViewController: UITableViewController {

    var historySelection: [String]? = []
    var delegate: AnyObject? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return historySelection?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView(reuseIdentifier: "SearchHistoryHeaderViewID")
        headerView.textLabel?.text = "Search History"
        headerView.backgroundColor = UIColor.gray
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 28.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var reuseCell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "SearchHistoryCellID")
        if reuseCell == nil {
            reuseCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "SearchHistoryCellID")
        }else{
            reuseCell?.textLabel?.text = nil
        }
        reuseCell?.textLabel?.text = historySelection?[indexPath.row].description
        return reuseCell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if delegate != nil && (delegate?.responds(to: #selector(responseToMainPageBySelectingHistory.response(by:))))! {
            delegate?.response(by: (historySelection?[indexPath.row].description)!)
        }
    }

}
