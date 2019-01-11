//
//  MainController.swift
//  ChristmasDinner
//
//  Created by GUILLERMO CRESPO AGUAYO on 11/1/19.
//  Copyright © 2019 GUILLERMO CRESPO AGUAYO. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        // Do any additional setup after loading the view.
    }

    func setupTabBar(){
        let allParticipants = UINavigationController(rootViewController: ParticipantsViewController())
        
        let paidParticipants = UINavigationController(rootViewController: PaidParticipantsVC())
    
        viewControllers = [allParticipants, paidParticipants]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
