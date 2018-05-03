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
    var bubbles = [Bubble]()
    var maxOfBubbles = 15
    var time = 60
    
    func addBubblesToView(){
        for index in bubbles.indices{
            self.view.addSubview(bubbles[index])
            positionOfButton(bubble: bubbles[index])
        }
    }
    
    
    func positionOfButton(bubble:Bubble){
        let buttonWidth = CGFloat(50)
        let buttonHeight = CGFloat(50)
        
        // Find the width and height of the enclosing view
        //        let viewWidth = self.superview!.bounds.width
        //        let viewHeight = self.superview!.bounds.height
        
        // Compute width and height of the area to contain the button's center
        let xwidth = 1000 - buttonWidth
        let yheight = 800 - buttonHeight
        
        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        // Offset the button's center by the random offsets.
        bubble.center.x = xoffset + buttonWidth / 2
        bubble.center.y = yoffset + buttonHeight / 2
        bubble.frame = CGRect(x: bubble.center.x, y: bubble.center.y, width: 50, height: 50)
    }
    
    func generateUnverifyButtons(numOfBubble:Int) {
        for _ in 0..<numOfBubble {
            bubbles.append(Bubble())
        }
    }
    
    func overlapWithOther() -> Bool{
        for index0 in 0..<(bubbles.count-1) {
            for index1 in (index0+1)..<bubbles.count{
                if bubbles[index0].frame.intersects(bubbles[index1].frame){
                    return true
                }
            }
        }
        return false
    }
    
    func finalBubbles(numOfBubble: Int){
        while overlapWithOther(){
            generateUnverifyButtons(numOfBubble: numOfBubble)
        }
    }
    
    func singleOverlap(testBubble:Bubble,remainBubbles:[Bubble]) -> Bool{
        for index in 0..<remainBubbles.count {
            if testBubble.frame.intersects(remainBubbles[index].frame){
                return true
            }
        }
        return false
    }
    
    func changeBubbles(){
        var remainBubbles:Int
        let remainPosition:Int
        var finalChange:Int
        bubbles = bubbles.filter{ $0.touched == false}
        remainBubbles = bubbles.count
        remainPosition = maxOfBubbles - remainBubbles
        finalChange = Int(arc4random_uniform(UInt32(remainPosition+1))) - Int(arc4random_uniform(UInt32(remainBubbles+1)))
        if finalChange > 0 {
            while finalChange > 0{
                var testBubble = Bubble()
                while singleOverlap(testBubble: testBubble, remainBubbles:bubbles){
                    testBubble = Bubble()
                }
                bubbles.append(testBubble)
                finalChange -= 1
            }
        } else {
            while (finalChange < 0) {
                let indexOfBubbles = Int(arc4random_uniform(UInt32(remainBubbles)))
                bubbles.remove(at: indexOfBubbles)
                finalChange += 1
                remainBubbles -= 1
            }
        }
    }
    
    func touchBubbles(at bubble:Int){
        bubbles[bubble].touched = true
    }
    
    func addFunction(to bubbles:[Bubble]){
        for index in bubbles.indices{
            bubbles[index].addTarget(self, action: #selector(explosion), for: .touchUpInside)
            self.view.addSubview(bubbles[index])
        }
    }
    
    @objc func explosion(_ sender: Bubble){
        guard let indexOfButton = bubbles.index(of: sender) else {exit(3)}
        sender.removeFromSuperview()
        touchBubbles(at: indexOfButton)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addFunction(to: bubbles)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}

