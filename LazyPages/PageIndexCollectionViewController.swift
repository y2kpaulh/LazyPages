//
//  PageIndexCollectionViewController.swift
//  LazyPages
//
//  Created by Vargas Casaseca, Cesar on 24.03.16.
//  Copyright © 2016 WeltN24. All rights reserved.
//

import Foundation
import UIKit

public protocol PageIndexCollectionViewControllerDataSource: class {
  /**
   The cell to be shown at the the given index
   
   - parameter collectionView: the collection view where the index is represented
   - parameter indexPath: the index path of the requested cell
   */
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
}

/// This class represents the index of the page controller, a view controller containing a collection view
public class PageIndexCollectionViewController: UIViewController {
  public weak var pageController: PageController?
  public weak var dataSource: PageIndexCollectionViewControllerDataSource?
  
  @IBOutlet public weak var collectionView: UICollectionView!
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    collectionView.dataSource = self
    collectionView.delegate = self
  }
}

extension PageIndexCollectionViewController: UICollectionViewDataSource {
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    assert(dataSource != nil, "The data source of the PageIndexCollectionViewController cannot be nil")
    return dataSource!.collectionView(collectionView: collectionView, cellForItemAtIndexPath: indexPath as NSIndexPath)
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    assert(pageController != nil, "The page controller reference in the PageIndexCollectionViewController cannot be nil")
    return pageController!.numberOfItems
  }
}

extension PageIndexCollectionViewController: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let index = indexPath.row
    pageController?.goToIndex(index: index)
    collectionView.scrollToItem(at: indexPath as IndexPath, at: .centeredHorizontally, animated: true)
  }
}
