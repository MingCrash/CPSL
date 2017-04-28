//
//  SearchTableViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/26.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

protocol SearchViewControllerResultUpdatingDelegate {
   func updateSearchResultsForSearchController(on SearchView: SearchResultViewController)
}

class SearchResultViewController: UITableViewController{
    
    var searchResultsUpdater: SearchViewControllerResultUpdatingDelegate? = nil
    var filterDataAarry: [String]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    //KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == searchText_KeyPath {
            print("observe something")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return (filterDataAarry?.count)!+1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return 50.0
        }else if indexPath.section == 1 && indexPath.row == 0{
            return 28.0
        }
        return 40.0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: SearchTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "Cell") as? SearchTableViewCell
        if cell == nil {
            cell = SearchTableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        
        if indexPath.row == 0 && indexPath.section == 1{
            cell?.label?.text = "Suggested Search Terms"
        }
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 300, height: 20))
        label.text = "test!!"
        headerView.addSubview(label)
        return headerView
    }

}
