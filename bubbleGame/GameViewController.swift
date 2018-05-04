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
    var maxOfBubbles = SettingViewController.numOfBubbles
    var time = SettingViewController.time
    var currentMark = 0{
        willSet(newValue){
            if currentMark == newValue {
                addMark = Int(round(Double(addMark)*1.5))
            }
            else{
                addMark = newValue
            }
        }
    }
    var addMark = 0
    var totalMark = 0
    var timer = Timer()
    var times = 0
    var fatimes = 0
    
    @IBOutlet weak var Score: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func bubblesCount(){
        print ("\(bubbles.indices)")
    }
    func changeTotalMark(){
        totalMark += addMark
    }
    func displayCurrent(){
        timeLabel.text = "Time: \(time)"
        Score.text = "Score: \(totalMark)"
    }
    @objc func start(){
        time -= 1
        if time == 0 {
            timer.invalidate()
        }
        else{
            changeBubble(numOfChange: numOfChangedBubbles())
            addFunction()
        }
        displayCurrent()
        bubblesCount()
    }
    
    func runTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(start), userInfo: nil, repeats: true)
    }
    func changeBubble(numOfChange: Int){
        var changed = numOfChange
        
        while changed > 0 {
            if bubbles.count == 0{
                var newbubble = randomBubble()
                while !withinTheView(testBubble: newbubble){
                    newbubble.removeFromSuperview()
                    newbubble = randomBubble()
                }
                bubbles.append(newbubble)
                print ("\(newbubble.superview!.center.x)")
                changed -= 1
            }else {
                var newbubble = randomBubble()
                while singleOverlap(testBubble: newbubble, remainBubbles: bubbles) || !withinTheView(testBubble: newbubble)
                {
                    newbubble.removeFromSuperview()
                    newbubble = randomBubble()
                }
                bubbles.append(newbubble)
                changed -= 1
            }
        }
        while changed < 0 {
            bubbles = bubbles.filter{ $0.touched == false}
            let indexOfBubbles = Int(arc4random_uniform(UInt32(bubbles.count)))
            print ("will removed: \(indexOfBubbles)")
            let removedBubble  = bubbles.remove(at: indexOfBubbles)
            removedBubble.removeFromSuperview()
//            let removedBubble = bubbles.removeLast()
//            removedBubble.removeFromSuperview()
            changed += 1
        }
    }
    
    func randomBubble() -> Bubble{
        var newbubble = Bubble()
        self.view.addSubview(newbubble)
        positionOfButton(bubble: &newbubble)
        return newbubble
    }
    
    func positionOfButton(bubble:inout Bubble){
        let buttonWidth = CGFloat(50)
        let buttonHeight = CGFloat(50)
        
        // Find the width and height of the enclosing view
        let viewWidth = bubble.superview!.bounds.width
        let viewHeight = bubble.superview!.bounds.height
        
        // Compute width and height of the area to contain the button's center
        let xwidth = viewWidth - buttonWidth - 15
        let yheight = viewHeight - buttonHeight - 100
        
        // Generate a random x and y offset
        let xoffset = CGFloat(arc4random_uniform(UInt32(xwidth)))
        let yoffset = CGFloat(arc4random_uniform(UInt32(yheight)))
        
        // Offset the button's center by the random offsets.
        bubble.center.x = xoffset + buttonWidth / 2
        bubble.center.y = yoffset + buttonHeight / 2
        bubble.frame = CGRect(x: bubble.center.x, y: bubble.center.y, width: 50, height: 50)
    }
    
    
    func singleOverlap(testBubble:Bubble,remainBubbles:[Bubble]) -> Bool{
        for bubble in remainBubbles {
            if testBubble.frame.intersects(bubble.frame){
                times += 1
                return true
            }
        }
        fatimes += 1
        return false
    }
    
    func withinTheView(testBubble: Bubble) -> Bool{
//        let limitedWidth = testBubble.superview!.bounds.width
//        let limitedHeigh = testBubble.superview!.bounds.height
//        let newFrame = CGRect(x: testBubble.superview!.center.x, y:testBubble.superview!.center.y, width: limitedWidth, height: limitedHeigh)
//        return newFrame.contains(testBubble.frame)
        return testBubble.superview!.frame.contains(testBubble.frame)
    }
    
    func numOfChangedBubbles() -> Int{
        bubbles = bubbles.filter{ $0.touched == false}
        let remainBubbles:Int
        let remainPosition:Int
        var finalChange:Int
        remainBubbles = bubbles.count
        remainPosition = maxOfBubbles - remainBubbles
        finalChange = Int(arc4random_uniform(UInt32(remainPosition+1))) - Int(arc4random_uniform(UInt32(remainBubbles+1)))
        return finalChange
    }
    
    func touchBubbles(at bubble:Int){
        bubbles[bubble].touched = true
    }
    
    func addFunction(){
        for bubble in bubbles {
            bubble.addTarget(self, action: #selector(explosion), for: .touchUpInside)
        }
    }
    
    @objc func explosion(_ sender: Bubble){
        guard let indexOfButton = bubbles.index(of: sender) else {exit(3)}
        sender.removeFromSuperview()
        touchBubbles(at: indexOfButton)
        print("touch: \(indexOfButton)")
        currentMark = sender.score
        changeTotalMark()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstTime = Int(arc4random_uniform(UInt32(maxOfBubbles))) + 1
        changeBubble(numOfChange: firstTime)
        addFunction()
        bubblesCount()
        runTimer()
        print ("times:\(times)")
        print("\(fatimes)")
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
}

