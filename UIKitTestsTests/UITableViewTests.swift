//
//  UITableViewTestsTests.swift
//  UITableViewTestsTests
//
//  Created by Adlai Holler on 9/21/15.
//  Copyright © 2015 adly. All rights reserved.
//

import XCTest
import UIKit

private let cellID = "cellID"
private final class TestTableViewController: UITableViewController {
	var rows: [String] = []
	var heightQueryCount = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellID)
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return rows.count
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath)
		return cell
	}
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		heightQueryCount++
		if heightQueryCount % 50 == 0 {
			
		}
		return 64
	}
}

class UITableViewTests: XCTestCase {
	
	private var vc: TestTableViewController!
	var window: UIWindow!
    override func setUp() {
        super.setUp()
		if window == nil {
			window = UIWindow(frame: UIScreen.mainScreen().bounds)
		}
		vc = TestTableViewController(style: .Plain)
		vc.rows = (0..<50).map { String($0) }
		window.rootViewController = vc
		window.makeKeyAndVisible()
    }
    
    func testThatItRequeriesAllHeightsAfterEmptyUpdate() {
		NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1))
		let oldCount = vc.heightQueryCount
		vc.tableView.beginUpdates()
		vc.tableView.endUpdates()
		let newCount = vc.heightQueryCount
		XCTAssertEqual(oldCount + vc.rows.count, newCount)
    }
	
}
