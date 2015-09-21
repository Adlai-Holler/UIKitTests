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
private final class TestCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
	var items: [String] = []
	var sizeQueryCount = 0
	
	override func viewDidLoad() {
		super.viewDidLoad()
		collectionView?.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
	}
	
	private override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return items.count
	}
	
	private override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath)
		return cell
	}
	
	@objc private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
		sizeQueryCount++
		return CGSize(width: 100, height: 100)
	}
	
}

class UICollectionViewTests: XCTestCase {
	
	private var vc: TestCollectionViewController!
	var window: UIWindow!
	override func setUp() {
		super.setUp()
		if window == nil {
			window = UIWindow(frame: UIScreen.mainScreen().bounds)
		}
		vc = TestCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
		vc.items = (0..<50).map { String($0) }
		window.rootViewController = vc
		window.makeKeyAndVisible()
	}
	
	func testThatItRequeriesAllSizesAfterEmptyUpdate() {
		NSRunLoop.mainRunLoop().runUntilDate(NSDate(timeIntervalSinceNow: 0.1))
		let oldCount = vc.sizeQueryCount
		vc.collectionView?.performBatchUpdates({}, completion: { _ in })
		let newCount = vc.sizeQueryCount
		XCTAssertEqual(oldCount + vc.items.count, newCount)
	}
	
}
