//
//  GameViewController.swift
//  bubbleGame
//
//  Created by Master_Cloud on 1/5/18.
//  Copyright © 2018 Master_Cloud. All rights reserved.
//

import Foundation
import UIKit

class GameViewController:UIViewController {
    var game = Game()
    var bubbleButton = [UIButton:Bubble]()
    var buttons = [UIButton]()
    
    @IBOutlet weak var bubble: UIButton!
    
    //set random position for buttons
    func positionOfButton(button: inout UIButton) {
        let buttonWidth = CGFloat(50)
        let buttonHeight = CGFloat(50)
        
        // Find the width and height of the enclosing view
        let viewWidth = button.superview!.bounds.width
        let viewHeight = button.superview!.bounds.height
        
        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - buttonWidth
        let yheight = viewHeight - buttonHeight
        
        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        // Offset the button's center by the random offsets.
        button.center.x = xoffset + buttonWidth / 2
        button.center.y = yoffset + buttonHeight / 2
        button.frame = CGRect(x: button.center.x, y: button.center.y, width: 50, height: 50)
    }
    
    func createButtons(){
        while overlapWithOther(buttons:buttons) && buttons.isEmpty{
            generateUnverifyButtons(numOfBubble: game.numOfBubbles)
        }
        for index in buttons.indices{
            buttons[index].backgroundColor = UIColor.white
            buttons[index].addTarget(self, action: #selector(explosion), for: .touchUpInside)
        }
    }
    
    func generateUnverifyButtons(numOfBubble:Int) {
        for index in 0..<numOfBubble {
            var button = UIButton.init(type:.custom)
            positionOfButton(button: &button)
            buttons[index] = button
        }
    }
    
    func colourButtons(bubbles:[Bubble]){
        for index in buttons.indices{
            bubbleButton[buttons[index]] = bubbles[index]
            buttons[index].setImage(UIImage(named:(bubbleButton[buttons[index]]!.colour+".jpg")), for: UIControlState.normal)
        }
    }
    
    func overlapWithOther(buttons:[UIButton]) -> Bool{
        for index0 in 0..<buttons.count-1 {
            for index1 in (index0+1)..<buttons.count{
                if buttons[index0].frame.intersects(buttons[index1].frame){
                    return true
                }
            }
        }
        return false
    }
    
    func updateViewFromModel(){
        bubble.frame.origin = CGPoint(x: 10, y: 10)
        bubble.setImage(UIImage(named: "red.jpg"), for: UIControlState.normal)
    }
    
    
    @objc func explosion(_ sender: UIButton){
        guard let indexOfButton = buttons.index(of: sender) else {exit(3)}
        sender.removeFromSuperview()
        bubbleButton.removeValue(forKey: sender)
        buttons.remove(at: indexOfButton)
        game.touchBubbles(at: indexOfButton)
    }
    @IBAction func touchBubble(_ sender: UIButton) {
        updateViewFromModel()
    }
    
    func call() {
        createButtons()
        colourButtons(bubbles: game.bubbles)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for index in buttons.indices{
            self.view.addSubview(buttons[index])
        }
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}
