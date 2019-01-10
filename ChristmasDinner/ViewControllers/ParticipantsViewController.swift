//
//  ParticipantsViewController.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 10/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

class ParticipantsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    internal var participant: [Participant]!
    internal var repository: RepositoryLocalParticipant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.repository = RepositoryLocalParticipant()
        self.participant = self.repository.getAll()
        
        title = "Participants"
        registerCell()
        
        let addBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPressed))
        
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc internal func addPressed () {
        let createVC = CreatePopAddVC(repository)
        createVC.delegate = self
        createVC.modalTransitionStyle = .coverVertical
        createVC.modalPresentationStyle = .overCurrentContext
        
        // animacion de transicion
        UIView.animate(withDuration: 0.4, animations: {
            self.view.backgroundColor =
                UIColor.white.withAlphaComponent(0.0)
        })
        present(createVC, animated: true, completion: nil)
        
    }
    internal func registerCell(){
        let identifier = "PCell"
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


extension ParticipantsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participant.count
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        participant[indexPath.row].paidState = !participant[indexPath.row].paidState
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ParticipantsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PCell", for: indexPath) as! ParticipantsTableViewCell
        
        let participants = participant[indexPath.row]
        cell.lblNameP.text = participants.name
        cell.tickBox.isHidden = !participants.paidState
        
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

extension ParticipantsViewController: CreatePopAddVCDelegate {
    func createPopAddVC(_ vc:CreatePopAddVC, didEditParticipant: Participant) {
        vc.dismiss(animated: true) {
            self.repository = RepositoryLocalParticipant()
            self.participant = self.repository.getAll()
            self.tableView.reloadData()
        }
    }
}
