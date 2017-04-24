//
//  MenuTableViewController.swift
//  CPSL_FlightSchedule
//
//  Created by 朱志明 on 2017/4/12.
//  Copyright © 2017年 朱志明. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var sectionAmount: Int? = 8
    
    let titleList = [
        "LOGIN",
        "HISTORY & BOOKMARKS",
        "SHIPMENT TRACKING",
        "FLIGHT SCHEDULE",
        "NOTIFCATIONS",
        "HELP DESK",
        "CHARGES",
        "MORE"
    ]
    
    let imageList = [
        "account",
        "history",
        "search",
        "plane",
        "message-2",
        "help",
        "charges",
        "more"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tableView.register(UINib(nibName: "MainPageTableViewCell", bundle: nil), forCellReuseIdentifier: "cellIdentifier")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data sourc

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(SCREEN_HEIGHT/8)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 3 {
            let mainSB = UIStoryboard(name: "Main", bundle: nil)
            let test = mainSB.instantiateViewController(withIdentifier: "FlightScheduleViewIdentity")
            
            let vc = UINavigationController(rootViewController: test)
            
            modalPresentationStyle = .pageSheet
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //先从table中的重用队列中找到可以重用的cell对象
        var cell : MainPageTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier") as? MainPageTableViewCell
        //如果队列中没有重用的cell对象，就自己建一个
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cellIdentifier") as? MainPageTableViewCell
        }
        cell?.row = indexPath.row
        cell?.delegate = self
        cell?.images.image = UIImage(named: imageList[indexPath.row])
        cell?.label.text = titleList[indexPath.row]
        
        return cell!
    }
}

