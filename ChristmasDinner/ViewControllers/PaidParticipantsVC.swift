//
//  PaidParticipantsVC.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 11/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

class PaidParticipantsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    internal var participant: [Participant]!
    internal var repository: RepositoryLocalParticipant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repository = RepositoryLocalParticipant()
       
        
         title = "Paid Participants"
        tabBarController?.navigationItem.title = "Paid Participants"
        
      
    
        
        
        registerCell()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.8){
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.8)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    internal func registerCell(){
        let identifier = "PaidTableViewCell"
        let nib = UINib(nibName: identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: identifier)
        
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


extension PaidParticipantsVC : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participant.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        participant[indexPath.row].paidState = !participant[indexPath.row].paidState
       
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PaidTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PaidTableViewCell", for: indexPath) as! PaidTableViewCell
        
        let participants = participant[indexPath.row]
        if(participants.paidState==true){
            cell.lblNameP.text = participants.name
            cell.tickBox.image = UIImage(named: "Dollar")
        }else{
            repository.delete(a: participants)
            participant.remove(at: indexPath.row)
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    

        return cell
    }
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle , forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let participantToDelete = participant[indexPath.row]
            if repository.delete(a: participantToDelete){
                participant.remove(at: indexPath.row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
            }
        }
    }
}

extension PaidParticipantsVC: CreatePopAddVCDelegate {
    func createPopAddVC(_ vc:CreatePopAddVC, didEditParticipant participants: Participant) {
        vc.dismiss(animated: true) {
            self.repository = RepositoryLocalParticipant()
            self.participant = self.repository.getAll()
            self.tableView.reloadData()
        }
    }
}

