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
        arrayMenuOptions.append(["title":"Inicio"])
        arrayMenuOptions.append(["title":"Actualidad"])
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
        //imgIcon.image = UIImage(named:"HomeIcon")
        //imgIcon.tintColor = UIColor.red
        imgIcon.layer .addSublayer(getIconImage(optNum: indexPath.row))
        
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
    
    
    //========================================================================
    // MARK: - Utils
    //========================================================================
    func getIconImage(optNum:Int) -> CAShapeLayer {
        let pathz:UIBezierPath?
        
        switch optNum {
        case 0:
             pathz = UIBezierPath(svgPath: "M33,14.8c0-0.2,0-0.4-0.2-0.6L19.5,2c-0.3-0.2-0.6-0.2-0.9,0L5.3,13.9C5.3,13.9,5.2,14,5.2,14H5.1v18.3c0,0.7,0.6,1.2,1.3,1.2H14v0.8h1.3V24.1h7.5v10.2h1.3v-0.8h7.5c0.7,0,1.3-0.5,1.3-1.2L33,14.8L33,14.8z M31.7,32.2h-7.5v-8.8c0-0.4-0.3-0.7-0.7-0.7h-8.9c-0.4,0-0.7,0.3-0.7,0.7v8.8l-7.5,0V14.6L19,3.3L31.7,15V32.2z")
        case 1:
            pathz = UIBezierPath(svgPath: "M18,35C8.8,35,1.4,27.6,1.4,18.6c0-7.3,5-13.8,12-15.8c0.4-0.1,0.8,0.1,0.9,0.5c0.1,0.4-0.1,0.8-0.5,0.9 c-6.5,1.8-11,7.8-11,14.4c0,8.3,6.8,15,15.2,15s15.2-6.7,15.2-15c0-6-3.6-11.5-9.3-13.8c-0.4-0.2-0.6-0.6-0.4-1 c0.2-0.4,0.6-0.6,1-0.4c6.2,2.6,10.2,8.5,10.2,15.2C34.6,27.6,27.2,35,18,35z M23.7,13.5c-0.4,0-0.7-0.3-0.7-0.7V2h10.9c0.4,0,0.7,0.3,0.7,0.7s-0.3,0.7-0.7,0.7h-9.5v9.3C24.4,13.2,24.1,13.5,23.7,13.5z M25.5,21.3h-10V10.1c0-0.4,0.3-0.7,0.7-0.7S17,9.7,17,10.1v9.7h8.5c0.4,0,0.7,0.3,0.7,0.7S25.9,21.3,25.5,21.3z")
        default:
            pathz = nil
        }
        
        let icon:CAShapeLayer = CAShapeLayer()
        icon.path = pathz?.cgPath
        return icon
    }
    
}
