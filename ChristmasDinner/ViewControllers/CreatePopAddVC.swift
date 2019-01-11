//
//  CreatePopAddVC.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 10/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

protocol CreatePopAddVCDelegate: class {
    func createPopAddVC(_ vc: CreatePopAddVC, didEditParticipant: Participant)
}

class CreatePopAddVC: UIViewController {

    internal weak var repository: RepositoryLocalParticipant!
    internal weak var delegate: CreatePopAddVCDelegate!
    @IBOutlet weak var enterName: UITextField!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var createPop: UIView!
    
    convenience init(_ repository:RepositoryLocalParticipant!){
        self.init()
        self.repository = repository
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnAdd.setTitle("Add", for: .normal)
        btnAdd.layer.cornerRadius = 5.0
        btnAdd.layer.masksToBounds = true
        createPop.layer.cornerRadius = 8.0
        createPop.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addNewParticipant() {
        let participant = Participant()
        participant.id  = UUID().uuidString
        participant.name = enterName.text!
        participant.paidState = false
        
   
        UIView.animate(withDuration: 0.4, animations: {
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.0)
        }) { (bool) in
            if self.repository.create(a: participant) {
                self.delegate?.createPopAddVC(self, didEditParticipant: participant)
            }
        }
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
