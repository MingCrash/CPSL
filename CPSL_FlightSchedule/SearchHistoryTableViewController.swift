//
//  SearchHistoryTableViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/18.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class SearchHistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
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
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 20.0
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var reuseCell: SearchHistoryTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchHistoryTableViewCell
        
        if reuseCell == nil {
            reuseCell = SearchHistoryTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        }
        
        if indexPath.row == 0 {
            reuseCell?.label?.text = "Search History"
        }else {
            reuseCell?.label?.text = "empty"
        }
        
        return reuseCell!
    }
    
}