//
//  FlightResultInfo+CoreDataProperties.swift
//  
//
//  Created by 朱志明 on 2017/5/5.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension FlightResultInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FlightResultInfo> {
        return NSFetchRequest<FlightResultInfo>(entityName: "FlightResultInfo")
    }

    @NSManaged public var endtime: NSDate?
    @NSManaged public var flightInfo: String?
    @NSManaged public var flightNum: String?
    @NSManaged public var time: NSDate?

}
