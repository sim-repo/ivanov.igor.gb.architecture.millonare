//
//  MenuViewController.swift
//  ivanov.igor.gb.architecture.millonare
//
//  Created by Igor Ivanov on 03.09.2020.
//  Copyright © 2020 Igor Ivanov. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Game.shared.didViewAppear()
    }
    
    
    private func setup(){
        Game.shared.setViewController(vc: self)
    }
}


//MARK:- button actions
extension MenuViewController {
    
    @IBAction func pressPlay(_ sender: Any) {
        Game.shared.didPressGameStart()
        performSegue(withIdentifier: "seguePlay", sender: nil)
    }
    
    @IBAction func pressResults(_ sender: Any) {
        Game.shared.didPressResults()
        performSegue(withIdentifier: "segueResults", sender: nil)
    }
}


//MARK:- segue actions
extension MenuViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seguePlay",
            let vc = segue.destination as? GameViewController {
                guard let session = Game.shared.getGameSession() as? GameSessionProtocolDelegate else { return }
                vc.setup(gameSession: session)
                return
        }
        
        if segue.identifier == "segueResults",
            let vc = segue.destination as? ResultsViewController {
                return
            }
        }
}
