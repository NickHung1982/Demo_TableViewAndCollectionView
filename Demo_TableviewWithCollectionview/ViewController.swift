//
//  ViewController.swift
//  Demo_TableviewWithCollectionview
//
//  Created by Nick on 7/22/17.
//  Copyright © 2017 NickOwn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collectionview: UICollectionView!
    let TitleStr = ["Cell1","Cell2","Cell3"] //Title for showing on collectionview
    var currentCollectionIndex: Int! //current collection index
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        currentCollectionIndex = 0
        //Select first one collectionview cell
        self.collectionview.performBatchUpdates(nil, completion: { _ in
            let index = IndexPath(item:0, section: 0)
            let cell = self.collectionview.cellForItem(at: index)
            if let textlb = cell?.contentView.viewWithTag(1) as! UILabel! {
                textlb.textColor = UIColor.red
            }
           
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: return cell
    func ShowCell1(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1",for: indexPath) as! CustomTableViewCell1
        return cell
    }

    func ShowCell2(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2",for: indexPath) as! CustomTableViewCell2
        return cell
    }
    
    func ShowCell3(_ tableView: UITableView,_ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell3",for: indexPath) as! CustomTableViewCell3
        return cell
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if currentCollectionIndex == 0 {
            //return 1 & 3
            if indexPath.row == 0 {
                return ShowCell1(tableView,indexPath)
            }else{
                return ShowCell3(tableView,indexPath)
            }
            
        }else if currentCollectionIndex == 1 {
            //return 2 & 3
            if indexPath.row == 0 {
                return ShowCell2(tableView,indexPath)
            }else{
                return ShowCell3(tableView,indexPath)
            }
            
        }else {
            //return 3 & 1
            if indexPath.row == 0 {
                return ShowCell3(tableView,indexPath)
            }else{
                return ShowCell1(tableView,indexPath)
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return TitleStr.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for:indexPath)
        if let textlb = cell.contentView.viewWithTag(1) as! UILabel! {
            textlb.text = TitleStr[indexPath.row]
        }
        
        return cell
        
    }
}
extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        currentCollectionIndex = indexPath.row
        
        //change color
        for citem in collectionView.visibleCells {
            if let textlb = citem.contentView.viewWithTag(1) as! UILabel! {
                textlb.textColor = UIColor.lightGray
            }
            
        }
        let cell = collectionView.cellForItem(at: indexPath)
        if let textlb = cell?.contentView.viewWithTag(1) as! UILabel! {
            textlb.textColor = UIColor.red
        }
       

        
        tableview.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width / 3), height: 30)
    }
}
