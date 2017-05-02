//
//  SearchTableViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/26.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

@objc protocol SearchViewControllerResultUpdatingDelegate {
     func updateSearchResultsForSearchController()
}

class SearchResultViewController: UITableViewController{
    
    var searchResultsUpdater: AnyObject? = nil
    var delegate: AnyObject? = nil
    var filterDataAarry: [FlightResultInfo]? = nil
    var currentSearchString: String? = nil
    var resultSelected: FlightResultInfo? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    func updateSearchResults() {
        if  searchResultsUpdater != nil && (searchResultsUpdater?.responds(to: #selector(SearchViewControllerResultUpdatingDelegate.updateSearchResultsForSearchController)))!{
            searchResultsUpdater?.updateSearchResultsForSearchController()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || filterDataAarry == nil{
            return 0
        }
        return filterDataAarry?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UITableViewHeaderFooterView(reuseIdentifier: "SearchResultHeaderViewID")
        if section == 0 {
            headerView.textLabel?.text = "Search For:'"+(currentSearchString?.description)!+"'"
        }else{
            headerView.textLabel?.text = "Suggested Search Terms"
        }
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 50.0
        }
        return 28.0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return 50.0
        }else if indexPath.section == 0 && indexPath.row == 1{
            return 28.0
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = nil
        cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCellID")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "SearchResultCellID")
        }else{
            cell?.textLabel?.text = nil
        }
        cell?.textLabel?.text = filterDataAarry?[indexPath.row].flightNum
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        resultSelected = filterDataAarry?[indexPath.row]
    }
}
