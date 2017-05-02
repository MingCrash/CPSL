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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: "SearchResultCell")
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
            return 2
        }
        return filterDataAarry?.count ?? 0
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
        
        var cell: SearchTableViewCell? = nil
        
        if indexPath.section == 0 {
            cell = SearchTableViewCell(style: .default, reuseIdentifier: "SearchResultCell")
            if indexPath.row == 0 {
                cell?.label?.text = "Search For:'"+(currentSearchString?.description)!+"'"
                cell?.isSelected = false
            }
            if indexPath.row == 1 {
                cell?.label?.text = "Suggested Search Terms"
                cell?.isSelected = false
            }
            return cell!
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell") as? SearchTableViewCell
            if cell == nil {
                cell = SearchTableViewCell(style: .default, reuseIdentifier: "SearchResultCell")
            }else{
                cell?.label?.text = nil
            }
            cell?.label?.text = filterDataAarry?[indexPath.row].flightNum
        }
        return cell!
    }
}
