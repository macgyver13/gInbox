//
//  Settings.swift
//  gInbox
//
//  Created by Chen Asraf on 11/9/14.
//  Copyright (c) 2014 Chen Asraf. All rights reserved.
//

import Foundation
import WebKit
import AppKit

public class Settings : NSWindowController, NSWindowDelegate {
  
  lazy var webViewController = WebViewController()
  var webView: WebView!
  var urlPrefixes: [String]!
  
  @IBOutlet weak var tableView: NSTableView!
  @IBOutlet weak var userAgent: NSTextField!
  
  @IBAction func addRow(sender: AnyObject?){
    urlPrefixes.append("Change Me")
    self.tableView.reloadData()
  }
  
  @IBAction func removeRow(sender: AnyObject?){
    urlPrefixes.removeAtIndex(self.tableView.selectedRow)
    self.tableView.reloadData()
  }
  
  @IBAction func onFinishEditingTextField(sender: NSTextField) {
    
    let selectedRowNumber = self.tableView.selectedRow
    
    if selectedRowNumber != -1 {
      self.urlPrefixes[selectedRowNumber] = sender.stringValue
    }
    
  }
  
  @IBAction func resetPrefsToDefault(sender: AnyObject?) {
    Preferences.clearDefaults()
  }
  
  //MARK: - Window Management
  override public func windowDidLoad() {
    super.windowDidLoad()
    
    self.urlPrefixes = Preferences.getArray("urlPrefixes") as? [String]
    if self.urlPrefixes.isEmpty{
      self.urlPrefixes = []
    }
    
    
  }
  
  public override func showWindow(sender: AnyObject?) {
    super.showWindow(sender)
    
  }
  
  public func showWindow(sender: AnyObject?, webView:WebView!) {
    super.showWindow(sender)
    
    self.webView = webView
  }
  
  public func windowWillClose(notification: NSNotification) {
    Preferences.setArray("urlPrefixes", value: self.urlPrefixes)
    Preferences.setString("userAgentString",value:userAgent.stringValue)
    var webUA = Preferences.getString("userAgentString")
    webView.customUserAgent = webUA
    webView.mainFrame.reload()
  }
}

// MARK: - NSTableViewDataSource
extension Settings: NSTableViewDataSource {
  public func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
    return self.urlPrefixes.count
  }
  
  public func tableView(tableView: NSTableView, viewForTableColumn: NSTableColumn?, row: Int) -> NSView?
  {
    let cell = tableView.makeViewWithIdentifier("URLPrefix", owner: self) as! NSTableCellView
    cell.textField!.stringValue = urlPrefixes[row]
    cell.textField!.editable = true
    return cell;
  }
  
  
}