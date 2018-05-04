//
//  NameViewController.swift
//  bubbleGame
//
//  Created by Master_Cloud on 3/5/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {


    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var finish: UIButton!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        bothButtonTofalse()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToName(_ sender: UIStoryboardSegue ){
    
    }
    
 
    @IBAction func textChange(_ sender: Any) {
        if validateInput(text: name.text!){
            bothButtonToTrue()
        }else {
            bothButtonTofalse()
            
        }
    }
    
    
    
    func validateInput(text: String) -> Bool{
        
        if text == ""{
            return false
        }
        return true
        
    }
  
    @IBAction func touchReset(_ sender: UIButton) {
        name.text = ""
        bothButtonTofalse()
    }
    
    func bothButtonToTrue(){
        finish.isEnabled = true
        reset.isEnabled = true
    }
    func bothButtonTofalse(){
        finish.isEnabled = false
        reset.isEnabled = false
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
