//
//  LeftMenu.swift
//  NavigationModel1
//
//  Created by X50207BA on 14/12/16.
//  Copyright © 2016 Sandra. All rights reserved.
//

import UIKit

protocol LeftMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class LeftMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var closeLeftMenuBtn: UIButton!
    @IBOutlet weak var tableMenuOptions: UITableView!
    var arrayMenuOptions = [Dictionary<String,String>]()
    var btnMenu : UIButton! //Menu button which was tapped to display the menu
    var delegate : LeftMenuDelegate? //Delegate of the LeftMenuDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableMenuOptions.tableFooterView = UIView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateArrayMenuOptions()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fill menu with options
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Home"])
        arrayMenuOptions.append(["title":"Play"])
        tableMenuOptions.reloadData()
    }
    
     // MARK: - Close Left Menu
    @IBAction func closeLeftMenu(_ button: UIButton!) {
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if button == closeLeftMenuBtn {
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParentViewController()
        })
    }

    
    // MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        //let imgIcon : UIImageView = cell.contentView.viewWithTag(100) as! UIImageView
        
      //  imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: UIButtonType.custom)
        btn.tag = indexPath.row
        self.closeLeftMenu(btn)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
}
