//
//  SettingViewController.swift
//  bubbleGame
//
//  Created by Master_Cloud on 3/5/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    static var time = 50
    static var numOfBubbles = 12
    static var mode = "normal"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func testvar(){
        time = 60
        numOfBubbles = 12
    }
    

    @IBAction func touchHard(_ sender: UIButton) {
        SettingViewController.time = 60
        SettingViewController.numOfBubbles = 15
        SettingViewController.mode = "hard"
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
