//
//  ViewController.swift
//  testUI
//
//  Created by alex on 1/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var turnLabel: UILabel!
    
    @IBOutlet weak var a1: UIButton!
    @IBOutlet weak var a2: UIButton!
    @IBOutlet weak var a3: UIButton!
    @IBOutlet weak var b1: UIButton!
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var b3: UIButton!
    @IBOutlet weak var c1: UIButton!
    @IBOutlet weak var c2: UIButton!
    @IBOutlet weak var c3: UIButton!
    
    
    
    var board = [UIButton]()
    enum Turn : String{
        case NOUGHT = "O"
        case CROSS = "X"
    }
    
    var firstTurn = Turn.CROSS
    var currentTurn = Turn.CROSS
    
    var header : String!
    var message : String!
    var crossScore : Int = 0
    var noughtScore : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initBoard()
    }

    
    @IBAction func boardTapAction(_ sender: UIButton) {
        addToBoard(sender)
        
        let mark = sender.title(for: UIControl.State.normal)!//we implicictly unwrap the optional since it's the button the user just clicked it
        if(threeInARow(value: mark)){
            if mark==Turn.CROSS.rawValue {
                crossScore += 1
            }else{
                noughtScore += 1
            }
            
            header = "\(Turn.CROSS) Win!"
            message = "\(Turn.CROSS) Win: \(crossScore)\n \(Turn.NOUGHT) Win: \(noughtScore)"
            showResult(title: header, message: message)
            return
        }
        
        if boardIsFull() {
            showResult(title: "Draw", message: "")
        }
    }
    
    func addToBoard (_ sender: UIButton){
        if sender.title(for: UIControl.State.normal) == nil {
            if currentTurn == Turn.CROSS {
                sender.setTitle(Turn.CROSS.rawValue, for: UIControl.State.normal)
                turnLabel.text = Turn.NOUGHT.rawValue
                currentTurn = Turn.NOUGHT
            }else if currentTurn == Turn.NOUGHT{
                sender.setTitle(Turn.NOUGHT.rawValue, for: UIControl.State.normal)
                turnLabel.text = Turn.CROSS.rawValue
                currentTurn = Turn.CROSS
            }
            sender.isEnabled = false
        }
    }
    
    func initBoard(){
        board.append(a1)
        board.append(a2)
        board.append(a3)
        board.append(b1)
        board.append(b2)
        board.append(b3)
        board.append(c1)
        board.append(c2)
        board.append(c3)
    }
    
    func resetBoard(){
        //clean all buttons and enable it
        for button in board {
            button.setTitle(nil, for: UIControl.State.normal)
            button.isEnabled = true
        }
        //regardless of the game's result, we want to make the players take turns
        if firstTurn == Turn.CROSS {
            firstTurn = Turn.NOUGHT
            turnLabel.text = Turn.NOUGHT.rawValue
        }else{
            firstTurn = Turn.NOUGHT
            turnLabel.text = Turn.CROSS.rawValue
        }
    }
    
    func boardIsFull() -> Bool {
        for button in board{
            if button.title(for: UIControl.State.normal) == nil {
                return false
            }
        }
        return true
    }
    
    func showResult(title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        let resetAction = UIAlertAction(title: "Reset", style: UIAlertAction.Style.default){
            UIAlertAction in self.resetBoard()
        }
        
        alertController.addAction(resetAction)
        self.present(alertController, animated: true)
        
    }
    
    func buttonHasValue(button: UIButton, value: String) -> Bool {
        return button.title(for: UIControl.State.normal) == value
    }
    
    func threeInARow(value : String) -> Bool {
        //check the win in any of the 3 rows
        if buttonHasValue(button: a1, value: value) && buttonHasValue(button: a2, value: value) && buttonHasValue(button: a3, value: value){
            return true;
        }
        if buttonHasValue(button: b1, value: value) && buttonHasValue(button: b2, value: value) && buttonHasValue(button: b3, value: value){
            return true
        }
        if buttonHasValue(button: c1, value: value) && buttonHasValue(button: c2, value: value) && buttonHasValue(button: c3, value: value){
            return true
        }
        //check the win in any of the 3 columns
        if buttonHasValue(button: a1, value: value) && buttonHasValue(button: b1, value: value) && buttonHasValue(button: c1, value: value){
            return true
        }
        if buttonHasValue(button: a2, value: value) && buttonHasValue(button: b2, value: value) && buttonHasValue(button: c2, value: value){
            return true
        }
        if buttonHasValue(button: a3, value: value) && buttonHasValue(button: b3, value: value) && buttonHasValue(button: c3, value: value){
            return true
        }
        //check diagonal victories
        if buttonHasValue(button: a1, value: value) && buttonHasValue(button: b2, value: value) && buttonHasValue(button: c3, value: value){
            return true
        }
        if buttonHasValue(button: c1, value: value) && buttonHasValue(button: b2, value: value) && buttonHasValue(button: a3, value: value){
            return true
        }
        return false
    }
    
}

