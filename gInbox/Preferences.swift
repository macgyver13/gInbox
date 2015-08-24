//
//  Util.swift
//  gInbox
//
//  Created by Chen Asraf on 11/11/14.
//  Copyright (c) 2014 Chen Asraf. All rights reserved.
//

import Foundation

class Preferences {
  
  class func getDefaults() -> NSUserDefaults {
    return NSUserDefaults.standardUserDefaults()
  }
  
  class func clearDefaults() -> Void {
    let path                = NSBundle.mainBundle().pathForResource("Defaults", ofType: "plist")!
    let dic                 = NSDictionary(contentsOfFile: path)!
    let productIdentifier   = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleIdentifier") as! String
    
    getDefaults().removePersistentDomainForName(productIdentifier)
    //use this function to push to disk xcdoc://?url=developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSUserDefaults_Class/index.html#//apple_ref/occ/instm/NSUserDefaults/setPersistentDomain:forName:
    getDefaults().setPersistentDomain(dic as [NSObject: AnyObject], forName: productIdentifier)
  }
  
  class func getInt(key: String) -> Int? {
    return getDefaults().integerForKey(key)
  }
  
  class func getString(key: String) -> String? {
    return getDefaults().stringForKey(key)
  }
  
  class func setString(key: String, value: String) {
    return getDefaults().setObject(value, forKey: key)
  }
  
  class func getFloat(key: String) -> Float? {
    return getDefaults().floatForKey(key)
  }
  
  class func getBool(key: String) -> Bool? {
    return getDefaults().boolForKey(key)
  }
  
  class func getArray(key: String) -> AnyObject? {
    return getDefaults().arrayForKey(key)
  }
  
  class func setArray(key: String, value: AnyObject) {
    getDefaults().setObject(value, forKey: key)
  }
  
}