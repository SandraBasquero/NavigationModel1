//
//  LeftMenu.swift
//  NavigationModel1
//
//  Created by X50207BA on 14/12/16.
//  Copyright © 2016 Sandra. All rights reserved.
//

import UIKit
import SVGPath

protocol LeftMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class LeftMenu: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //========================================================================
    // MARK: - Variables
    //========================================================================
    
    //Transparent button to hide menu
    @IBOutlet var closeLeftMenuBtn: UIButton!
    @IBOutlet weak var tableMenuOptions: UITableView!
    var arrayMenuOptions = [Dictionary<String,String>]() //Array containing menu options
    var btnMenu : UIButton! //Menu button which was tapped to display the menu
    var delegate : LeftMenuDelegate? //Delegate of the LeftMenuDelegate
    
    //========================================================================
    // MARK: - View Loads
    //========================================================================
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
    
    //========================================================================
    // MARK: - Fill array with options for the menu
    //========================================================================
    func updateArrayMenuOptions(){
        arrayMenuOptions.append(["title":"Inicio", "icon":"HomeIcon"])
        arrayMenuOptions.append(["title":"Actualidad", "icon":"iconos-39-20px"])
        tableMenuOptions.reloadData()
    }
    
    //========================================================================
    // MARK: - Select option and close menu
    //========================================================================
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

    //========================================================================
    // MARK: - Table View
    //========================================================================
    
    // Number of cells in the menu table view ========================
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenuOptions.count
    }
    
    // Fill cells with options from the array ========================
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellMenu")!
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.layoutMargins = UIEdgeInsets.zero
        cell.preservesSuperviewLayoutMargins = false
        cell.backgroundColor = UIColor.clear
        
        let lblTitle : UILabel = cell.contentView.viewWithTag(101) as! UILabel
        let imgIcon : UIImageView = cell.contentView.viewWithTag(99) as! UIImageView
        
        lblTitle.text = arrayMenuOptions[indexPath.row]["title"]!
        imgIcon.image = UIImage(named: arrayMenuOptions[indexPath.row]["icon"]!)
        imgIcon.tintColor = UIColor.white
        
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
